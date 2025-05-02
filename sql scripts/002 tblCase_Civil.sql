
DECLARE @SELECTNUMBER INT = 10000

--CIVIL CASES

DECLARE @COURTTYPE INT = (SELECT CRT.CourtTypeID FROM tblCourtType CRT WITH (NOLOCK) WHERE CRT.CourtType = 'CV')
DECLARE @CSETYPDFLT INT = (SELECT CST.CaseTypeID FROM tblCaseType CST WITH (NOLOCK) WHERE CST.CaseType = 'CVH8') --GBDI-1110
-- DECLARE @CSETYPDFLT INT = (SELECT CST.CaseTypeID FROM tblCaseType CST WITH (NOLOCK) WHERE CST.CaseType = 'CVH1')

SET IDENTITY_INSERT tblCase ON

;WITH PLAINTIFF_cte AS
      (SELECT PL.Civil_Case_Id
             ,PL.Plaintiff_Id
             ,PL.Plaintiff_SSN
             ,ROW_NUMBER() OVER(PARTITION BY PL.Civil_Case_Id ORDER BY PL.Plaintiff_Id) AS SeqNbr
         FROM test_source.dbo.Plaintiffs PL WITH (NOLOCK))
     ,PLAINTIFF_ATT_cte AS
      (SELECT PLA.Plaintiff_Id
             ,PLA.Attorney_Id
             ,ROW_NUMBER() OVER(PARTITION BY PLA.Plaintiff_Id ORDER BY PLA.Main_Attorney DESC, PLA.Attorney_Id) AS SeqNbr
         FROM test_source.dbo.Plaintiff_Attorneys PLA WITH (NOLOCK))
     ,DEFENDANT_cte AS
      (SELECT DF.Civil_Case_Id
             ,DF.Defendant_Id
             ,DF.Defendant_SSN
             ,ROW_NUMBER() OVER(PARTITION BY DF.Civil_Case_Id ORDER BY DF.Defendant_Id) AS SeqNbr
         FROM test_source.dbo.Defendants DF WITH (NOLOCK))
     ,DEFENDANT_ATT_cte AS
      (SELECT DFA.Defendant_Id
             ,DFA.Attorney_Id
             ,ROW_NUMBER() OVER(PARTITION BY DFA.Defendant_Id ORDER BY DFA.Main_Attorney DESC, DFA.Attorney_Id) AS SeqNbr
         FROM test_source.dbo.Defendant_Attorneys DFA WITH (NOLOCK))
	,WARRANT_cte AS	--GBDI-891:Civil Cases with no Active Process have a Case Status of Warrant Pending (SEE GBDI-660)
	 (SELECT CW.Civil_Warrant_Id
			 ,CW.Case_Number
			 ,CW.Date_Issued
			 ,CW.Date_Recalled
			 ,CW.Date_Served
			 ,ROW_NUMBER() OVER(PARTITION BY CW.Case_Number ORDER BY CW.Case_Number) AS RowNum
		 FROM test_source.dbo.Civil_Warrant CW WITH (NOLOCK))
