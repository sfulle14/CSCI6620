
--TRAFFIC CRIMINAL CASES

DECLARE @SELECTNUMBER INT = 10000

DECLARE @CTTRDFLT INT = (SELECT CST.CaseTypeID FROM tblCaseType CST WITH (NOLOCK) WHERE LTRIM(RTRIM(CST.CaseType)) = 'TRD')	--GBDI-820:4th Pass - No Returned TRD Cases on Executed Search
DECLARE @CTCRF INT = (SELECT CST.CaseTypeID FROM tblCaseType CST WITH (NOLOCK) WHERE LTRIM(RTRIM(CST.CaseType)) = 'CRA')		--GBDI-820:4th Pass - No Returned TRD Cases on Executed Search
DECLARE @CTCRM INT = (SELECT CST.CaseTypeID FROM tblCaseType CST WITH (NOLOCK) WHERE LTRIM(RTRIM(CST.CaseType)) = 'CRB')		--GBDI-820:4th Pass - No Returned TRD Cases on Executed Search
-- DECLARE @CTTRDFLT INT = (SELECT CST.CaseTypeID FROM tblCaseType CST WITH (NOLOCK) WHERE CST.CaseType = 'TRD')
-- DECLARE @CTCRF INT = (SELECT CST.CaseTypeID FROM tblCaseType CST WITH (NOLOCK) WHERE CST.CaseType = 'CRA')
-- DECLARE @CTCRM INT = (SELECT CST.CaseTypeID FROM tblCaseType CST WITH (NOLOCK) WHERE CST.CaseType = 'CRB')

;WITH CASE_VIOLATION_cte AS
      (SELECT CVI.Case_Number
             ,CVI.Case_Violation_Id
             ,CVI.Attorney_Id
             ,CVI.Time_Waived
             ,CASE ISNULL(SUBSTRING(LTRIM(RTRIM(DOV.Degree)),1,1),'') WHEN 'U' THEN 'F' ELSE ISNULL(SUBSTRING(LTRIM(RTRIM(DOV.Degree)),1,1),'M') END ChargeLevel
             ,ROW_NUMBER() OVER(PARTITION BY CVI.Case_Number ORDER BY CVI.Counter, CVI.Attorney_Id) AS SeqNbr
             ,CVI.Judge_Id AS Judge_ID	-- GBDi-719: Incorrect or No Judge Assignment on Converted Cases
         FROM test_source.dbo.Case_Violations CVI WITH (NOLOCK)
              LEFT OUTER JOIN test_source.dbo.Degree_Of_Violations DOV WITH (NOLOCK) ON DOV.Degree_Of_Violation_Id = CVI.Degree_Of_Violation_Id)
     ,TRCR_DISPOSITION_cte AS
      (SELECT TRCRD.Case_Violation_Id
             ,TRCRD.Sentence_Id
             ,ROW_NUMBER() OVER(PARTITION BY TRCRD.Case_Violation_Id ORDER BY TRCRD.Date_Of_Sentence DESC) AS SeqNbr
         FROM test_source.dbo.Traffic_Criminal_Disposition TRCRD WITH (NOLOCK))
