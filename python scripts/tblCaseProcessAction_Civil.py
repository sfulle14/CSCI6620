from Connection import connect_to_db

def tblCaseProcessAction_trcr():
    # Establishing the connection
    conn = connect_to_db()
    cursor = conn.cursor()

    sql_query = """
    --CIVIL WARRANTS


    INSERT INTO tblLookup
                (Code
                ,Description
                ,LookupGroup
                ,LookupKey
                ,UseDescription
                ,DisplayOrder
                ,OBTSCode
                ,TCATSCode
                ,SRSCode
                ,Active
                ,ICPEnabled
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,CCISCode
                ,CCOCSubType)
      SELECT -- LookupID
            LTRIM(RTRIM(BT.Bond_Type_Id)) AS Code
            ,LTRIM(RTRIM(BT.Bond_Type)) AS Description
            ,'ReleaseOptions' AS LookupGroup
            ,CONVERT(VARCHAR(50),BT.Bond_Type_Id) AS LookupKey
            ,'' AS UseDescription
            ,99999 AS DisplayOrder
            ,'' AS OBTSCode
            ,'' AS TCATSCode
            ,'' AS SRSCode
            ,1 AS Active
            ,1 AS ICPEnabled
            ,1 AS CreateByUserID
            ,CURRENT_TIMESTAMP AS CreateDate
            ,1 AS ModifyByUserID
            ,CURRENT_TIMESTAMP AS ModifyDate
            ,'' AS CCISCode
            ,'' AS CCOCSubType
        FROM test_source.dbo.Bond_Types BT WITH (NOLOCK)
      --test_source.dbo.Warrant_Reasons WR WITH (NOLOCK)
            LEFT OUTER JOIN tblLookup L WITH (NOLOCK) ON L.LookupGroup = 'ReleaseOptions' AND L.Code = LTRIM(RTRIM(BT.Bond_Type))
      WHERE ISNULL(LTRIM(RTRIM(BT.Bond_Type)),'') > ''
        AND L.Code IS NULL
    ORDER BY BT.Bond_Type_Id
    --6

    INSERT INTO tblLookup
                (Code
                ,Description
                ,LookupGroup
                ,LookupKey
                ,UseDescription
                ,DisplayOrder
                ,OBTSCode
                ,TCATSCode
                ,SRSCode
                ,Active
                ,ICPEnabled
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,CCISCode
                ,CCOCSubType)
      SELECT -- LookupID
            LTRIM(RTRIM(WR.Warrant_Reason)) AS Code
            ,LTRIM(RTRIM(WR.Warrant_Reason)) AS Description
            ,'ProcessActionReason' AS LookupGroup
            ,CONVERT(VARCHAR(50),WR.Warrant_Reason_Id) AS LookupKey
            ,'Warrant Reasons' AS UseDescription
            ,99999 AS DisplayOrder
            ,'' AS OBTSCode
            ,'' AS TCATSCode
            ,'' AS SRSCode
            ,1 AS Active
            ,1 AS ICPEnabled
            ,1 AS CreateByUserID
            ,CURRENT_TIMESTAMP AS CreateDate
            ,1 AS ModifyByUserID
            ,CURRENT_TIMESTAMP AS ModifyDate
            ,'' AS CCISCode
            ,'' AS CCOCSubType
        FROM test_source.dbo.Warrant_Reasons WR WITH (NOLOCK)
            LEFT OUTER JOIN tblLookup L WITH (NOLOCK) ON L.LookupGroup = 'ProcessActionReason' AND L.Code = LTRIM(RTRIM(WR.Warrant_Reason))
      WHERE ISNULL(LTRIM(RTRIM(WR.Warrant_Reason)),'') > ''
        AND L.Code IS NULL
    ORDER BY WR.Warrant_Reason_Id
    --14


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
            ,CW.Date_Issued AS IssueDate
            ,ISNULL(CW.Date_Recalled, CW.Date_Served) AS ExecuteDate
            ,CASE WHEN CW.Date_Recalled IS NOT NULL THEN 'R'
                  WHEN CW.Date_Served IS NOT NULL THEN 'S'
                  ELSE 'I'	--GBDI-640: Set to 'I' (Issued) instead of 'E' (Executed) per Lakewood request
              END AS ExecuteStatusCode
            ,0 AS ExecuteAgencyPartyID
            ,0 AS ExecuteOfficerPartyID
            ,0 AS ArrestPartyAgencyID
            ,'' AS Method
            ,ISNULL(PJ.PartyID,0) AS PartyJudgeID
            ,NULL AS ReleaseOptions	
            ,ISNULL(LTRIM(RTRIM(CW.Description)),'')  AS IssuanceNotes
            ,0 AS JudgeSignatureRequired
            ,'' AS ArrestOBTSNumber
            ,'' AS ArrestCaseNumber
            ,NULL AS ArrestDate
            ,'' AS ArrestReason
            ,ISNULL(CW.Bond_Amount,0) AS SetBondAmount
            ,ISNULL(LTRIM(RTRIM(CW.Civil_Warrant_Number)),'') AS WarrantNumber
            ,COALESCE(CPD.PartyID,0) AS IssuedToPartyID
            ,0 AS IssuedToPartyAddressID
            ,0 AS RequestedByPartyID
            ,0 AS RequestedByAddressID
            ,ROW_NUMBER() OVER(PARTITION BY CW.Case_Number ORDER BY CW.Date_Issued) AS CCISSequenceNumber
            ,0 AS OriginatingCaseID
            ,NULL AS AcceptedDate
            ,0 AS AcceptedByUserID
            ,XP.PartyID AS CreateByUserID
            ,CW.Date_Issued AS CreateDate
            ,XP.PartyID AS ModifyByUserID
            ,COALESCE(CW.Date_Served,CW.Date_Recalled,CW.Date_Issued) AS ModifyDate
            ,'' AS BookingNumber
            ,0 AS VendorReceived
            ,'' AS LastSentStatusCode
            ,CONVERT(VARCHAR(50),CW.Civil_Warrant_Id) AS VendorReferenceID
            ,CW.Date_Recalled AS EndEffectiveDate
    FROM test_source.dbo.Civil_Warrant CW WITH (NOLOCK)
            INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = CW.Case_Number
            LEFT OUTER JOIN tblCaseParty CPD WITH (NOLOCK) ON CPD.CaseID = C.CaseID AND CPD.CasePartyType = 'DEF' AND CPD.OriginalPartyID = CW.Defendant_Id
            LEFT OUTER JOIN tblParty PJ WITH (NOLOCK) ON PJ.PrimaryPartyType = 'JDG' AND PJ.WebValidation = CONVERT(VARCHAR(255),CW.Judge_Id)
            LEFT OUTER JOIN test_source.dbo.Warrant_Reasons WR WITH (NOLOCK) ON WR.Warrant_Reason_Id = CW.Warrant_Reason_Id
            LEFT OUTER JOIN XREF_tblParty_UserID XP WITH (NOLOCK) ON XP.UserID = CONVERT(VARCHAR(50),CW.User_Id)
    --54
    """
    
    #Executing the query
    cursor.execute(sql_query)
    conn.commit()

    #Closing the connection
    cursor.close()
    conn.close()