INSERT INTO tblCase
            (CaseID
            ,CaseNumber
            ,BookingNumber
            ,UniformCaseNumber
            ,FirstPlaintiffID
            ,PlaintiffAttorneyID
            ,FirstDefendantID
            ,DefendantAttorneyID
            ,DivisionID
            ,JudgeID
            ,CaseOpenDate
            ,CaseCloseDate
            ,Disposition
            ,SAOCaseNumber
            ,CaseSecurity
            ,CaseStatus
            ,ArrestingCaseNumber
            ,ArrestDate
            ,AgencyID
            ,OfficerID
            ,JurisdictionID
            ,ArrestLocationID
            ,JailNumber
            ,PartyPassword
            ,MessageType
            ,CourtTypeID
            ,CaseTypeID
            ,CountyBranchID
            ,CaseOpenYear
            ,CaseSequenceNumber
            ,DefendantIdentifier
            ,CapiasDate
            ,RearrestDate
            ,TrialType
            ,ActiveProbation
            ,ProbationStartDate
            ,ProbationEndDate
            ,ActiveProcess
            ,CustodyLocationCode
            ,ReOpenDate
            ,ReOpenReason
            ,ReOpenCloseDate
            ,WaiveSpeedyTrial
            ,SentToCollectionDate
            ,SentToCollectionAmount
            ,PIACallDate
            ,PIAFormsSentDate
            ,TransferredToCaseID
            ,TransferredDate
            ,SchoolElection
            ,DispositionCode
            ,DispositionDate
            ,DispositionJudgeID
            ,ClaimAmount
            ,JudgmentAmount
            ,JudgmentDate
            ,JudgmentCode
            ,JudgmentBookNumber
            ,JudgmentPageNumber
            ,JudgmentClerkFileNumber
            ,TitleIssueDate
            ,ForeclosureSaleDate
            ,DocStamps
            ,SaleFeePaid
            ,ProofOfPublication
            ,EstateAmount
            ,Jury
            ,Contested
            ,LettersOfAdministrationDate
            ,ServiceOfProcess
            ,AttorneyFees
            ,Interest
            ,Remark
            ,ConsolidatedToCaseID
            ,ConsolidatedDate
            ,NeedToDisburseFunds
            ,RetentionDate
            ,PurgeID
            ,PurgeDate
            ,PurgeDocumentationComplete
            ,MarriageWifeMaidenName
            ,MarriageCounty
            ,MarriageStateCode
            ,MarriageDate
            ,DissolutionNumLivingChildren
            ,DissolutionNumChildrenUnder18
            ,WifeCounty
            ,HusbandCounty
            ,JudgeSignatureDate
            ,CountryOfMarriage
            ,ComplexCaseDate
            ,AutoDispositionType
            ,GeneralNotes
            ,CertificateIssueDate
            ,CountyHeld
            ,ParcelID
            ,LegalDescription
            ,StreetAddress
            ,VerdictDate
            ,EstateTax
            ,Heirs
            ,SwornByOfficerID
            ,SwornByMagistrateID
            ,SwornByDate
            ,CreateByUserID
            ,CreateDate
            ,ModifyByUserID
            ,ModifyDate
            ,SentToCollectionAgencyID
            ,SentToJACS
            ,RedactionNeeded
            ,ForeclosureSaleAmount
            ,LowerTribunalCaseNumber
            ,BarcodeID
            ,CaseCodeID
            ,JudgmentRecordDate
            ,NeedToDisburseGarnishmentFunds
            ,ForeclosureStatus
            ,ForeclosureStatusDate
            ,ParentProbationCaseID
            ,CaseStyle
            ,CaseStyleEdited
            ,MarriageHusbandMaidenName
            ,TotalCase
            ,StatusChangeReason
            ,StatusChangeComment
            ,ExcludeFromBCCS)
  SELECT TOP (@SELECTNUMBER) 
        C.Civil_Case_Id AS CaseID
        ,ISNULL(LTRIM(RTRIM(C.Case_Number)),'') AS CaseNumber
        ,'' AS BookingNumber
        ,ISNULL(LTRIM(RTRIM(C.Case_Number)),'') AS UniformCaseNumber
        ,PP.PartyID AS FirstPlaintiffID
        ,PPA.PartyID AS PlaintiffAttorneyID
        ,PD.PartyID AS FirstDefendantID
        ,PDA.PartyID AS DefendantAttorneyID
        ,0 AS DivisionID
        --,C.Termination_Judge_Id AS JudgeID	--GBDI-903: use Termination_Judge_Id when not NULL
		,PJ.PartyID AS JudgeID
        ,C.Date_Filed AS CaseOpenDate
        ,C.Date_Closed AS CaseCloseDate
        ,ISNULL(LTRIM(RTRIM(CJ.Judgment_Rendered)),'') AS Disposition
        ,'' AS SAOCaseNumber
        ,0 CaseSecurity
        ,CASE 
              WHEN ISNULL(C.Date_Closed,'01/01/1900') <> '01/01/1900' THEN 'CLOS'
              WHEN ISNULL(CJ.Date_Of_Judgment,'01/01/1900') <> '01/01/1900' THEN 'CLOS'
              WHEN ISNULL(C.Date_Disposed,'01/01/1900') <> '01/01/1900' THEN 'CLOS'
              WHEN C.Date_Closed IS NOT NULL THEN 'CLOS'
              --WHEN CW.Date_Issued IS NOT NULL AND (CW.Date_Recalled IS NULL AND CW.Date_Served IS NULL) THEN 'WARRANTP'     --GBDI-891:Civil Cases with no Active Process have a Case Status of Warrant Pending (SEE GBDI-660)
              ELSE 'OPEN'
          END AS CaseStatus
        ,'' AS ArrestingCaseNumber
        ,NULL AS ArrestDate
        ,0 AS AgencyID
        ,0 AS OfficerID
        ,0 AS JurisdictionID
        ,0 AS ArrestLocationID
        ,'' AS JailNumber
        ,'' AS PartyPassword
        ,'' AS MessageType
        ,@COURTTYPE AS CourtTypeID
        ,ISNULL(CT.CaseTypeID,@CSETYPDFLT) AS CaseTypeID
        ,0 AS CountyBranchID
        ,CONVERT(INT,SUBSTRING(C.Case_Number,1,4)) AS CaseOpenYear  --CONVERT(INT,FORMAT(C.Date_Filed,'yyyy'))
        ,CONVERT(INT,SUBSTRING(C.Case_Number,8,5)) AS CaseSequenceNumber
        ,'' AS DefendantIdentifier
        ,NULL AS CapiasDate
        ,NULL AS RearrestDate
        ,0 AS TrialType
        ,0 AS ActiveProbation
        ,NULL AS ProbationStartDate
        ,NULL AS ProbationEndDate
        ,0 AS ActiveProcess
        ,'' AS CustodyLocationCode
        ,NULL AS ReOpenDate
        ,'' AS ReOpenReason
        ,NULL AS ReOpenCloseDate
        ,0 AS WaiveSpeedyTrial
        ,ISNULL(LWC.Date_Sent, NULL) AS SentToCollectionDate -- GBDI-47
        ,ISNULL(LWC.Amount,0) AS SentToCollectionAmount --GBDI-47
        ,NULL AS PIACallDate
        ,NULL AS PIAFormsSentDate
        ,0 AS TransferredToCaseID
        ,NULL AS TransferredDate
        ,'' AS SchoolElection
        ,ISNULL(LTRIM(RTRIM(CJ.Judgment_Rendered)),'') AS DispositionCode
        ,C.Date_Disposed AS DispositionDate
		--,C.Termination_Judge_Id AS DispositionJudgeID	--GBDI-903: use Termination_Judge_Id when not NULL
        ,PJ.PartyID AS DispositionJudgeID
        ,ISNULL(TRY_CONVERT(MONEY,C.Claim),0) AS ClaimAmount
        ,ISNULL(TRY_CONVERT(MONEY,CJ.Amount_Of_Judgment),0) AS JudgmentAmount
        ,CJ.Date_Of_Judgment AS JudgmentDate
        ,'' AS JudgmentCode
        ,'' AS JudgmentBookNumber
        ,'' AS JudgmentPageNumber
        ,'' AS JudgmentClerkFileNumber
        ,NULL AS TitleIssueDate
        ,NULL AS ForeclosureSaleDate
        ,0 AS DocStamps
        ,0 AS SaleFeePaid
        ,0 AS ProofOfPublication
        ,0 AS EstateAmount
        ,0 AS Jury
        ,0 AS Contested
        ,NULL AS LettersOfAdministrationDate
        ,0 AS ServiceOfProcess
        ,0 AS AttorneyFees
        ,CJ.Total_Interest AS Interest
        ,LEFT(ISNULL(LTRIM(RTRIM(C.Description)) + '   ','') + char(10)
			+ ISNULL(LTRIM(RTRIM(CJ.Comment)),''),1000) + char(10)
			+ 'Claim Amount: ' + C.Claim  AS Remark
        ,0 AS ConsolidatedToCaseID
        ,NULL AS ConsolidatedDate
        ,0 AS NeedToDisburseFunds
        ,NULL AS RetentionDate
        ,0 AS PurgeID
        ,NULL AS PurgeDate
        ,0 AS PurgeDocumentationComplete
        ,'' AS MarriageWifeMaidenName
        ,'' AS MarriageCounty
        ,'' AS MarriageStateCode
        ,NULL AS MarriageDate
        ,0 AS DissolutionNumLivingChildren
        ,0 AS DissolutionNumChildrenUnder18
        ,'' AS WifeCounty
        ,'' AS HusbandCounty
        ,NULL AS JudgeSignatureDate
        ,'' AS CountryOfMarriage
        ,NULL AS ComplexCaseDate
        ,'' AS AutoDispositionType
        ,'' AS GeneralNotes
        ,NULL AS CertificateIssueDate
        ,0 AS CountyHeld
        ,'' AS ParcelID
        ,'' AS LegalDescription
        ,'' AS StreetAddress
        ,NULL AS VerdictDate
        ,0 AS EstateTax
        ,0 AS Heirs
        ,0 AS SwornByOfficerID
        ,0 AS SwornByMagistrateID
        ,NULL AS SwornByDate
        ,XP.PartyID AS CreateByUserID
        ,C.Date_Filed AS CreateDate
        ,XP.PartyID AS ModifyByUserID
        ,CASE WHEN ISNULL(CJ.Date_Of_Judgment,'01/01/1900') <> '01/01/1900' THEN CJ.Date_Of_Judgment WHEN ISNULL(C.Date_Disposed,'01/01/1900') <> '01/01/1900' THEN C.Date_Disposed ELSE C.Date_Filed END AS ModifyDate
        ,0 AS SentToCollectionAgencyID
        ,0 AS SentToJACS
        ,0 AS RedactionNeeded
        ,0 AS ForeclosureSaleAmount
        ,'' AS LowerTribunalCaseNumber
        ,0 AS BarcodeID
        ,0 AS CaseCodeID
        ,CJ.Date_Of_Judgment AS JudgmentRecordDate
        ,0 AS NeedToDisburseGarnishmentFunds
        ,'' AS ForeclosureStatus
        ,NULL AS ForeclosureStatusDate
        ,0 AS ParentProbationCaseID
        ,ISNULL(LTRIM(RTRIM(C.Caption)),'') AS CaseStyle
        ,0 AS CaseStyleEdited
        ,'' AS MarriageHusbandMaidenName
        ,0 AS TotalCase
        ,'' AS StatusChangeReason
        ,'' AS StatusChangeComment
        ,0 AS ExcludeFromBCCS
    FROM test_source.dbo.Civil_Cases C WITH (NOLOCK)
         LEFT OUTER JOIN PLAINTIFF_cte P WITH (NOLOCK) ON P.Civil_Case_Id = C.Civil_Case_Id AND P.SeqNbr = 1
         LEFT OUTER JOIN PLAINTIFF_ATT_cte PA WITH (NOLOCK) ON PA.Plaintiff_Id = P.Plaintiff_Id AND PA.SeqNbr = 1
         LEFT OUTER JOIN tblParty PP WITH (NOLOCK) ON PP.FamilyCode = 'PUBLIC' AND PP.WebValidation = CONVERT(VARCHAR(255),P.Plaintiff_SSN)
         LEFT OUTER JOIN tblParty PPA WITH (NOLOCK) ON PPA.PrimaryPartyType = 'ATT' AND PPA.WebValidation = CONVERT(VARCHAR(255),PA.Attorney_Id)
         LEFT OUTER JOIN DEFENDANT_cte D WITH (NOLOCK) ON D.Civil_Case_Id = C.Civil_Case_Id AND D.SeqNbr = 1
         LEFT OUTER JOIN DEFENDANT_ATT_cte DA WITH (NOLOCK) ON DA.Defendant_Id = D.Defendant_Id AND DA.SeqNbr = 1
         LEFT OUTER JOIN tblParty PD WITH (NOLOCK) ON PD.FamilyCode = 'PUBLIC' AND PD.WebValidation = CONVERT(VARCHAR(255),D.Defendant_SSN)
         LEFT OUTER JOIN tblParty PDA WITH (NOLOCK) ON PDA.PrimaryPartyType = 'ATT' AND PDA.WebValidation = CONVERT(VARCHAR(255),DA.Attorney_Id)
         LEFT OUTER JOIN tblParty PJ WITH (NOLOCK) ON PJ.PrimaryPartyType = 'JDG' AND PJ.WebValidation = CONVERT(VARCHAR(255),C.Termination_Judge_Id)	--GBDI-903: use Termination_Judge_Id when not NULL
         LEFT OUTER JOIN test_source.dbo.Civil_Judgments CJ WITH (NOLOCK) ON CJ.Civil_Case_Id = C.Civil_Case_Id
         LEFT OUTER JOIN tblCaseType CT WITH (NOLOCK) ON CT.CourtTypeID = @COURTTYPE AND CT.CaseType = CASE  WHEN SUBSTRING(C.Case_Number,5,3) = 'CVR' THEN 'CVH3' 
				 WHEN (SUBSTRING(C.Case_Number,5,3) = 'CVT') THEN 'CVH5' --GBDI-1110
				 WHEN (SUBSTRING(C.Case_Number,5,3) = 'CVH' AND C.CVH_Subtype_Id = 1) THEN 'CVH1'--GBDI-1110
				 WHEN (SUBSTRING(C.Case_Number,5,3) = 'CVH' AND C.CVH_Subtype_Id = 2) THEN 'CVH8'--GBDI-1110
				 WHEN (SUBSTRING(C.Case_Number,5,3) = 'CVH' AND C.CVH_Subtype_Id = 3) THEN 'CVH4'--GBDI-1110
				 WHEN (SUBSTRING(C.Case_Number,5,3) = 'CVH' AND C.CVH_Subtype_Id = 4) THEN 'CVH7'--GBDI-1110
				 WHEN (SUBSTRING(C.Case_Number,5,3) = 'CVH' AND C.CVH_Subtype_Id = 5) THEN 'CVH8'--GBDI-1110
				 WHEN (SUBSTRING(C.Case_Number,5,3) = 'CVH' AND C.CVH_Subtype_Id = 10) THEN 'CVH2'--GBDI-1110
				 WHEN (SUBSTRING(C.Case_Number,5,3) = 'CVH' AND C.CVH_Subtype_Id = 11) THEN 'CVH6'--GBDI-1110
				 WHEN (SUBSTRING(C.Case_Number,5,3) = 'CVH' AND C.CVH_Subtype_Id = 8) THEN 'CVH3'--GBDI-1110
				 WHEN (SUBSTRING(C.Case_Number,5,3) = 'CVH' AND C.CVH_Subtype_Id = 9) THEN 'CVH5'--GBDI-1110
				 ELSE SUBSTRING(C.Case_Number,5,3) END
         LEFT OUTER JOIN XREF_tblParty_UserID XP WITH (NOLOCK) ON XP.UserID = CONVERT(VARCHAR(50),C.User_Id)
         LEFT OUTER JOIN test_source.dbo.Collections LWC WITH (NOLOCK) ON LWC.Case_Number = C.Case_Number      --GBDI-47
         LEFT OUTER JOIN WARRANT_cte CW WITH (NOLOCK) ON C.Case_Number = CW.Case_Number AND CW.RowNum = (Select MAX(tcw.RowNum) from WARRANT_cte tcw where tcw.Case_Number = cw.Case_Number)     --GBDI-891:Civil Cases with no Active Process have a Case Status of Warrant Pending (SEE GBDI-660)
ORDER BY C.Civil_Case_Id

SET IDENTITY_INSERT tblCase OFF
--86,163 rows