
--CIVIL DOCKETS for Garnishment_Number_Details

DECLARE @DKTCODE INT = ISNULL((SELECT TOP 1 DocketCodeID FROM tblDocketCode WITH (NOLOCK) WHERE DocketCode = 'CCVGARNNODETAIL'),0)


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
        ,ISNULL(GND.Date_Filed,CURRENT_TIMESTAMP) AS DocketDate
        ,'Garnishment Number: ' + ISNULL(CONVERT(varchar,GND.Garnishment_Number),'') + char(10)
		+ 'Garnishment Id: ' +  ISNULL(CONVERT(varchar,GND.Garnishment_Id),'') + char(10)
		+ 'Defendant: ' + ISNULL(P.Name,'') + char(10)
		+ 'Employer: ' + ISNULL(GND.Employer,'') + char(10)
		+ 'To Pay: ' + ISNULL(CONVERT(varchar,GND.To_Pay),'') + char(10)
		+ 'Amount Paid: ' + ISNULL(CONVERT(varchar,GND.Amount_Paid),'') + char(10)
		+ 'Date Filed: ' + ISNULL(CONVERT(varchar,GND.Date_Filed),'') + char(10)
		+ 'Date Terminated: ' + ISNULL(CONVERT(varchar,GND.Date_Terminated),'') + char(10)
		+ 'Employer Address 1: ' + ISNULL(GND.Employer_Address1,'') + char(10)
		+ 'Employer Address 2: ' + ISNULL(GND.Employer_Address2,'') + char(10)
		+ 'Filing Type: ' + ISNULL(GND.Filing_Type,'') + char(10)
			AS DocketText
        ,ROW_NUMBER() OVER(PARTITION BY G.Civil_Case_Id, GND.Date_Filed ORDER BY GND.Date_Filed) AS DocketSequenceNumber
        ,0 AS ReferenceNumber
        ,0 AS AssignReferenceNumber
        ,0 AS WebSubmit
        ,0 AS HideFromWeb
        ,0 AS Highlight
        ,0 AS AutoDocketFieldID
        ,'Garnishment_Number_Details' AS SourceTableName
        ,GND.Garnishment_Id AS SourceTableID
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
        ,ROW_NUMBER() OVER(PARTITION BY CC.Civil_Case_Id ORDER BY GND.Date_Filed) AS CCISSequenceNumber
        ,0 AS AssignedByUserID
        ,NULL AS AssignedDate
        ,1 AS CreateByUserID
        ,ISNULL(GND.Date_Filed, CURRENT_TIMESTAMP) AS CreateDate
        ,1 AS ModifyByUserID
        ,ISNULL(GND.Date_Filed, CURRENT_TIMESTAMP) AS ModifyDate
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
FROM test_source.dbo.Garnishment_Number_Details GND WITH (NOLOCK)
	INNER JOIN test_source.dbo.Garnishments G WITH (NOLOCK) ON G.Garnishment_Id = GND.Garnishment_Id
	INNER JOIN test_source.dbo.Civil_Cases CC WITH (NOLOCK) ON CC.Civil_Case_Id = G.Civil_Case_Id
	INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = CC.Case_Number
	INNER JOIN tblParty P WITH (NOLOCK) ON P.PartyID = C.FirstDefendantID
