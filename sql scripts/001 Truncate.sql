
EXEC DropConstraints 'tblCase,tblCaseParty,tblCasePartyAddress,tblCasePartyAttribute,tblCasePartyAlert,tblCaseNote,tblCaseDocket,tblEvent,tblCaseEvent,tblCaseProcessAction,tblDocument,tblCaseTask,tblTaskType,tblCaseNote'

TRUNCATE TABLE tblCase
TRUNCATE TABLE tblCaseParty
TRUNCATE TABLE tblCasePartyAddress
TRUNCATE TABLE tblCasePartyAttribute
TRUNCATE TABLE tblCasePartyAlert
TRUNCATE TABLE tblCaseNote
TRUNCATE TABLE tblCaseDocket
TRUNCATE TABLE tblEvent
TRUNCATE TABLE tblCaseEvent
TRUNCATE TABLE tblCaseProcessAction
TRUNCATE TABLE tblDocument
TRUNCATE TABLE tblCaseTask
TRUNCATE TABLE tblTaskType
TRUNCATE TABLE tblCaseNote

EXEC READD
