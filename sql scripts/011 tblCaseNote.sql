INSERT INTO tblCaseNote
	(CaseID
	,CaseDocketID
	,NoteDate
	,NoteText
	,PrivateNote
	,CreateByUserID
	,CreateDate
	,ModifyByUserID
	,ModifyDate)
SELECT 
	C.CaseID AS CaseID
	,NULL AS CaseDocketID
	--,CD.CaseDocketID AS CaseDocketID
	,C.CaseOpenDate AS NoteDate
	,('GBS Employment History: ' + '    '
		+'Employer: ' + EH.Employer + '    '
		+ 'Address: ' + ISNULL(EH.Address,'') + '    '
		+ 'Phone: ' + ISNULL(EH.Phone,'') + '    '
		+ 'Hire Date: ' + ISNULL(CONVERT(VARCHAR,EH.Hire_Date),'') + '    '
		+ 'Term Date: ' + ISNULL(CONVERT(VARCHAR,EH.Term_Date),'') + '    '
		+ 'Full Time: ' + ISNULL(CONVERT(VARCHAR,EH.FullTime),'') + '    '
		+ 'Occupation: ' + ISNULL(EH.Occupation, '') + '    '
		+ 'Service Time: ' + ISNULL(EH.Service_Time, '') + '    '
		+ 'Supervisor: ' + ISNULL(EH.SuperVisor,'') + '    '
		+ 'Income level: ' + ISNULL(CONVERT(VARCHAR,EH.Income_Level),'') + '    ') AS NoteText
	,1 AS PrivateNote
	,C.CreateByUserID AS CreateByUserID
	,C.CreateDate AS CreateDate
	,C.ModifyByUserID AS ModifyByUserID
	,CURRENT_TIMESTAMP AS ModifyDate	
FROM test_source.dbo.EmploymentHistory EH WITH (NOLOCK)
	LEFT OUTER JOIN tblCase C WITH (NOLOCK) ON EH.Case_Number = C.CaseNumber
	--LEFT OUTER JOIN tblCaseDocket CD WITH (NOLOCK) ON C.CaseID = CD.CaseID
-- 1,812 rows



INSERT INTO tblCaseNote
	(CaseID
	,CaseDocketID
	,NoteDate
	,NoteText
	,PrivateNote
	,CreateByUserID
	,CreateDate
	,ModifyByUserID
	,ModifyDate)
SELECT
	C.CaseID as CaseID
	,NULL AS CaseDocketID
	,CV.Date_Created AS NoteDate
	,CV.Body AS NoteText
	,4 AS PrivateNote
	,CV.User_Id AS CreateByUserID
	,CV.Date_Created AS CreateDate
	,CV.User_Id AS ModifyByUserID
	,CV.Date_Created AS ModifyDate
FROM test_source.dbo.CV_Comments CV WITH (NOLOCK)
	LEFT OUTER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = CV.Case_Violation_Id
	WHERE (CV.Case_Violation_Id IS NOT NULL and CV.Case_Violation_Id != '') and CV.Body IS NOT NULL
-- 105 rows


--GBDI-854:Convert Select Data from dbo.Diversions to tblCaseNotes
INSERT INTO tblCaseNote
	(CaseID
	,CaseDocketID
	,NoteDate
	,NoteText
	,PrivateNote
	,CreateByUserID
	,CreateDate
	,ModifyByUserID
	,ModifyDate)
SELECT
	 C.CaseID AS CaseID
	,NULL AS CaseDocketID
	,D.Date_Requested AS NoteDate
	,('Description: ' + DP.Diversion_Program + '  ' + D.Remarks)  AS NoteText
	,1 AS PrivateNote
	,NULL AS CreateByUserID
	,NULL AS CreateDate
	,NULL AS ModifyByUserID
	,NULL AS ModifyDate
FROM test_source.dbo.Diversions D WITH (NOLOCK)
	LEFT OUTER JOIN test_source.dbo.Diversion_Programs DP WITH (NOLOCK) ON Dp.Diversion_Program_Id = D.Program_Id
	LEFT OUTER JOIN SQL_Target.dbo.tblCase C WITH (NOLOCK) ON C.CaseNumber = D.Case_Number
--190 rows

