from Connection import connect_to_db

def tblCaseDocket_civil_Judgments():
  # Establishing the connection
  conn = connect_to_db()
  cursor = conn.cursor()

  sql_query = """
  --CIVIL DOCKETS for Civil_Judgments

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
          ,158 AS DocketCodeID
          ,ISNULL(CJ.Date_Of_Judgment,CURRENT_TIMESTAMP) AS DocketDate
          ,'Judgment_Rendered: ' + ISNULL(CJ.Judgment_Rendered,'') + char(10)
      + 'Date_Of_Judgment: ' + CONVERT(varchar,ISNULL(CJ.Date_Of_Judgment,'')) + char(10)
      + 'Amount_Of_Judgment: ' + CONVERT(varchar,ISNULL(CJ.Amount_Of_Judgment,'')) + char(10) 
      + 'Date_From: ' + CONVERT(varchar,ISNULL(CJ.Date_From,'')) + char(10)
      + 'Date_To: ' + CONVERT(varchar,ISNULL(CJ.Date_To,'')) + char(10)
      + 'APR: ' + CONVERT(varchar,ISNULL(CJ.APR,'')) + char(10)
      + 'Total_Interest: ' + CONVERT(varchar,ISNULL(CJ.Total_Interest,'')) + char(10)
      + 'Total_Costs: ' + CONVERT(varchar,ISNULL(CJ.Total_Costs,'')) + char(10)
      + 'Satisfied: ' + CASE CJ.Satisfied WHEN 1 THEN 'YES' ELSE 'NO' END + char(10)
      + 'Date_Satisfied: ' + CONVERT(varchar,ISNULL(CJ.Date_Satisfied,'')) + char(10)
      + 'Comment: ' + ISNULL(CJ.Comment,'') + char(10)
        AS DocketText
          ,ROW_NUMBER() OVER(PARTITION BY CJ.Civil_Case_Id, CJ.Date_Of_Judgment ORDER BY CJ.Date_Of_Judgment) AS DocketSequenceNumber
          ,0 AS ReferenceNumber
          ,0 AS AssignReferenceNumber
          ,0 AS WebSubmit
          ,0 AS HideFromWeb
          ,0 AS Highlight
          ,0 AS AutoDocketFieldID
          ,'Civil_Judgments' AS SourceTableName
          ,CJ.Civil_Case_Id AS SourceTableID
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
          ,ROW_NUMBER() OVER(PARTITION BY CC.Civil_Case_Id ORDER BY CJ.Date_Of_Judgment) AS CCISSequenceNumber
          ,0 AS AssignedByUserID
          ,NULL AS AssignedDate
          ,CC.User_Id AS CreateByUserID
          ,ISNULL(CJ.Date_Of_Judgment,CURRENT_TIMESTAMP) AS CreateDate
          ,CC.User_Id AS ModifyByUserID
          ,ISNULL(CJ.Date_Of_Judgment,CURRENT_TIMESTAMP) AS ModifyDate
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
      FROM test_source.dbo.Civil_Judgments CJ WITH (NOLOCK)
      INNER JOIN test_source.dbo.Civil_Cases CC WITH (NOLOCK) ON CC.Civil_Case_Id = CJ.Civil_Case_Id
      INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = CC.Case_Number
    """
  
  #Executing the query
  cursor.execute(sql_query)
  conn.commit()

  #Closing the connection
  cursor.close()
  conn.close()