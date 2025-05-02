
--TRAFFIC CRIMINAL WARRANTS

DECLARE @PATYPE INT = ISNULL((SELECT TOP 1 ProcessActionTypeID FROM tblProcessActionType WITH (NOLOCK) WHERE ProcessActionTypeCode = 'WARRANT'),0)

INSERT INTO tblCaseProcessAction
            (CaseID
            ,ProcessActionTypeID
            ,CaseEventID
            ,ProcessActionReasonCode
            ,OrderDate
            ,IssueDate
            ,ExecuteDate
            ,ExecuteStatusCode
            ,ExecuteAgencyPartyID
            ,ExecuteOfficerPartyID
            ,ArrestPartyAgencyID
            ,Method
            ,PartyJudgeID
            ,ReleaseOptions
            ,IssuanceNotes
            ,JudgeSignatureRequired
            ,ArrestOBTSNumber
            ,ArrestCaseNumber
            ,ArrestDate
            ,ArrestReason
            ,SetBondAmount
            ,WarrantNumber
            ,IssuedToPartyID
            ,IssuedToPartyAddressID
            ,RequestedByPartyID
            ,RequestedByAddressID
            ,CCISSequenceNumber
            ,OriginatingCaseID
            ,AcceptedDate
            ,AcceptedByUserID
            ,CreateByUserID
            ,CreateDate
            ,ModifyByUserID
            ,ModifyDate
            ,BookingNumber
            ,VendorReceived
            ,LastSentStatusCode
            ,VendorReferenceID
            ,EndEffectiveDate)
  SELECT -- CaseProcessActionID
         C.CaseID AS CaseID
        ,3 AS ProcessActionTypeID
        ,0 AS CaseEventID
        ,CASE WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Non-Appearance' THEN 'Non-Appearance'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Non-Appearance Prelim' THEN 'Non-Appearance Prelim'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Non-App Preliminary Hearing' THEN 'Non-Appearance Prelim'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Non-Appearance Pretrial' THEN 'Non-Appearance Pretrial'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Non-Appearance Payment' THEN 'Non-Appearance Payment'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'On Complaint' THEN 'On Complaint'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Contempt of Court' THEN 'Contempt of Court'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Non-Appearance sentencing' THEN 'Non-Appearance sentencing'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Non-Appearance Trial' THEN 'Non-Appearance Trial'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Non-Appearance Arraignment' THEN 'Non-Appearance'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Probation Violation' THEN 'Probation Violation'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Non appearance CCS violation' THEN 'Probation Violation'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Probable Cause' THEN 'Probable Cause'
	WHEN LTRIM(RTRIM(WR.Warrant_Reason)) = 'Case Remanded' THEN 'Case Remanded'
	ELSE ''
  	END AS ProcessActionReasonCode
        ,NULL AS OrderDate
        ,W.Date_Issued AS IssueDate
        ,ISNULL(W.Date_Recalled, W.Date_Served) AS ExecuteDate 	--GDBI-642: Adding logic for Date_Recalled 
        , CASE WHEN W.Date_Recalled IS NOT NULL AND W.Date_Served IS NULL THEN  'R'
              WHEN W.Date_Served IS NOT NULL AND W.Date_Recalled IS NULL THEN 'S'
              ELSE 'I'	--GBDI-640: Set to 'I' (Issued) instead of 'E' (Executed) per Lakewood request
          END AS ExecuteStatusCode
        ,0 AS ExecuteAgencyPartyID
        ,0 AS ExecuteOfficerPartyID
        ,0 AS ArrestPartyAgencyID
        ,'' AS Method
        ,ISNULL(PJ.PartyID,0) AS PartyJudgeID
        ,BT.Bond_Type AS ReleaseOptions
        ,ISNULL(LTRIM(RTRIM(W.Description)),'') + '     Incident No: ' + ISNULL(CONVERT(VARCHAR,LTRIM(RTRIM(TCC.Incident_Number))),'N/A')
	+ '    ' + 'Date Returned: ' + ISNULL(CONVERT(VARCHAR,W.Date_Returned),'') 
	  AS IssuanceNotes
        ,0 AS JudgeSignatureRequired
        ,'' AS ArrestOBTSNumber
        ,'' AS ArrestCaseNumber
        ,NULL AS ArrestDate
        ,'' AS ArrestReason
        ,ISNULL(W.Bond_Amount,0) AS SetBondAmount
        ,ISNULL(LTRIM(RTRIM(W.Warrant_Number)),'') AS WarrantNumber
        ,C.FirstDefendantID AS IssuedToPartyID
        ,0 AS IssuedToPartyAddressID
        ,0 AS RequestedByPartyID
        ,0 AS RequestedByAddressID
        ,ROW_NUMBER() OVER(PARTITION BY W.Case_Number ORDER BY W.Date_Issued) AS CCISSequenceNumber
        ,0 AS OriginatingCaseID
        ,NULL AS AcceptedDate
        ,0 AS AcceptedByUserID
        ,XP.PartyID AS CreateByUserID
        ,W.Date_Issued AS CreateDate
        ,XP.PartyID AS ModifyByUserID
        ,COALESCE(W.Date_Served,W.Date_Recalled,W.Date_Issued) AS ModifyDate
        ,'' AS BookingNumber
        ,0 AS VendorReceived
        ,'' AS LastSentStatusCode
        ,CONVERT(VARCHAR(50),W.Warrant_Id) AS VendorReferenceID
        ,W.Date_Recalled AS EndEffectiveDate
    FROM test_source.dbo.Warrants W WITH (NOLOCK)
         INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = W.Case_Number
         LEFT OUTER JOIN tblParty PJ WITH (NOLOCK) ON PJ.PrimaryPartyType = 'JDG' AND PJ.WebValidation = CONVERT(VARCHAR(255),W.Judge_Id)
         LEFT OUTER JOIN test_source.dbo.Warrant_Reasons WR WITH (NOLOCK) ON WR.Warrant_Reason_Id = W.Warrant_Reason_Id
         LEFT OUTER JOIN XREF_tblParty_UserID XP WITH (NOLOCK) ON XP.UserID = CONVERT(VARCHAR(50),W.User_Id)
         LEFT JOIN test_source.dbo.Bond_Types BT WITH (NOLOCK) ON BT.Bond_Type_Id = W.Bond_Type_Id
         LEFT JOIN test_source.dbo.Traffic_Criminal_Cases TCC WITH (NOLOCK) ON TCC.Case_Number = C.CaseNumber
--28,606
