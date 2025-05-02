from Connection import connect_to_db

def tblCaseDocket_garnishments():
  # Establishing the connection
  conn = connect_to_db()
  cursor = conn.cursor()

  sql_query = """
  --CIVIL DOCKETS for Garnishments

  DECLARE @DKTCODE INT = ISNULL((SELECT TOP 1 DocketCodeID FROM tblDocketCode WITH (NOLOCK) WHERE DocketCode = 'CCVGARN'),0)


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
          ,ISNULL(G.Date_Filed,CURRENT_TIMESTAMP) AS DocketDate
          ,'Default Attorney: ' + ISNULL(BMP.Name,'') + char(10)
        +'Asked Amount: ' + ISNULL(CONVERT(varchar,G.Asked_Amount),'') + char(10)
        +'Comment: ' + ISNULL(G.Comment, '') + char(10)
        AS DocketText
          ,ROW_NUMBER() OVER(PARTITION BY G.Civil_Case_Id, G.Date_Filed ORDER BY G.Date_Filed) AS DocketSequenceNumber
          ,0 AS ReferenceNumber
          ,0 AS AssignReferenceNumber
          ,0 AS WebSubmit
          ,0 AS HideFromWeb
          ,0 AS Highlight
          ,0 AS AutoDocketFieldID
          ,'Garnishments' AS SourceTableName
          ,G.Garnishment_Id AS SourceTableID
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
          ,ROW_NUMBER() OVER(PARTITION BY CC.Civil_Case_Id ORDER BY G.Date_Filed) AS CCISSequenceNumber
          ,0 AS AssignedByUserID
          ,NULL AS AssignedDate
          ,1 AS CreateByUserID
          ,ISNULL(G.Date_Filed, CURRENT_TIMESTAMP) AS CreateDate
          ,1 AS ModifyByUserID
          ,ISNULL(G.Date_Filed, CURRENT_TIMESTAMP) AS ModifyDate
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
      FROM test_source.dbo.Garnishments G WITH (NOLOCK)
      INNER JOIN test_source.dbo.Civil_Cases CC WITH (NOLOCK) ON CC.Civil_Case_Id = G.Civil_Case_Id
      INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = CC.Case_Number
      INNER JOIN tblParty BMP WITH (NOLOCK) ON BMP.WebValidation = convert(varchar,G.Attorney_Id)
      """

  #Executing the query
  cursor.execute(sql_query)
  conn.commit()

  #Closing the connection
  cursor.close()
  conn.close()