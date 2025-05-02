from Connection import connect_to_db

def tblCaseDocket_trcr():
    # Establishing the connection
    conn = connect_to_db()
    cursor = conn.cursor()

    sql_query = """
    --TRAFFIC CRIMINAL DOCKETS

    DECLARE @DKTCODE INT = ISNULL((SELECT TOP 1 DocketCodeID FROM tblDocketCode WITH (NOLOCK) WHERE DocketCode = 'FREETYPE'),0)

    INSERT INTO tblCaseDocket
                (CaseID
                ,DocketCodeID
                ,DocketDate
                ,DocketText
                ,DocketSequenceNumber
                ,ReferenceNumber
                ,AssignReferenceNumber
                ,WebSubmit
                ,HideFromWeb
                ,Highlight
                ,AutoDocketFieldID
                ,SourceTableName
                ,SourceTableID
                ,DocumentCount
                ,BatchMode
                ,VerifyByUserID
                ,VerifyDate
                ,ScanBatchID
                ,ScanBatchIndexByUserID
                ,ScanBatchIndexDate
                ,AdditionalScanBatchID
                ,ExpectedImageCount
                ,KeyedByUserID
                ,KeyedStatus
                ,CaseReOpen
                ,DisburseFunds
                ,DocketIcon
                ,DocumentAction
                ,DocumentActionDate
                ,ActionRequiredByUserID
                ,ActionTaken
                ,ActionCompleteDate
                ,ActionFinalized
                ,ActionFinalizedDate
                ,ActionFinalizedByUserID
                ,CCISSequenceNumber
                ,AssignedByUserID
                ,AssignedDate
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,LockedByPartyID
                ,RegistryFlag
                ,FiledBy
                ,IsSealed
                ,RedactStatus
                ,RedactID
                ,DocketStatus
                ,GarnishmentFlag
                ,DisburseGarnishmentFunds
                ,HasOCR
                ,ICPEventID
                ,VORStatus
                ,OriginalERecordID)
    SELECT -- CaseDocketID
            C.CaseID AS CaseID
            ,@DKTCODE AS DocketCodeID
            ,TCD.Date_Of_Entry AS DocketDate
            ,LEFT(ISNULL(LTRIM(RTRIM(TCD.Description)),''),5000) AS DocketText
            ,ROW_NUMBER() OVER(PARTITION BY TCD.Case_Number, TCD.Date_Of_Entry ORDER BY TCD.Date_Of_Entry) AS DocketSequenceNumber
            ,0 AS ReferenceNumber
            ,0 AS AssignReferenceNumber
            ,0 AS WebSubmit
            ,0 AS HideFromWeb
            ,0 AS Highlight
            ,0 AS AutoDocketFieldID
            ,'Traffic_Criminal_Dockets' AS SourceTableName
            ,TCD.Traffic_Criminal_Docket_Id AS SourceTableID
            ,0 AS DocumentCount
            ,0 AS BatchMode
            ,0 AS VerifyByUserID
            ,NULL AS VerifyDate
            ,0 AS ScanBatchID
            ,0 AS ScanBatchIndexByUserID
            ,NULL AS ScanBatchIndexDate
            ,0 AS AdditionalScanBatchID
            ,0 AS ExpectedImageCount
            ,0 AS KeyedByUserID
            ,'' AS KeyedStatus
            ,0 AS CaseReOpen
            ,0 AS DisburseFunds
            ,0 AS DocketIcon
            ,0 AS DocumentAction
            ,NULL AS DocumentActionDate
            ,0 AS ActionRequiredByUserID
            ,0 AS ActionTaken
            ,NULL AS ActionCompleteDate
            ,0 AS ActionFinalized
            ,NULL AS ActionFinalizedDate
            ,0 AS ActionFinalizedByUserID
            ,ROW_NUMBER() OVER(PARTITION BY TCD.Case_Number ORDER BY TCD.Date_Of_Entry) AS CCISSequenceNumber
            ,0 AS AssignedByUserID
            ,NULL AS AssignedDate
            ,XP.PartyID AS CreateByUserID
            ,TCD.Date_Of_Entry AS CreateDate
            ,XP.PartyID AS ModifyByUserID
            ,TCD.Date_Of_Entry AS ModifyDate
            ,0 AS LockedByPartyID
            ,0 AS RegistryFlag
            ,ISNULL(CONVERT(VARCHAR,TCD.User_Id),'') AS FiledBy
            ,0 AS IsSealed
            ,0 AS RedactStatus
            ,0 AS RedactID
            ,'' AS DocketStatus
            ,0 AS GarnishmentFlag
            ,0 AS DisburseGarnishmentFunds
            ,0 AS HasOCR
            ,0 AS ICPEventID
            ,0 AS VORStatus
            ,0 AS OriginalERecordID
        FROM test_source.dbo.Traffic_Criminal_Dockets TCD WITH (NOLOCK)
            INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = TCD.Case_Number
            LEFT OUTER JOIN XREF_tblParty_UserID XP WITH (NOLOCK) ON XP.UserID = CONVERT(VARCHAR(50),TCD.User_Id)
    --3,704,242  (OUT OF 3,704,313 - 71 DO NOT HAVE A CASE_NUMBER)  (INSERT 2:49)



    --Restitution_Comments

    INSERT INTO tblCaseDocket
                (CaseID
                ,DocketCodeID
                ,DocketDate
                ,DocketText
                ,DocketSequenceNumber
                ,ReferenceNumber
                ,AssignReferenceNumber
                ,WebSubmit
                ,HideFromWeb
                ,Highlight
                ,AutoDocketFieldID
                ,SourceTableName
                ,SourceTableID
                ,DocumentCount
                ,BatchMode
                ,VerifyByUserID
                ,VerifyDate
                ,ScanBatchID
                ,ScanBatchIndexByUserID
                ,ScanBatchIndexDate
                ,AdditionalScanBatchID
                ,ExpectedImageCount
                ,KeyedByUserID
                ,KeyedStatus
                ,CaseReOpen
                ,DisburseFunds
                ,DocketIcon
                ,DocumentAction
                ,DocumentActionDate
                ,ActionRequiredByUserID
                ,ActionTaken
                ,ActionCompleteDate
                ,ActionFinalized
                ,ActionFinalizedDate
                ,ActionFinalizedByUserID
                ,CCISSequenceNumber
                ,AssignedByUserID
                ,AssignedDate
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,LockedByPartyID
                ,RegistryFlag
                ,FiledBy
                ,IsSealed
                ,RedactStatus
                ,RedactID
                ,DocketStatus
                ,GarnishmentFlag
                ,DisburseGarnishmentFunds
                ,HasOCR
                ,ICPEventID
                ,VORStatus
                ,OriginalERecordID)
    SELECT -- CaseDocketID
            C.CaseID AS CaseID
            ,147 AS DocketCodeID
            ,(select max(cd.DocketDate) from tblCaseDocket cd where cd.CaseID = C.CaseID) AS DocketDate
            ,'Conversion Restitution Comments - ' + ISNULL(RC.Restitution_Comment,'') AS DocketText
            ,ROW_NUMBER() OVER(PARTITION BY RC.Case_Number ORDER BY RC.Case_Number) AS DocketSequenceNumber
            ,0 AS ReferenceNumber
            ,0 AS AssignReferenceNumber
            ,0 AS WebSubmit
            ,0 AS HideFromWeb
            ,0 AS Highlight
            ,0 AS AutoDocketFieldID
            ,'Restitution_Comments' AS SourceTableName
            ,NULL AS SourceTableID
            ,0 AS DocumentCount
            ,0 AS BatchMode
            ,0 AS VerifyByUserID
            ,NULL AS VerifyDate
            ,0 AS ScanBatchID
            ,0 AS ScanBatchIndexByUserID
            ,NULL AS ScanBatchIndexDate
            ,0 AS AdditionalScanBatchID
            ,0 AS ExpectedImageCount
            ,0 AS KeyedByUserID
            ,'' AS KeyedStatus
            ,0 AS CaseReOpen
            ,0 AS DisburseFunds
            ,0 AS DocketIcon
            ,0 AS DocumentAction
            ,NULL AS DocumentActionDate
            ,0 AS ActionRequiredByUserID
            ,0 AS ActionTaken
            ,NULL AS ActionCompleteDate
            ,0 AS ActionFinalized
            ,NULL AS ActionFinalizedDate
            ,0 AS ActionFinalizedByUserID
            ,NULL AS CCISSequenceNumber
            ,0 AS AssignedByUserID
            ,NULL AS AssignedDate
            ,1 AS CreateByUserID
            ,CURRENT_TIMESTAMP AS CreateDate
            ,1 AS ModifyByUserID
            ,CURRENT_TIMESTAMP AS ModifyDate
            ,0 AS LockedByPartyID
            ,0 AS RegistryFlag
            ,NULL AS FiledBy
            ,0 AS IsSealed
            ,0 AS RedactStatus
            ,0 AS RedactID
            ,'' AS DocketStatus
            ,0 AS GarnishmentFlag
            ,0 AS DisburseGarnishmentFunds
            ,0 AS HasOCR
            ,0 AS ICPEventID
            ,0 AS VORStatus
            ,0 AS OriginalERecordID
        FROM test_source.dbo.Restitution_Comments RC WITH (NOLOCK)
            INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = RC.Case_Number
    """
    
    #Executing the query
    cursor.execute(sql_query)
    conn.commit()

    #Closing the connection
    cursor.close()
    conn.close()