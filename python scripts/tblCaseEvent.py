from Connection import connect_to_db

def tblCaseEvent():
    # Establishing the connection
    conn = connect_to_db()
    cursor = conn.cursor()

    sql_query = """
    --INSERT INTO tblEventType
    --            (EventTypeCode
    --            ,EventTypeDescription
    --            ,EventTypeKey
    --            ,DefaultEventCountMax
    --            ,Active
    --            ,HideFromWeb
    --            ,CourtDocketListKey
    --            ,CourtDocketReportKey
    --            ,CCISEventTypeCode
    --            ,EventDateRangeRequirement
    --            ,ScheduleBeforeRequirement
    --            ,CreateByUserID
    --            ,CreateDate
    --            ,ModifyByUserID
    --            ,ModifyDate
    --            ,DefaultDirectBooking
    --            ,DefaultDisallowAttorneySchedule)
    --  SELECT -- EventTypeID
    --         LTRIM(RTRIM(H.Hearing)) AS EventTypeCode
    --        ,LTRIM(RTRIM(H.Hearing)) AS EventTypeDescription
    --        ,CONVERT(VARCHAR(50),H.Hearing_Id) AS EventTypeKey
    --        ,0 AS DefaultEventCountMax
    --        ,1 AS Active
    --        ,0 AS HideFromWeb
    --        ,'' AS CourtDocketListKey
    --        ,'' AS CourtDocketReportKey
    --        ,'' AS CCISEventTypeCode
    --        ,0 AS EventDateRangeRequirement
    --        ,0 AS ScheduleBeforeRequirement
    --        ,1 AS CreateByUserID
    --        ,CURRENT_TIMESTAMP AS CreateDate
    --        ,1 AS ModifyByUserID
    --        ,CURRENT_TIMESTAMP AS ModifyDate
    --        ,0 AS DefaultDirectBooking
    --        ,0 AS DefaultDisallowAttorneySchedule
    --    FROM test_source.dbo.Hearings H WITH (NOLOCK)
    --         LEFT OUTER JOIN tblEventType ET WITH (NOLOCK) ON ET.EventTypeCode = LTRIM(RTRIM(H.Hearing))
    --   WHERE ET.EventTypeCode IS NULL
    --ORDER BY H.Hearing_Id
    ----1

    SET IDENTITY_INSERT tblEvent ON

    INSERT INTO tblEvent
                (EventID
                ,StartDateTime
                ,EndDateTime
                ,EventTypeID
                ,EventCountMax
                ,EventCountScheduled
                ,DefendantCountScheduled
                ,JudgeID
                ,CourtRoomCode
                ,PrimaryClerkID
                ,SecondaryClerkID
                ,SAOAttorneyPartyID
                ,PublicDefenderPartyID
                ,Active
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,Arraignment
                ,Closed
                ,DirectBooking
                ,TimedBlock
                ,DisallowAttorneySchedule)
    SELECT CS.Case_Schedule_ID AS EventID
            ,CS.Date_From AS StartDateTime
            ,CS.Date_To AS EndDateTime
            ,ET.EventTypeID AS EventTypeID
            ,0 AS EventCountMax
            ,0 AS EventCountScheduled
            ,0 AS DefendantCountScheduled
            ,ISNULL(PJ.PartyID,0) AS JudgeID
            ,LEFT(ISNULL('C' + CONVERT(VARCHAR(10),Court_Room_Id),''),50) AS CourtRoomCode
            ,0 AS PrimaryClerkID
            ,0 AS SecondaryClerkID
            ,0 AS SAOAttorneyPartyID
            ,0 AS PublicDefenderPartyID
            ,CASE WHEN CONVERT(DATE,FORMAT(CS.Date_To,'yyyyMMdd')) >= CONVERT(DATE,FORMAT(CURRENT_TIMESTAMP,'yyyyMMdd')) THEN 1 ELSE 0 END AS Active
            ,XP.PartyID AS CreateByUserID
            ,CS.Date_From AS CreateDate
            ,XP.PartyID AS ModifyByUserID
            ,CS.Date_From AS ModifyDate
            ,CASE WHEN ET.EventTypeDescription LIKE '%ARRAIGNMENT%' THEN 1 ELSE 0 END AS Arraignment
            ,CASE WHEN CONVERT(DATE,FORMAT(CS.Date_To,'yyyyMMdd')) <= CONVERT(DATE,FORMAT(CURRENT_TIMESTAMP,'yyyyMMdd')) THEN 1 ELSE 0 END AS Closed
            ,0 AS DirectBooking
            ,0 AS TimedBlock
            ,0 AS DisallowAttorneySchedule
        FROM test_source.dbo.Case_Schedules CS WITH (NOLOCK)
            LEFT OUTER JOIN tblEventType ET WITH (NOLOCK) ON ET.EventTypeKey = CONVERT(VARCHAR(50),CS.Hearing_Id)
            LEFT OUTER JOIN tblParty PJ WITH (NOLOCK) ON PJ.PrimaryPartyType = 'JDG' AND PJ.WebValidation = CONVERT(VARCHAR(255),CS.Judge_Id)
            LEFT OUTER JOIN XREF_tblParty_UserID XP WITH (NOLOCK) ON XP.UserID = CONVERT(VARCHAR(50),CS.User_Id)
    ORDER BY CS.Case_Schedule_Id

    SET IDENTITY_INSERT tblEvent OFF
    --382,941


    --SET IDENTITY_INSERT tblCaseEvent ON

    INSERT INTO tblCaseEvent
                (--CaseEventID
                CaseID
                ,EventID
                ,CaseEventTypeID
                ,CaseStartDateTime
                ,ActualStartDateTime
                ,Present
                ,DefAttyPresent
                ,PltfAttyPresent
                ,CourtResult
                ,CourtResultDate
                ,Remark
                ,CreateByUserID
                ,CreateDate
                ,ModifyByUserID
                ,ModifyDate
                ,ContinuedToCaseEventID
                ,CourtAppearanceLookupCodes
                ,CourtAppearancePartyIDs
                ,JACSMotionDescription
                ,CancelReason
                ,DefendantPresentDate
                ,DefAttyPresentDate
                ,PltfAttyPresentDate
                ,Routing
                ,AppearanceReason
                ,AppearanceDuration)
    SELECT --CS.Case_Schedule_ID AS CaseEventID
            COALESCE(C.CaseID,CCV.CaseID,0) AS CaseID
            ,E.EventID AS EventID
            ,E.EventTypeID AS CaseEventTypeID
            ,E.StartDateTime AS CaseStartDateTime
            ,E.StartDateTime AS ActualStartDateTime
            ,0 AS Present
            ,0 AS DefAttyPresent
            ,0 AS PltfAttyPresent
            ,'' AS CourtResult
            ,NULL AS CourtResultDate
            ,'' AS Remark
            ,E.CreateByUserID AS CreateByUserID
            ,E.CreateDate AS CreateDate
            ,E.ModifyByUserID AS ModifyByUserID
            ,E.ModifyDate AS ModifyDate
            ,0 AS ContinuedToCaseEventID
            ,'' AS CourtAppearanceLookupCodes
            ,'' AS CourtAppearancePartyIDs
            ,'' AS JACSMotionDescription
            ,'' AS CancelReason
            ,NULL AS DefendantPresentDate
            ,NULL AS DefAttyPresentDate
            ,NULL AS PltfAttyPresentDate
            ,'' AS Routing
            ,'' AS AppearanceReason
            ,CONVERT(VARCHAR(50),DATEDIFF(MINUTE,Date_From,Date_To)) AS AppearanceDuration
        FROM test_source.dbo.Case_Schedules CS WITH (NOLOCK)
            INNER JOIN tblEvent E WITH (NOLOCK) ON E.EventID = CS.Case_Schedule_ID
            LEFT OUTER JOIN tblCase C WITH (NOLOCK) ON C.CaseNumber = CS.Case_Id
            LEFT OUTER JOIN test_source.dbo.Case_Violations CV WITH (NOLOCK) ON CV.Case_Violation_Id = CS.Case_Id
            LEFT OUTER JOIN tblCase CCV WITH (NOLOCK) ON CCV.CaseNumber = CV.Case_Number
    --       LEFT OUTER JOIN test_source.dbo.Scheduled_Attorneys SA WITH (NOLOCK) ON SA.Case_Schedule_Id = CS.Case_Schedule_Id
    --       LEFT OUTER JOIN tblParty PA WITH (NOLOCK) ON PA.PrimaryPartyType = 'ATT' AND PA.WebValidation = CONVERT(VARCHAR(255),SA.Attorney_Id)
    ORDER BY CS.Case_Schedule_Id

    --SET IDENTITY_INSERT tblCaseEvent OFF
    --382,941  (26 sec)  (217,419 MATCH tblCase.CaseNumber, 165,378 MATCH Case_Violations.Case_Violation_Id, 144 CANNOT MATCH Case_Schedules.Case_Id)
    """

    #Executing the query
    cursor.execute(sql_query)
    conn.commit()

    #Closing the connection
    cursor.close()
    conn.close()
