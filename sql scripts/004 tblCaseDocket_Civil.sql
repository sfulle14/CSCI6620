
--CIVIL DOCKETS

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
        ,CD.Date_Of_Entry AS DocketDate
        ,LEFT(ISNULL(LTRIM(RTRIM(CD.Description)),''),5000) AS DocketText
        ,ROW_NUMBER() OVER(PARTITION BY CD.Civil_Case_Id, CD.Date_Of_Entry ORDER BY CD.Date_Of_Entry) AS DocketSequenceNumber
        ,0 AS ReferenceNumber
        ,0 AS AssignReferenceNumber
        ,0 AS WebSubmit
        ,0 AS HideFromWeb
        ,0 AS Highlight
        ,0 AS AutoDocketFieldID
        ,'Civil_Dockets' AS SourceTableName
        ,CD.Civil_Docket_Id AS SourceTableID
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
        ,ROW_NUMBER() OVER(PARTITION BY CD.Civil_Case_Id ORDER BY CD.Date_Of_Entry) AS CCISSequenceNumber
        ,0 AS AssignedByUserID
        ,NULL AS AssignedDate
        ,XP.PartyID AS CreateByUserID
        ,CD.Date_Of_Entry AS CreateDate
        ,XP.PartyID AS ModifyByUserID
        ,CD.Date_Of_Entry AS ModifyDate
        ,0 AS LockedByPartyID
        ,0 AS RegistryFlag
        ,ISNULL(CONVERT(VARCHAR,CD.User_Id),'') AS FiledBy
        ,0 AS IsSealed
        ,0 AS RedactStatus
        ,0 AS RedactID
        ,'' AS DocketStatus
        ,0 AS GarnishmentFlag
        ,0 AS DisburseGarnishmentFunds
        ,0 AS HasOCR
        ,0 AS ICPEventID
        ,0 AS VORStatus
        ,ISNULL(CD.Civil_Case_Id,0) AS OriginalERecordID
    FROM test_source.dbo.Civil_Dockets CD WITH (NOLOCK)
         INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseID = CD.Civil_Case_Id
         LEFT OUTER JOIN XREF_tblParty_UserID XP WITH (NOLOCK) ON XP.UserID = CONVERT(VARCHAR(50),CD.User_Id)
--2,736,555  (SELECT 5:32) (INSERT 1:47)
