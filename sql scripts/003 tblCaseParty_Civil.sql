
--CIVIL CASES - PLAINTIFFS

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
        ,PP.PartyID AS PartyID
        ,'PLTF' AS CasePartyType
        ,'' AS CasePartySubType
        ,ROW_NUMBER() OVER(PARTITION BY P.Civil_Case_Id ORDER BY P.Plaintiff_Id) AS PartySequence
        ,0 AS ParentCasePartyID
        ,C.DispositionCode AS DispositionCode
        ,C.DispositionDate AS DispositionDate
        ,NULL AS DeactivateDate
        ,C.DispositionJudgeID AS DispositionJudgeID
        ,C.JudgmentAmount AS JudgementAmount
        ,NULL AS ForeclosureSaleDate
        ,0 AS ForeclosureSaleAmount
        ,NULL AS TitleIssueDate
        ,0 AS DocStamps
        ,C.CaseOpenDate AS ClaimDate
        ,C.ClaimAmount AS ClaimAmount
        ,0 AS ClaimObjected
        ,'' AS ClaimType
        ,CC.Answer_Date AS AnswerDate
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
        ,P.Plaintiff_Id AS OriginalPartyID
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
        ,PP.WebValidation AS Passport_NIS_Number
        ,'' AS Occupation
        ,SUBSTRING(C.CaseNumber,5,2) AS FatherName
        ,PP.Name AS MotherMaidenName
        ,0 AS MinorChildren
        ,0 AS DisplayPartyNameID
    FROM test_source.dbo.Civil_Cases CC WITH (NOLOCK)
         INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseID = CC.Civil_Case_Id
         INNER JOIN test_source.dbo.Plaintiffs P WITH (NOLOCK) ON P.Civil_Case_Id = CC.Civil_Case_Id
         INNER JOIN tblParty PP WITH (NOLOCK) ON PP.FamilyCode = 'PUBLIC' AND PP.WebValidation = CONVERT(VARCHAR(255),P.Plaintiff_SSN)
--86,717


--CIVIL CASES - PLAINTIFF ATTORNEYS

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
        ,PPA.PartyID AS PartyID
        ,'ATT' AS CasePartyType
        ,'' AS CasePartySubType
        ,ROW_NUMBER() OVER(PARTITION BY PA.Plaintiff_Id ORDER BY PA.Main_Attorney DESC, PA.Attorney_Id) AS PartySequence
        ,CPP.CasePartyID AS ParentCasePartyID
        ,C.DispositionCode AS DispositionCode
        ,C.DispositionDate AS DispositionDate
        ,NULL AS DeactivateDate
        ,C.DispositionJudgeID AS DispositionJudgeID
        ,C.JudgmentAmount AS JudgementAmount
        ,NULL AS ForeclosureSaleDate
        ,0 AS ForeclosureSaleAmount
        ,NULL AS TitleIssueDate
        ,0 AS DocStamps
        ,C.CaseOpenDate AS ClaimDate
        ,C.ClaimAmount AS ClaimAmount
        ,0 AS ClaimObjected
        ,'' AS ClaimType
        ,CC.Answer_Date AS AnswerDate
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
        ,PA.Attorney_Id AS OriginalPartyID
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
        ,PP.WebValidation AS Passport_NIS_Number
        ,'' AS Occupation
        ,SUBSTRING(C.CaseNumber,5,2) AS FatherName
        ,PPA.Name AS MotherMaidenName
        ,0 AS MinorChildren
        ,0 AS DisplayPartyNameID
    FROM test_source.dbo.Civil_Cases CC WITH (NOLOCK)
         INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseID = CC.Civil_Case_Id
         INNER JOIN test_source.dbo.Plaintiffs P WITH (NOLOCK) ON P.Civil_Case_Id = CC.Civil_Case_Id
         INNER JOIN tblParty PP WITH (NOLOCK) ON PP.FamilyCode = 'PUBLIC' AND PP.WebValidation = CONVERT(VARCHAR(255),P.Plaintiff_SSN)
         INNER JOIN tblCaseParty CPP WITH (NOLOCK) ON CPP.CaseID = C.CaseID AND CPP.PartyID = PP.PartyID
         INNER JOIN test_source.dbo.Plaintiff_Attorneys PA WITH (NOLOCK) ON PA.Plaintiff_Id = P.Plaintiff_Id
         INNER JOIN tblParty PPA WITH (NOLOCK) ON PPA.PrimaryPartyType = 'ATT' AND PPA.WebValidation = CONVERT(VARCHAR(255),PA.Attorney_Id)
