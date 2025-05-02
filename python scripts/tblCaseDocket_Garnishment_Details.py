from Connection import connect_to_db

def tblCaseDocket_Garnishment_Details():
    # Establishing the connection
    conn = connect_to_db()
    cursor = conn.cursor()

    sql_query = """
        --CIVIL DOCKETS for Garnishment_Details

        DECLARE @DKTCODE INT = ISNULL((SELECT TOP 1 DocketCodeID FROM tblDocketCode WITH (NOLOCK) WHERE DocketCode = 'CCVGARNDETAIL'),0)


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
                ,ISNULL(CR.Date_receipted,CURRENT_TIMESTAMP) AS DocketDate
                ,'Garnishment Detail Id: ' + ISNULL(CONVERT(varchar,GD.Garnishment_Detail_Id),'') + char(10)
                                + 'Garnishment Id: ' +  ISNULL(CONVERT(varchar,GD.Garnishment_Id),'') + char(10)
                                + 'Civil Receipt Number: ' +  ISNULL(CONVERT(varchar,GD.Civil_Receipt_Number),'') + char(10)
                                + 'Judgment Cost: ' +  ISNULL(CONVERT(varchar,GD.Judgment_Cost),'') + char(10)
                                + 'Pay Out Type: ' +  ISNULL(CONVERT(varchar,GD.Pay_Out_Type),'') + char(10)
                                + 'Comment: ' +  ISNULL(CONVERT(varchar,GD.Comment),'') + char(10)
                                + 'Paid Out Flag: ' +  ISNULL(CONVERT(varchar,GD.Paid_Out_Flag),'') + char(10)
                                + 'Check Id: ' +  ISNULL(CONVERT(varchar,GD.Check_Id),'') + char(10)
                                + 'Receipt Status: ' +  ISNULL(CONVERT(varchar,GD.Receipt_Status),'') + char(10)
                                + 'Garnishment Number: ' +  ISNULL(CONVERT(varchar,GD.Garnishment_Number),'') + char(10)
                                AS DocketText
                ,ROW_NUMBER() OVER(PARTITION BY G.Civil_Case_Id, CR.Date_receipted ORDER BY CR.Date_receipted) AS DocketSequenceNumber
                ,0 AS ReferenceNumber
                ,0 AS AssignReferenceNumber
                ,0 AS WebSubmit
                ,0 AS HideFromWeb
                ,0 AS Highlight
                ,0 AS AutoDocketFieldID
                ,'Garnishment_Details' AS SourceTableName
                ,GD.Garnishment_Detail_Id AS SourceTableID
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
                ,ROW_NUMBER() OVER(PARTITION BY CC.Civil_Case_Id ORDER BY CR.Date_receipted) AS CCISSequenceNumber
                ,0 AS AssignedByUserID
                ,NULL AS AssignedDate
                ,CR.User_Id AS CreateByUserID
                ,ISNULL(CR.Date_receipted, CURRENT_TIMESTAMP) AS CreateDate
                ,CR.User_Id AS ModifyByUserID
                ,ISNULL(CR.Date_receipted, CURRENT_TIMESTAMP) AS ModifyDate
                ,0 AS LockedByPartyID
                ,0 AS RegistryFlag
                ,0 AS FiledBy
                ,0 AS IsSealed
                ,0 AS RedactStatus
                ,0 AS RedactID
                ,'' AS DocketStatus
                ,0 AS GarnishmentFlag
                ,0 AS DisburseGarnishmentFunds
                ,0 AS HasOCR
                ,0 AS ICPEventID
                ,0 AS VORStatus
                ,ISNULL(CC.Civil_Case_Id,0) AS OriginalERecordID
        FROM test_source.dbo.Garnishment_Details GD WITH (NOLOCK)
                INNER JOIN test_source.dbo.Civil_Receipts CR WITH (NOLOCK) ON CR.Civil_Receipt_Number = GD.Civil_Receipt_Number
                INNER JOIN test_source.dbo.Garnishments G WITH (NOLOCK) ON G.Garnishment_Id = GD.Garnishment_Id
                INNER JOIN test_source.dbo.Civil_Cases CC WITH (NOLOCK) ON CC.Civil_Case_Id = G.Civil_Case_Id
                INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = CC.Case_Number
                INNER JOIN tblParty P WITH (NOLOCK) ON P.PartyID = C.FirstDefendantID
    """
    
    #Executing the query
    cursor.execute(sql_query)
    conn.commit()

    #Closing the connection
    cursor.close()
    conn.close()