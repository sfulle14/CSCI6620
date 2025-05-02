from Connection import connect_to_db

def tblCaseCompliance():
    # Establishing the connection
    conn = connect_to_db()
    cursor = conn.cursor()

    sql_query = """
	DECLARE @CompTypeID INT = (select ComplianceTypeID from tblComplianceType where ComplianceTypeCode = 'BMVLF')

	INSERT INTO dbo.tblCaseCompliance
			(ComplianceType
			,CaseID
			,CaseFeeID
			,CaseChargeID
			,ComplianceTypeID
			,SourceTableName
			,SourceTableID
			,RequiredBy
			,Hold
			,Complete
			,ComplianceAction
			,DateActionOrdered
			,DateActionIssued
			,TCATSD6Action
			,CompleteDate
			,Comment
			,CreateByUserID
			,CreateDate
			,ModifyByUserID
			,ModifyDate
			,RequiredAmount
			,RequiredUnits
			,RequiredBalance
			,AssignedToPartyID)
	SELECT
		@CompTypeID AS ComplianceType
		,CC.CaseID AS CaseID
		,NULL AS CaseFeeID
		,CC.CaseChargeID AS CaseChargeID
		,@CompTypeID AS ComplianceTypeID
		,'License_Forfeitures' AS SourceTableName
		,NULL AS SourceTableID
		,LF.Date_Released AS RequiredBy
		,NULL AS Hold
		,1 AS Complete
		,'BMVSENT' AS ComplianceAction
		,LF.Date_Forfeited AS DateActionOrdered
		,LF.Date_Forfeited AS DateActionIssued
		,NULL AS TCATSD6Action
		,NULL AS CompleteDate
		,NULL AS Comment
		,1 AS CreateByUserID
		,LF.Date_Forfeited AS CreateDate
		,1 AS ModifyByUserID
		,CURRENT_TIMESTAMP AS ModifyDate
		,NULL AS RequiredAmount
		,NULL AS RequiredUnits
		,NULL AS RequiredBalance
		,NULL AS AssignedToPartyID
	FROM test_source.dbo.License_Forfeitures LF WITH (NOLOCK)
		INNER JOIN tblCaseCharge CC WITH (NOLOCK) ON CC.RefNumber = LF.Case_Violation_Id
	WHERE (LF.Date_Forfeited IS NOT NULL OR LF.Date_Released IS NOT NULL)
    """
    
    #Executing the query
    cursor.execute(sql_query)
    conn.commit()

    #Closing the connection
    cursor.close()
    conn.close()