--25,669


--CIVIL CASES - DEFENDANTS

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
        ,PD.PartyID AS PartyID
        ,'DEF' AS CasePartyType
        ,'' AS CasePartySubType
        ,ROW_NUMBER() OVER(PARTITION BY D.Civil_Case_Id ORDER BY D.Defendant_Id) AS PartySequence
        ,0 AS ParentCasePartyID
        ,C.DispositionCode AS DispositionCode
        ,C.DispositionDate AS DispositionDate
        ,NULL AS DeactivateDate
        ,C.DispositionJudgeID AS DispositionJudgeID
        ,C.JudgmentAmount AS JudgementAmount
        ,NULL AS ForeclosureSaleDate
        ,0 AS ForeclosureSaleAmount
        ,NULL AS TitleIssueDate
        ,0 AS DocStamps
        ,C.CaseOpenDate AS ClaimDate
        ,C.ClaimAmount AS ClaimAmount
        ,0 AS ClaimObjected
        ,'' AS ClaimType
        ,CC.Answer_Date AS AnswerDate
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
        ,D.Defendant_Id AS OriginalPartyID
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
    FROM test_source.dbo.Civil_Cases CC WITH (NOLOCK)
         INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseID = CC.Civil_Case_Id
         INNER JOIN test_source.dbo.Defendants D WITH (NOLOCK) ON D.Civil_Case_Id = CC.Civil_Case_Id
         INNER JOIN tblParty PD WITH (NOLOCK) ON PD.FamilyCode = 'PUBLIC' AND PD.WebValidation = CONVERT(VARCHAR(255),D.Defendant_SSN)
--102,884


--CIVIL CASES - DEFENDANT ATTORNEYS

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
        ,PDA.PartyID AS PartyID
        ,'ATT' AS CasePartyType
        ,'' AS CasePartySubType
        ,ROW_NUMBER() OVER(PARTITION BY DA.Defendant_Id ORDER BY DA.Main_Attorney DESC, DA.Attorney_Id) AS PartySequence
        ,CPD.CasePartyID AS ParentCasePartyID
        ,C.DispositionCode AS DispositionCode
        ,C.DispositionDate AS DispositionDate
        ,NULL AS DeactivateDate
        ,C.DispositionJudgeID AS DispositionJudgeID
        ,C.JudgmentAmount AS JudgementAmount
        ,NULL AS ForeclosureSaleDate
        ,0 AS ForeclosureSaleAmount
        ,NULL AS TitleIssueDate
        ,0 AS DocStamps
        ,C.CaseOpenDate AS ClaimDate
        ,C.ClaimAmount AS ClaimAmount
        ,0 AS ClaimObjected
        ,'' AS ClaimType
        ,CC.Answer_Date AS AnswerDate
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
        ,DA.Attorney_Id AS OriginalPartyID
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
        ,PDA.Name AS MotherMaidenName
        ,0 AS MinorChildren
        ,0 AS DisplayPartyNameID
    FROM test_source.dbo.Civil_Cases CC WITH (NOLOCK)
         INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseID = CC.Civil_Case_Id
         INNER JOIN test_source.dbo.Defendants D WITH (NOLOCK) ON D.Civil_Case_Id = CC.Civil_Case_Id
         INNER JOIN tblParty PD WITH (NOLOCK) ON PD.FamilyCode = 'PUBLIC' AND PD.WebValidation = CONVERT(VARCHAR(255),D.Defendant_SSN)
         INNER JOIN tblCaseParty CPD WITH (NOLOCK) ON CPD.CaseID = C.CaseID AND CPD.PartyID = PD.PartyID
         INNER JOIN test_source.dbo.Defendant_Attorneys DA WITH (NOLOCK) ON DA.Defendant_Id = D.Defendant_Id
         INNER JOIN tblParty PDA WITH (NOLOCK) ON PDA.PrimaryPartyType = 'ATT' AND PDA.WebValidation = CONVERT(VARCHAR(255),DA.Attorney_Id)
