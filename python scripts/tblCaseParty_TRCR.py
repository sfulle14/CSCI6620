from Connection import connect_to_db

def tblCaseParty_trcr():
    # Establishing the connection
    conn = connect_to_db()
    cursor = conn.cursor()

    sql_query = """
    --TRAFFIC CRIMINAL CASES - DEFENDANTS
    INSERT INTO tblCaseParty
                (CaseID
                ,PartyID
                ,CasePartyType
                ,CasePartySubType
                ,PartySequence
                ,ParentCasePartyID
                ,DispositionCode
                ,DispositionDate
                ,DeactivateDate
                ,DispositionJudgeID
                ,JudgementAmount
                ,ForeclosureSaleDate
                ,ForeclosureSaleAmount
                ,TitleIssueDate
                ,DocStamps
                ,ClaimDate
                ,ClaimAmount
                ,ClaimObjected
                ,ClaimType
                ,AnswerDate
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,DrivingPrivilegesRevokedDate
                ,VotingPrivilegesRevokedDate
                ,DrivingPrivilegesRestoredDate
                ,VotingPrivilegesRestoredDate
                ,ExaminingDoctorPartyID
                ,ExaminingDoctorAssignedDate
                ,ExaminingPsychiatristPartyID
                ,ExaminingPsychiatristAssignedDate
                ,ExaminingNeutralPartyPartyID
                ,ExaminingNuetralPartyAssignedDate
                ,OriginalPartyID
                ,PartySecurity
                ,AppointDate
                ,PartyAlertCode
                ,ClaimObjectedDate
                ,CountyOfResidence
                ,StateOfResidence
                ,BirthPlace
                ,MaidenSurname
                ,EffectiveDate_Marriage
                ,ExpirationDate_Marriage
                ,PreviouslyMarried
                ,NumberOfThisMarriage
                ,LastMarriageEndedReason
                ,LastMarriageEndedDate
                ,LastMarriageEndedCaseNumber
                ,LastMarriageEndedSpouseName
                ,LastMarriageEndedState
                ,LastMarriageEndedCounty
                ,Passport_NIS_Number
                ,Occupation
                ,FatherName
                ,MotherMaidenName
                ,MinorChildren
                ,DisplayPartyNameID)
    SELECT -- CasePartyID
            C.CaseID AS CaseID
            ,C.FirstDefendantID AS PartyID
            ,'DEF' AS CasePartyType
            ,'' AS CasePartySubType
            ,1 AS PartySequence
            ,0 AS ParentCasePartyID
            ,CV.Original_Plea_Id AS DispositionCode		--GBDI-875
            ,CV.Date_Original_Plea AS DispositionDate
            --,C.DispositionCode AS DispositionCode		--GBDI-875
            --,C.DispositionDate AS DispositionDate
            ,NULL AS DeactivateDate
            ,C.DispositionJudgeID AS DispositionJudgeID
            ,0 AS JudgementAmount
            ,NULL AS ForeclosureSaleDate
            ,0 AS ForeclosureSaleAmount
            ,NULL AS TitleIssueDate
            ,0 AS DocStamps
            ,NULL AS ClaimDate
            ,0 AS ClaimAmount
            ,0 AS ClaimObjected
            ,'' AS ClaimType
            ,NULL AS AnswerDate
            ,C.CreateByUserID AS CreateByUserID
            ,C.CreateDate AS CreateDate
            ,C.ModifyByUserID AS ModifyByUserID
            ,C.ModifyDate AS ModifyDate
            ,NULL AS DrivingPrivilegesRevokedDate
            ,NULL AS VotingPrivilegesRevokedDate
            ,NULL AS DrivingPrivilegesRestoredDate
            ,NULL AS VotingPrivilegesRestoredDate
            ,0 AS ExaminingDoctorPartyID
            ,NULL AS ExaminingDoctorAssignedDate
            ,0 AS ExaminingPsychiatristPartyID
            ,NULL AS ExaminingPsychiatristAssignedDate
            ,0 AS ExaminingNeutralPartyPartyID
            ,NULL AS ExaminingNuetralPartyAssignedDate
            ,0 AS OriginalPartyID
            ,0 AS PartySecurity
            ,NULL AS AppointDate
            ,'' AS PartyAlertCode
            ,NULL AS ClaimObjectedDate
            ,'' AS CountyOfResidence
            ,'' AS StateOfResidence
            ,'' AS BirthPlace
            ,'' AS MaidenSurname
            ,NULL AS EffectiveDate_Marriage
            ,NULL AS ExpirationDate_Marriage
            ,0 AS PreviouslyMarried
            ,0 AS NumberOfThisMarriage
            ,'' AS LastMarriageEndedReason
            ,NULL AS LastMarriageEndedDate
            ,'' AS LastMarriageEndedCaseNumber
            ,'' AS LastMarriageEndedSpouseName
            ,'' AS LastMarriageEndedState
            ,'' AS LastMarriageEndedCounty
            ,PD.WebValidation AS Passport_NIS_Number
            ,'' AS Occupation
            ,SUBSTRING(C.CaseNumber,5,2) AS FatherName
            ,PD.Name AS MotherMaidenName
            ,0 AS MinorChildren
            ,0 AS DisplayPartyNameID
        FROM test_source.dbo.Traffic_Criminal_Cases TCC WITH (NOLOCK)
            INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = TCC.Case_Number
            INNER JOIN tblParty PD WITH (NOLOCK) ON PD.PartyID = C.FirstDefendantID
            INNER JOIN test_source.dbo.Case_Violations CV WITH (NOLOCK) ON CV.Case_Number = C.CaseNumber AND CV.Counter = 1 
    --379,370

    --TRAFFIC CRIMINAL CASES - DEFENDANT ATTORNEYS
    INSERT INTO tblCaseParty
                (CaseID
                ,PartyID
                ,CasePartyType
                ,CasePartySubType
                ,PartySequence
                ,ParentCasePartyID
                ,DispositionCode
                ,DispositionDate
                ,DeactivateDate
                ,DispositionJudgeID
                ,JudgementAmount
                ,ForeclosureSaleDate
                ,ForeclosureSaleAmount
                ,TitleIssueDate
                ,DocStamps
                ,ClaimDate
                ,ClaimAmount
                ,ClaimObjected
                ,ClaimType
                ,AnswerDate
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,DrivingPrivilegesRevokedDate
                ,VotingPrivilegesRevokedDate
                ,DrivingPrivilegesRestoredDate
                ,VotingPrivilegesRestoredDate
                ,ExaminingDoctorPartyID
                ,ExaminingDoctorAssignedDate
                ,ExaminingPsychiatristPartyID
                ,ExaminingPsychiatristAssignedDate
                ,ExaminingNeutralPartyPartyID
                ,ExaminingNuetralPartyAssignedDate
                ,OriginalPartyID
                ,PartySecurity
                ,AppointDate
                ,PartyAlertCode
                ,ClaimObjectedDate
                ,CountyOfResidence
                ,StateOfResidence
                ,BirthPlace
                ,MaidenSurname
                ,EffectiveDate_Marriage
                ,ExpirationDate_Marriage
                ,PreviouslyMarried
                ,NumberOfThisMarriage
                ,LastMarriageEndedReason
                ,LastMarriageEndedDate
                ,LastMarriageEndedCaseNumber
                ,LastMarriageEndedSpouseName
                ,LastMarriageEndedState
                ,LastMarriageEndedCounty
                ,Passport_NIS_Number
                ,Occupation
                ,FatherName
                ,MotherMaidenName
                ,MinorChildren
                ,DisplayPartyNameID)
    SELECT -- CasePartyID
            C.CaseID AS CaseID
            ,C.DefendantAttorneyID AS PartyID
            ,'ATT' AS CasePartyType
            ,'' AS CasePartySubType
            ,1 AS PartySequence
            ,CPD.CasePartyID AS ParentCasePartyID
            ,NULL AS DispositionCode		--GBDI-875
            ,NULL AS DispositionDate
            ,NULL AS DeactivateDate
            ,C.DispositionJudgeID AS DispositionJudgeID
            ,0 AS JudgementAmount
            ,NULL AS ForeclosureSaleDate
            ,0 AS ForeclosureSaleAmount
            ,NULL AS TitleIssueDate
            ,0 AS DocStamps
            ,NULL AS ClaimDate
            ,0 AS ClaimAmount
            ,0 AS ClaimObjected
            ,'' AS ClaimType
            ,NULL AS AnswerDate
            ,C.CreateByUserID AS CreateByUserID
            ,C.CreateDate AS CreateDate
            ,C.ModifyByUserID AS ModifyByUserID
            ,C.ModifyDate AS ModifyDate
            ,NULL AS DrivingPrivilegesRevokedDate
            ,NULL AS VotingPrivilegesRevokedDate
            ,NULL AS DrivingPrivilegesRestoredDate
            ,NULL AS VotingPrivilegesRestoredDate
            ,0 AS ExaminingDoctorPartyID
            ,NULL AS ExaminingDoctorAssignedDate
            ,0 AS ExaminingPsychiatristPartyID
            ,NULL AS ExaminingPsychiatristAssignedDate
            ,0 AS ExaminingNeutralPartyPartyID
            ,NULL AS ExaminingNuetralPartyAssignedDate
            ,0 AS OriginalPartyID
            ,0 AS PartySecurity
            ,NULL AS AppointDate
            ,'' AS PartyAlertCode
            ,NULL AS ClaimObjectedDate
            ,'' AS CountyOfResidence
            ,'' AS StateOfResidence
            ,'' AS BirthPlace
            ,'' AS MaidenSurname
            ,NULL AS EffectiveDate_Marriage
            ,NULL AS ExpirationDate_Marriage
            ,0 AS PreviouslyMarried
            ,0 AS NumberOfThisMarriage
            ,'' AS LastMarriageEndedReason
            ,NULL AS LastMarriageEndedDate
            ,'' AS LastMarriageEndedCaseNumber
            ,'' AS LastMarriageEndedSpouseName
            ,'' AS LastMarriageEndedState
            ,'' AS LastMarriageEndedCounty
            ,PDA.WebValidation AS Passport_NIS_Number
            ,'' AS Occupation
            ,SUBSTRING(C.CaseNumber,5,2) AS FatherName
            ,PDA.Name AS MotherMaidenName
            ,0 AS MinorChildren
            ,0 AS DisplayPartyNameID
        FROM test_source.dbo.Traffic_Criminal_Cases TCC WITH (NOLOCK)
            INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = TCC.Case_Number
            INNER JOIN tblParty PDA WITH (NOLOCK) ON PDA.PartyID = C.DefendantAttorneyID
            INNER JOIN tblCaseParty CPD WITH (NOLOCK) ON CPD.CaseID = C.CaseID AND CPD.PartyID = C.FirstDefendantID
    --12,066

    --TRAFFIC CRIMINAL CASES - JUDGES
    INSERT INTO tblCaseParty
                (CaseID
                ,PartyID
                ,CasePartyType
                ,CasePartySubType
                ,PartySequence
                ,ParentCasePartyID
                ,DispositionCode
                ,DispositionDate
                ,DeactivateDate
                ,DispositionJudgeID
                ,JudgementAmount
                ,ForeclosureSaleDate
                ,ForeclosureSaleAmount
                ,TitleIssueDate
                ,DocStamps
                ,ClaimDate
                ,ClaimAmount
                ,ClaimObjected
                ,ClaimType
                ,AnswerDate
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,DrivingPrivilegesRevokedDate
                ,VotingPrivilegesRevokedDate
                ,DrivingPrivilegesRestoredDate
                ,VotingPrivilegesRestoredDate
                ,ExaminingDoctorPartyID
                ,ExaminingDoctorAssignedDate
                ,ExaminingPsychiatristPartyID
                ,ExaminingPsychiatristAssignedDate
                ,ExaminingNeutralPartyPartyID
                ,ExaminingNuetralPartyAssignedDate
                ,OriginalPartyID
                ,PartySecurity
                ,AppointDate
                ,PartyAlertCode
                ,ClaimObjectedDate
                ,CountyOfResidence
                ,StateOfResidence
                ,BirthPlace
                ,MaidenSurname
                ,EffectiveDate_Marriage
                ,ExpirationDate_Marriage
                ,PreviouslyMarried
                ,NumberOfThisMarriage
                ,LastMarriageEndedReason
                ,LastMarriageEndedDate
                ,LastMarriageEndedCaseNumber
                ,LastMarriageEndedSpouseName
                ,LastMarriageEndedState
                ,LastMarriageEndedCounty
                ,Passport_NIS_Number
                ,Occupation
                ,FatherName
                ,MotherMaidenName
                ,MinorChildren
                ,DisplayPartyNameID)
    SELECT -- CasePartyID
            C.CaseID AS CaseID
            ,C.JudgeID AS PartyID
            ,'JDG' AS CasePartyType
            ,'' AS CasePartySubType
            ,1 AS PartySequence
            ,0 AS ParentCasePartyID
            ,NULL AS DispositionCode		--GBDI-875
            ,NULL AS DispositionDate
            ,NULL AS DeactivateDate
            ,C.DispositionJudgeID AS DispositionJudgeID
            ,0 AS JudgementAmount
            ,NULL AS ForeclosureSaleDate
            ,0 AS ForeclosureSaleAmount
            ,NULL AS TitleIssueDate
            ,0 AS DocStamps
            ,NULL AS ClaimDate
            ,0 AS ClaimAmount
            ,0 AS ClaimObjected
            ,'' AS ClaimType
            ,NULL AS AnswerDate
            ,C.CreateByUserID AS CreateByUserID
            ,C.CreateDate AS CreateDate
            ,C.ModifyByUserID AS ModifyByUserID
            ,C.ModifyDate AS ModifyDate
            ,NULL AS DrivingPrivilegesRevokedDate
            ,NULL AS VotingPrivilegesRevokedDate
            ,NULL AS DrivingPrivilegesRestoredDate
            ,NULL AS VotingPrivilegesRestoredDate
            ,0 AS ExaminingDoctorPartyID
            ,NULL AS ExaminingDoctorAssignedDate
            ,0 AS ExaminingPsychiatristPartyID
            ,NULL AS ExaminingPsychiatristAssignedDate
            ,0 AS ExaminingNeutralPartyPartyID
            ,NULL AS ExaminingNuetralPartyAssignedDate
            ,0 AS OriginalPartyID
            ,0 AS PartySecurity
            ,NULL AS AppointDate
            ,'' AS PartyAlertCode
            ,NULL AS ClaimObjectedDate
            ,'' AS CountyOfResidence
            ,'' AS StateOfResidence
            ,'' AS BirthPlace
            ,'' AS MaidenSurname
            ,NULL AS EffectiveDate_Marriage
            ,NULL AS ExpirationDate_Marriage
            ,0 AS PreviouslyMarried
            ,0 AS NumberOfThisMarriage
            ,'' AS LastMarriageEndedReason
            ,NULL AS LastMarriageEndedDate
            ,'' AS LastMarriageEndedCaseNumber
            ,'' AS LastMarriageEndedSpouseName
            ,'' AS LastMarriageEndedState
            ,'' AS LastMarriageEndedCounty
            ,PJ.WebValidation AS Passport_NIS_Number
            ,'' AS Occupation
            ,SUBSTRING(C.CaseNumber,5,2) AS FatherName
            ,PJ.Name AS MotherMaidenName
            ,0 AS MinorChildren
            ,0 AS DisplayPartyNameID
        FROM test_source.dbo.Traffic_Criminal_Cases TCC WITH (NOLOCK)
            INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = TCC.Case_Number
            INNER JOIN tblParty PJ WITH (NOLOCK) ON PJ.PartyID = C.JudgeID
    --63,581

    --TRAFFIC CRIMINAL CASES - AGENCIES
    INSERT INTO tblCaseParty
                (CaseID
                ,PartyID
                ,CasePartyType
                ,CasePartySubType
                ,PartySequence
                ,ParentCasePartyID
                ,DispositionCode
                ,DispositionDate
                ,DeactivateDate
                ,DispositionJudgeID
                ,JudgementAmount
                ,ForeclosureSaleDate
                ,ForeclosureSaleAmount
                ,TitleIssueDate
                ,DocStamps
                ,ClaimDate
                ,ClaimAmount
                ,ClaimObjected
                ,ClaimType
                ,AnswerDate
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,DrivingPrivilegesRevokedDate
                ,VotingPrivilegesRevokedDate
                ,DrivingPrivilegesRestoredDate
                ,VotingPrivilegesRestoredDate
                ,ExaminingDoctorPartyID
                ,ExaminingDoctorAssignedDate
                ,ExaminingPsychiatristPartyID
                ,ExaminingPsychiatristAssignedDate
                ,ExaminingNeutralPartyPartyID
                ,ExaminingNuetralPartyAssignedDate
                ,OriginalPartyID
                ,PartySecurity
                ,AppointDate
                ,PartyAlertCode
                ,ClaimObjectedDate
                ,CountyOfResidence
                ,StateOfResidence
                ,BirthPlace
                ,MaidenSurname
                ,EffectiveDate_Marriage
                ,ExpirationDate_Marriage
                ,PreviouslyMarried
                ,NumberOfThisMarriage
                ,LastMarriageEndedReason
                ,LastMarriageEndedDate
                ,LastMarriageEndedCaseNumber
                ,LastMarriageEndedSpouseName
                ,LastMarriageEndedState
                ,LastMarriageEndedCounty
                ,Passport_NIS_Number
                ,Occupation
                ,FatherName
                ,MotherMaidenName
                ,MinorChildren
                ,DisplayPartyNameID)
    SELECT -- CasePartyID
            C.CaseID AS CaseID
            ,C.AgencyID AS PartyID
            ,'AGCY' AS CasePartyType
            ,'' AS CasePartySubType
            ,1 AS PartySequence
            ,0 AS ParentCasePartyID
            ,NULL AS DispositionCode		--GBDI-875
            ,NULL AS DispositionDate
            ,NULL AS DeactivateDate
            ,C.DispositionJudgeID AS DispositionJudgeID
            ,0 AS JudgementAmount
            ,NULL AS ForeclosureSaleDate
            ,0 AS ForeclosureSaleAmount
            ,NULL AS TitleIssueDate
            ,0 AS DocStamps
            ,NULL AS ClaimDate
            ,0 AS ClaimAmount
            ,0 AS ClaimObjected
            ,'' AS ClaimType
            ,NULL AS AnswerDate
            ,C.CreateByUserID AS CreateByUserID
            ,C.CreateDate AS CreateDate
            ,C.ModifyByUserID AS ModifyByUserID
            ,C.ModifyDate AS ModifyDate
            ,NULL AS DrivingPrivilegesRevokedDate
            ,NULL AS VotingPrivilegesRevokedDate
            ,NULL AS DrivingPrivilegesRestoredDate
            ,NULL AS VotingPrivilegesRestoredDate
            ,0 AS ExaminingDoctorPartyID
            ,NULL AS ExaminingDoctorAssignedDate
            ,0 AS ExaminingPsychiatristPartyID
            ,NULL AS ExaminingPsychiatristAssignedDate
            ,0 AS ExaminingNeutralPartyPartyID
            ,NULL AS ExaminingNuetralPartyAssignedDate
            ,0 AS OriginalPartyID
            ,0 AS PartySecurity
            ,NULL AS AppointDate
            ,'' AS PartyAlertCode
            ,NULL AS ClaimObjectedDate
            ,'' AS CountyOfResidence
            ,'' AS StateOfResidence
            ,'' AS BirthPlace
            ,'' AS MaidenSurname
            ,NULL AS EffectiveDate_Marriage
            ,NULL AS ExpirationDate_Marriage
            ,0 AS PreviouslyMarried
            ,0 AS NumberOfThisMarriage
            ,'' AS LastMarriageEndedReason
            ,NULL AS LastMarriageEndedDate
            ,'' AS LastMarriageEndedCaseNumber
            ,'' AS LastMarriageEndedSpouseName
            ,'' AS LastMarriageEndedState
            ,'' AS LastMarriageEndedCounty
            ,PA.WebValidation AS Passport_NIS_Number
            ,'' AS Occupation
            ,SUBSTRING(C.CaseNumber,5,2) AS FatherName
            ,PA.Name AS MotherMaidenName
            ,0 AS MinorChildren
            ,0 AS DisplayPartyNameID
        FROM test_source.dbo.Traffic_Criminal_Cases TCC WITH (NOLOCK)
            INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = TCC.Case_Number
            INNER JOIN tblParty PA WITH (NOLOCK) ON PA.PartyID = C.AgencyID
    --374,809

    --TRAFFIC CRIMINAL CASES - OFFICERS
    INSERT INTO tblCaseParty
                (CaseID
                ,PartyID
                ,CasePartyType
                ,CasePartySubType
                ,PartySequence
                ,ParentCasePartyID
                ,DispositionCode
                ,DispositionDate
                ,DeactivateDate
                ,DispositionJudgeID
                ,JudgementAmount
                ,ForeclosureSaleDate
                ,ForeclosureSaleAmount
                ,TitleIssueDate
                ,DocStamps
                ,ClaimDate
                ,ClaimAmount
                ,ClaimObjected
                ,ClaimType
                ,AnswerDate
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,DrivingPrivilegesRevokedDate
                ,VotingPrivilegesRevokedDate
                ,DrivingPrivilegesRestoredDate
                ,VotingPrivilegesRestoredDate
                ,ExaminingDoctorPartyID
                ,ExaminingDoctorAssignedDate
                ,ExaminingPsychiatristPartyID
                ,ExaminingPsychiatristAssignedDate
                ,ExaminingNeutralPartyPartyID
                ,ExaminingNuetralPartyAssignedDate
                ,OriginalPartyID
                ,PartySecurity
                ,AppointDate
                ,PartyAlertCode
                ,ClaimObjectedDate
                ,CountyOfResidence
                ,StateOfResidence
                ,BirthPlace
                ,MaidenSurname
                ,EffectiveDate_Marriage
                ,ExpirationDate_Marriage
                ,PreviouslyMarried
                ,NumberOfThisMarriage
                ,LastMarriageEndedReason
                ,LastMarriageEndedDate
                ,LastMarriageEndedCaseNumber
                ,LastMarriageEndedSpouseName
                ,LastMarriageEndedState
                ,LastMarriageEndedCounty
                ,Passport_NIS_Number
                ,Occupation
                ,FatherName
                ,MotherMaidenName
                ,MinorChildren
                ,DisplayPartyNameID)
    SELECT -- CasePartyID
            C.CaseID AS CaseID
            ,C.OfficerID AS PartyID
            ,'OFF' AS CasePartyType
            ,'' AS CasePartySubType
            ,1 AS PartySequence
            ,0 AS ParentCasePartyID
            ,NULL AS DispositionCode		--GBDI-875
            ,NULL AS DispositionDate
            ,NULL AS DeactivateDate
            ,C.DispositionJudgeID AS DispositionJudgeID
            ,0 AS JudgementAmount
            ,NULL AS ForeclosureSaleDate
            ,0 AS ForeclosureSaleAmount
            ,NULL AS TitleIssueDate
            ,0 AS DocStamps
            ,NULL AS ClaimDate
            ,0 AS ClaimAmount
            ,0 AS ClaimObjected
            ,'' AS ClaimType
            ,NULL AS AnswerDate
            ,C.CreateByUserID AS CreateByUserID
            ,C.CreateDate AS CreateDate
            ,C.ModifyByUserID AS ModifyByUserID
            ,C.ModifyDate AS ModifyDate
            ,NULL AS DrivingPrivilegesRevokedDate
            ,NULL AS VotingPrivilegesRevokedDate
            ,NULL AS DrivingPrivilegesRestoredDate
            ,NULL AS VotingPrivilegesRestoredDate
            ,0 AS ExaminingDoctorPartyID
            ,NULL AS ExaminingDoctorAssignedDate
            ,0 AS ExaminingPsychiatristPartyID
            ,NULL AS ExaminingPsychiatristAssignedDate
            ,0 AS ExaminingNeutralPartyPartyID
            ,NULL AS ExaminingNuetralPartyAssignedDate
            ,0 AS OriginalPartyID
            ,0 AS PartySecurity
            ,NULL AS AppointDate
            ,'' AS PartyAlertCode
            ,NULL AS ClaimObjectedDate
            ,'' AS CountyOfResidence
            ,'' AS StateOfResidence
            ,'' AS BirthPlace
            ,'' AS MaidenSurname
            ,NULL AS EffectiveDate_Marriage
            ,NULL AS ExpirationDate_Marriage
            ,0 AS PreviouslyMarried
            ,0 AS NumberOfThisMarriage
            ,'' AS LastMarriageEndedReason
            ,NULL AS LastMarriageEndedDate
            ,'' AS LastMarriageEndedCaseNumber
            ,'' AS LastMarriageEndedSpouseName
            ,'' AS LastMarriageEndedState
            ,'' AS LastMarriageEndedCounty
            ,PO.WebValidation AS Passport_NIS_Number
            ,'' AS Occupation
            ,SUBSTRING(C.CaseNumber,5,2) AS FatherName
            ,PO.Name AS MotherMaidenName
            ,0 AS MinorChildren
            ,0 AS DisplayPartyNameID
        FROM test_source.dbo.Traffic_Criminal_Cases TCC WITH (NOLOCK)
            INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = TCC.Case_Number
            INNER JOIN tblParty PO WITH (NOLOCK) ON PO.PartyID = C.OfficerID
    --103,000

    --TRAFFIC CRIMINAL CASES - PROBATION OFFICERS
    INSERT INTO tblCaseParty
                (CaseID
                ,PartyID
                ,CasePartyType
                ,CasePartySubType
                ,PartySequence
                ,ParentCasePartyID
                ,DispositionCode
                ,DispositionDate
                ,DeactivateDate
                ,DispositionJudgeID
                ,JudgementAmount
                ,ForeclosureSaleDate
                ,ForeclosureSaleAmount
                ,TitleIssueDate
                ,DocStamps
                ,ClaimDate
                ,ClaimAmount
                ,ClaimObjected
                ,ClaimType
                ,AnswerDate
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,DrivingPrivilegesRevokedDate
                ,VotingPrivilegesRevokedDate
                ,DrivingPrivilegesRestoredDate
                ,VotingPrivilegesRestoredDate
                ,ExaminingDoctorPartyID
                ,ExaminingDoctorAssignedDate
                ,ExaminingPsychiatristPartyID
                ,ExaminingPsychiatristAssignedDate
                ,ExaminingNeutralPartyPartyID
                ,ExaminingNuetralPartyAssignedDate
                ,OriginalPartyID
                ,PartySecurity
                ,AppointDate
                ,PartyAlertCode
                ,ClaimObjectedDate
                ,CountyOfResidence
                ,StateOfResidence
                ,BirthPlace
                ,MaidenSurname
                ,EffectiveDate_Marriage
                ,ExpirationDate_Marriage
                ,PreviouslyMarried
                ,NumberOfThisMarriage
                ,LastMarriageEndedReason
                ,LastMarriageEndedDate
                ,LastMarriageEndedCaseNumber
                ,LastMarriageEndedSpouseName
                ,LastMarriageEndedState
                ,LastMarriageEndedCounty
                ,Passport_NIS_Number
                ,Occupation
                ,FatherName
                ,MotherMaidenName
                ,MinorChildren
                ,DisplayPartyNameID)
    SELECT -- CasePartyID
            C.CaseID AS CaseID
            ,PPO.PartyID AS PartyID
            ,'PO' AS CasePartyType
            ,'' AS CasePartySubType
            ,1 AS PartySequence
            ,0 AS ParentCasePartyID
            ,NULL AS DispositionCode		--GBDI-875:
            ,NULL AS DispositionDate
            ,NULL AS DeactivateDate
            ,C.DispositionJudgeID AS DispositionJudgeID
            ,0 AS JudgementAmount
            ,NULL AS ForeclosureSaleDate
            ,0 AS ForeclosureSaleAmount
            ,NULL AS TitleIssueDate
            ,0 AS DocStamps
            ,NULL AS ClaimDate
            ,0 AS ClaimAmount
            ,0 AS ClaimObjected
            ,'' AS ClaimType
            ,NULL AS AnswerDate
            ,C.CreateByUserID AS CreateByUserID
            ,C.CreateDate AS CreateDate
            ,C.ModifyByUserID AS ModifyByUserID
            ,C.ModifyDate AS ModifyDate
            ,NULL AS DrivingPrivilegesRevokedDate
            ,NULL AS VotingPrivilegesRevokedDate
            ,NULL AS DrivingPrivilegesRestoredDate
            ,NULL AS VotingPrivilegesRestoredDate
            ,0 AS ExaminingDoctorPartyID
            ,NULL AS ExaminingDoctorAssignedDate
            ,0 AS ExaminingPsychiatristPartyID
            ,NULL AS ExaminingPsychiatristAssignedDate
            ,0 AS ExaminingNeutralPartyPartyID
            ,NULL AS ExaminingNuetralPartyAssignedDate
            ,0 AS OriginalPartyID
            ,0 AS PartySecurity
            ,NULL AS AppointDate
            ,'' AS PartyAlertCode
            ,NULL AS ClaimObjectedDate
            ,'' AS CountyOfResidence
            ,'' AS StateOfResidence
            ,'' AS BirthPlace
            ,'' AS MaidenSurname
            ,NULL AS EffectiveDate_Marriage
            ,NULL AS ExpirationDate_Marriage
            ,0 AS PreviouslyMarried
            ,0 AS NumberOfThisMarriage
            ,'' AS LastMarriageEndedReason
            ,NULL AS LastMarriageEndedDate
            ,'' AS LastMarriageEndedCaseNumber
            ,'' AS LastMarriageEndedSpouseName
            ,'' AS LastMarriageEndedState
            ,'' AS LastMarriageEndedCounty
            ,PPO.WebValidation AS Passport_NIS_Number
            ,'' AS Occupation
            ,SUBSTRING(C.CaseNumber,5,2) AS FatherName
            ,PPO.Name AS MotherMaidenName
            ,0 AS MinorChildren
            ,0 AS DisplayPartyNameID
        FROM test_source.dbo.Traffic_Criminal_Cases TCC WITH (NOLOCK)
            INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = TCC.Case_Number
            INNER JOIN test_source.dbo.Probation_Cases PC WITH (NOLOCK) ON PC.Case_Number = TCC.Case_Number
            INNER JOIN tblParty PPO WITH (NOLOCK) ON PPO.PrimaryPartyType = 'PBO' AND PPO.WebValidation = ISNULL(CONVERT(VARCHAR(255),PC.Probation_Officer_Id),'')
    --9,380
    """
    
    #Executing the query
    cursor.execute(sql_query)
    conn.commit()

    #Closing the connection
    cursor.close()
    conn.close()