INSERT INTO tblCase
            (CaseNumber
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
         ISNULL(LTRIM(RTRIM(C.Case_Number)),'') AS CaseNumber
        ,'' AS BookingNumber
        ,ISNULL(LTRIM(RTRIM(C.Case_Number)),'') AS UniformCaseNumber
        ,0 AS FirstPlaintiffID
        ,0 AS PlaintiffAttorneyID
        ,ISNULL(PD.PartyID,0) AS FirstDefendantID
        ,ISNULL(PDA.PartyID,0) AS DefendantAttorneyID
        ,0 AS DivisionID
        ,ISNULL(PJ.PartyID,0) AS JudgeID
        ,C.Date_Filed AS CaseOpenDate
        ,CASE WHEN C.Date_Closed IS NULL THEN NULL	--GBDI-818: General Tab - Closed Date field needs to be blank with Case Status = WARRANT PENDING
			  WHEN C.Date_Closed IS NOT NULL THEN C.Date_Closed
              WHEN C.Date_Disposed IS NOT NULL THEN C.Date_Disposed
             END AS CaseCloseDate
        --,C.Date_Closed AS CaseCloseDate
        ,ISNULL(LTRIM(RTRIM(S.Sentence)),'') AS Disposition
        ,'' AS SAOCaseNumber
        ,CASE WHEN C.Expunged = 1 THEN 2 ELSE 0 END AS CaseSecurity
        ,CASE 
              WHEN ISNULL(C.Date_Disposed,'01/01/1900') <> '01/01/1900' THEN 'CLOS'	--GBDI-818: General Tab - Closed Date field needs to be blank with Case Status = WARRANT PENDING
              WHEN ISNULL(C.Date_Closed,'01/01/1900') <> '01/01/1900' THEN 'CLOS'
			  --WHEN W.Date_Issued IS NOT NULL and (W.Date_Recalled IS NULL and W.Date_Returned IS NULL and W.Date_Served IS NULL) THEN 'WARRANTP'	--GBDI-660: Adding Warrant Pending Status to cases with open warrants
              WHEN C.Date_Closed IS NOT NULL THEN 'CLOS'
              --ELSE 'WARRANTP'	--GBDI-818: General Tab - Closed Date field needs to be blank with Case Status = WARRANT PENDING
			  ELSE 'OPEN'
          END AS CaseStatus
        ,'' AS ArrestingCaseNumber
        ,C.Date_Arrested AS ArrestDate
        ,ISNULL(PA.PartyID,0) AS AgencyID
        ,ISNULL(PO.PartyID,0) AS OfficerID
        ,ISNULL(J.JurisdictionID,0) AS JurisdictionID
        ,0 AS ArrestLocationID
        ,'' AS JailNumber
        ,'' AS PartyPassword
        ,'' AS MessageType
        ,ISNULL(CRT.CourtTypeID,0) AS CourtTypeID
        ,CASE SUBSTRING(C.Case_Number,5,2) WHEN 'TR' THEN ISNULL(CT.CaseTypeID,@CTTRDFLT) ELSE ISNULL(CT.CaseTypeID,CASE CV.ChargeLevel WHEN 'F' THEN @CTCRF ELSE @CTCRM END) END AS CaseTypeID
        ,0 AS CountyBranchID
        ,CONVERT(INT,SUBSTRING(C.Case_Number,1,4)) AS CaseOpenYear  --CONVERT(INT,FORMAT(C.Date_Filed,'yyyy'))
        ,CONVERT(INT,SUBSTRING(C.Case_Number,8,5)) AS CaseSequenceNumber
        ,'' AS DefendantIdentifier
        ,NULL AS CapiasDate
        ,NULL AS RearrestDate
        ,0 AS TrialType
        ,CASE WHEN CONVERT(DATE,FORMAT(PC.Probation_Date_From,'yyyyMMdd')) <= CONVERT(DATE,FORMAT(CURRENT_TIMESTAMP,'yyyyMMdd'))
               AND CONVERT(DATE,FORMAT(PC.Probation_Date_To,'yyyyMMdd')) >= CONVERT(DATE,FORMAT(CURRENT_TIMESTAMP,'yyyyMMdd'))
              THEN 1 ELSE 0
          END AS ActiveProbation
        ,PC.Probation_Date_From AS ProbationStartDate
        ,PC.Probation_Date_To AS ProbationEndDate
        ,0 AS ActiveProcess
        ,'' AS CustodyLocationCode
        ,NULL AS ReOpenDate
        ,ISNULL(LTRIM(RTRIM(C.Reopen_Note)),'') AS ReOpenReason
        ,NULL AS ReOpenCloseDate
        ,ISNULL(CV.Time_Waived,0) AS WaiveSpeedyTrial
        ,ISNULL(LWC.Date_Sent, NULL) AS SentToCollectionDate -- GBDI-47
        ,ISNULL(LWC.Amount,0) AS SentToCollectionAmount --GBDI-47
        ,NULL AS PIACallDate
        ,NULL AS PIAFormsSentDate
        ,0 AS TransferredToCaseID
        ,NULL AS TransferredDate
        ,'' AS SchoolElection
        ,ISNULL(LTRIM(RTRIM(S.Sentence)),'') AS DispositionCode
        --,C.Date_Disposed AS DispositionDate		--GBDI-875
        --,ISNULL(PJ.PartyID,0) AS DispositionJudgeID	--GBDI-875
		,NULL AS DispositionDate		--GBDI-875
		,NULL AS DispositionJudgeID		--GBDI-875
        ,0 AS ClaimAmount
        ,0 AS JudgmentAmount
        ,NULL AS JudgmentDate
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
        ,0 AS Interest
        ,LEFT(ISNULL(LTRIM(RTRIM(C.Status)) + '   ','') + ISNULL(LTRIM(RTRIM(CM.[Body])) + '   ','') + ISNULL(LTRIM(RTRIM(C.Transfer_Note)) + '   ','') + ISNULL(LTRIM(RTRIM(C.Memo)),''),5000) AS Remark
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
        ,C.Violator_SSN AS GeneralNotes
        ,NULL AS CertificateIssueDate
        ,0 AS CountyHeld
        ,CV.Case_Violation_Id AS ParcelID
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
        ,CASE WHEN ISNULL(C.Date_Disposed,'01/01/1900') <> '01/01/1900' THEN C.Date_Disposed ELSE C.Date_Filed END AS ModifyDate
        ,0 AS SentToCollectionAgencyID
        ,0 AS SentToJACS
        ,0 AS RedactionNeeded
        ,0 AS ForeclosureSaleAmount
        ,'' AS LowerTribunalCaseNumber
        ,0 AS BarcodeID
        ,0 AS CaseCodeID
        ,NULL AS JudgmentRecordDate
        ,0 AS NeedToDisburseGarnishmentFunds
        ,'' AS ForeclosureStatus
        ,NULL AS ForeclosureStatusDate
        ,0 AS ParentProbationCaseID
        ,LEFT(ISNULL(J.JurisdictionName + ' VS. ' + PD.Name,''),500) AS CaseStyle
        ,0 AS CaseStyleEdited
        ,'' AS MarriageHusbandMaidenName
        ,0 AS TotalCase
        ,'' AS StatusChangeReason
        ,'' AS StatusChangeComment
        ,0 AS ExcludeFromBCCS
    FROM test_source.dbo.Traffic_Criminal_Cases C WITH (NOLOCK)
         LEFT OUTER JOIN CASE_VIOLATION_cte CV WITH (NOLOCK) ON CV.Case_Number = C.Case_Number AND CV.SeqNbr = 1
         LEFT OUTER JOIN tblParty PD WITH (NOLOCK) ON PD.FamilyCode = 'PUBLIC' AND PD.WebValidation = CONVERT(VARCHAR(255),C.Violator_SSN)
         LEFT OUTER JOIN tblParty PDA WITH (NOLOCK) ON PDA.PrimaryPartyType = 'ATT' AND PDA.WebValidation = CONVERT(VARCHAR(255),CV.Attorney_Id)
         LEFT OUTER JOIN tblParty PJ WITH (NOLOCK) ON PJ.PrimaryPartyType = 'JDG' AND PJ.WebValidation = CONVERT(VARCHAR(255),CV.Judge_ID)
         --LEFT OUTER JOIN tblParty PJ WITH (NOLOCK) ON PJ.PrimaryPartyType = 'JDG' AND PJ.WebValidation = CONVERT(VARCHAR(255),C.Termination_Judge_Id)	-- GBDi-719: Incorrect or No Judge Assignment on Converted Cases
         LEFT OUTER JOIN tblParty PA WITH (NOLOCK) ON PA.PrimaryPartyType = 'AGCY' AND PA.WebValidation = CONVERT(VARCHAR(255),C.Agency_Id)
         LEFT OUTER JOIN tblParty PO WITH (NOLOCK) ON PO.PrimaryPartyType = 'OFF' AND PO.WebValidation = CONVERT(VARCHAR(255),C.Officer_Id)
         LEFT OUTER JOIN tblJurisdiction J WITH (NOLOCK) ON J.JurisdictionID = C.Jurisdiction_Of_Offense
         LEFT OUTER JOIN tblCourtType CRT WITH (NOLOCK) ON CRT.CourtType = SUBSTRING(C.Case_Number,5,2)
         LEFT OUTER JOIN tblCaseType CT WITH (NOLOCK) ON LTRIM(RTRIM(CT.CaseType)) = SUBSTRING(C.Case_Number,5,3)
         LEFT OUTER JOIN XREF_tblParty_UserID XP WITH (NOLOCK) ON XP.UserID = CONVERT(VARCHAR(50),C.User_Id)
         LEFT OUTER JOIN TRCR_DISPOSITION_cte TCD WITH (NOLOCK) ON TCD.SeqNbr = 1 AND TCD.Case_Violation_Id = CV.Case_Violation_Id AND CV.SeqNbr = 1
         LEFT OUTER JOIN test_source.dbo.Sentences S WITH (NOLOCK) ON S.Sentence_Id = TCD.Sentence_Id
         LEFT OUTER JOIN test_source.dbo.Probation_Cases PC WITH (NOLOCK) ON PC.Case_Number = C.Case_Number
         LEFT OUTER JOIN test_source.dbo.TRCR_Comments CM WITH (NOLOCK) ON CM.Case_Violation_Id = CV.Case_Violation_Id AND CV.SeqNbr = 1
         LEFT OUTER JOIN test_source.dbo.Collections LWC WITH (NOLOCK) ON LWC.Case_Number = C.Case_Number	--GBDI-47
         --LEFT OUTER JOIN test_source.dbo.Warrants W WITH (NOLOCK) ON C.Case_Number = W.Case_Number	--GBDI-660: Adding Warrant Pending Status to cases with open warrants	--GBDI-818: General Tab - Closed Date field needs to be blank with Case Status = WARRANT PENDING
ORDER BY C.Case_Number
--374,809  (1:17)