--2,410


--CIVIL CASES - JUDGES

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
        ,PJ.PartyID AS PartyID
        ,'JDG' AS CasePartyType
        ,'' AS CasePartySubType
        ,1 AS PartySequence
        ,0 AS ParentCasePartyID
        ,C.DispositionCode AS DispositionCode
        ,C.DispositionDate AS DispositionDate
        ,NULL AS DeactivateDate
        ,C.DispositionJudgeID AS DispositionJudgeID
        ,C.JudgmentAmount AS JudgementAmount
        ,NULL AS ForeclosureSaleDate
        ,0 AS ForeclosureSaleAmount
        ,NULL AS TitleIssueDate
        ,0 AS DocStamps
        ,C.CaseOpenDate AS ClaimDate
        ,C.ClaimAmount AS ClaimAmount
        ,0 AS ClaimObjected
        ,'' AS ClaimType
        ,CC.Answer_Date AS AnswerDate
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
        ,CC.Termination_Judge_Id AS OriginalPartyID
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
        ,'' AS Passport_NIS_Number
        ,'' AS Occupation
        ,SUBSTRING(C.CaseNumber,5,2) AS FatherName
        ,PJ.Name AS MotherMaidenName
        ,0 AS MinorChildren
        ,0 AS DisplayPartyNameID
    FROM test_source.dbo.Civil_Cases CC WITH (NOLOCK)
         INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseID = CC.Civil_Case_Id
         INNER JOIN tblParty PJ WITH (NOLOCK) ON PJ.PrimaryPartyType = 'JDG' AND PJ.WebValidation = CONVERT(VARCHAR(255),CC.Termination_Judge_Id)
--22,694


--CIVIL CASES - WITNESSES

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
        ,PW.PartyID AS PartyID
        ,'WIT' AS CasePartyType
        ,'' AS CasePartySubType
        ,1 AS PartySequence
        ,0 AS ParentCasePartyID
        ,C.DispositionCode AS DispositionCode
        ,C.DispositionDate AS DispositionDate
        ,NULL AS DeactivateDate
        ,C.DispositionJudgeID AS DispositionJudgeID
        ,C.JudgmentAmount AS JudgementAmount
        ,NULL AS ForeclosureSaleDate
        ,0 AS ForeclosureSaleAmount
        ,NULL AS TitleIssueDate
        ,0 AS DocStamps
        ,C.CaseOpenDate AS ClaimDate
        ,C.ClaimAmount AS ClaimAmount
        ,0 AS ClaimObjected
        ,'' AS ClaimType
        ,CC.Answer_Date AS AnswerDate
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
        ,W.Witness_Id AS OriginalPartyID
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
        ,'' AS Passport_NIS_Number
        ,'' AS Occupation
        ,SUBSTRING(C.CaseNumber,5,2) AS FatherName
        ,PW.Name AS MotherMaidenName
        ,0 AS MinorChildren
        ,0 AS DisplayPartyNameID
    FROM test_source.dbo.Civil_Cases CC WITH (NOLOCK)
         INNER JOIN tblCase C WITH (NOLOCK) ON C.CaseID = CC.Civil_Case_Id
         INNER JOIN test_source.dbo.Witness W WITH (NOLOCK) ON W.Case_Number = CC.Case_Number
         INNER JOIN tblParty PW WITH (NOLOCK) ON PW.FamilyCode = 'WIT' AND PW.WebValidation = CONVERT(VARCHAR(255),W.Witness_Id)
--1
