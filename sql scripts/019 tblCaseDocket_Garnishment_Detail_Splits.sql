
--CIVIL DOCKETS for Garnishment_Detail_Splits

DECLARE @DKTCODE INT = ISNULL((SELECT TOP 1 DocketCodeID FROM tblDocketCode WITH (NOLOCK) WHERE DocketCode = 'CCVGARNDETAILSP'),0)


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
        ,'Garnishment Detail Split Id: ' + ISNULL(CONVERT(varchar,GDS.Garnishment_Detail_Split_Id),'') + char(10)
			+ 'Garnishment Detail Id: ' + ISNULL(CONVERT(varchar,GDS.Garnishment_Detail_Id),'') + char(10)
			+ 'Payee Id: ' + ISNULL(CONVERT(varchar,GDS.Payee_Id),'') + char(10)
			+ 'Payee Status: ' + ISNULL(CONVERT(varchar,GDS.Payee_Status),'') + char(10)
			+ 'Split Amount: ' + ISNULL(CONVERT(varchar,GDS.Split_Amount),'') + char(10)
			+ 'Pay Out Status: ' +  ISNULL(CONVERT(varchar,GDS.Pay_Out_Status),'') + char(10)
			+ 'Civil Receipt Number: ' +  ISNULL(CONVERT(varchar,GDS.Civil_Receipt_Number),'') + char(10)
			+ 'Paid Out Flag: ' +  ISNULL(CONVERT(varchar,GDS.Paid_Out_Flag),'') + char(10)
			+ 'Check Id: ' +  ISNULL(CONVERT(varchar,GDS.Check_Id),'') + char(10)
			+ 'Receipt Status: ' +  ISNULL(CONVERT(varchar,GDS.Receipt_Status),'') + char(10)
			 AS DocketText
        ,ROW_NUMBER() OVER(PARTITION BY G.Civil_Case_Id, CR.Date_receipted ORDER BY CR.Date_receipted) AS DocketSequenceNumber
        ,0 AS ReferenceNumber
        ,0 AS AssignReferenceNumber
        ,0 AS WebSubmit
        ,0 AS HideFromWeb
        ,0 AS Highlight
        ,0 AS AutoDocketFieldID
        ,'Garnishment_Detail_Splits' AS SourceTableName
        ,GDS.Garnishment_Detail_Split_Id AS SourceTableID
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
FROM test_source.dbo.Garnishment_Detail_Splits GDS WITH (NOLOCK)
 INNER JOIN test_source.dbo.Garnishment_Details GD WITH (NOLOCK) ON GD.Garnishment_Detail_Id = GDS.Garnishment_Detail_Id
 INNER JOIN test_source.dbo.Civil_Receipts CR WITH (NOLOCK) ON CR.Civil_Receipt_Number = GDS.Civil_Receipt_Number
 INNER JOIN test_source.dbo.Garnishments G WITH (NOLOCK) ON G.Garnishment_Id = GD.Garnishment_Id
 INNER JOIN test_source.dbo.Civil_Cases CC WITH (NOLOCK) ON CC.Civil_Case_Id = G.Civil_Case_Id
 INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = CC.Case_Number
 INNER JOIN tblParty P WITH (NOLOCK) ON P.PartyID = C.FirstDefendantID
