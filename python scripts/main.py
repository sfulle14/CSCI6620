import time  

from Truncate import truncate_tables
from tblCase_civil import tblCase_civil
from tblCaseParty_Civil import tblCaseParty_civil
from tblCaseDocket_Civil import tblCaseDocket_civil
from tblCase_TRCR import tblCase_trcr
from tblCaseParty_TRCR import tblCaseParty_trcr
from tblCaseDocket_TRCR import tblCaseDocket_trcr
from tblCaseProcessAction_TRCR import tblCaseProcessAction_trcr
from tblCaseEvent import tblCaseEvent
from tblCaseDocket_Garnishment_Details import tblCaseDocket_Garnishment_Details
from tblCaseNote import tblCaseNote
from tblCaseCompliance import tblCaseCompliance
from tblCaseDocket_Civil_Judgments import tblCaseDocket_civil_Judgments
from tblCaseDocket_Plaintiffs import tblCaseDocket_plaintiffs 
from tblCaseDocket_Defendants import tblCaseDocket_defendants
from tblCaseDocket_Garnishments import tblCaseDocket_garnishments
from tblCaseDocket_Garnishment_Number_Details import tblCaseDocket_Garnishment_Number_Details
from tblCaseDocket_Garnishment_Details import tblCaseDocket_Garnishment_Details
from tblCaseDocket_Garnishment_Detail_Splits import tblCaseDocket_Garnishment_Detail_Splits

if __name__ == "__main__":
    start_time = time.time()  
    truncate_tables()
    tblCase_civil()
    tblCaseParty_civil()
    tblCaseDocket_civil()
    tblCase_trcr()
    tblCaseParty_trcr()
    tblCaseDocket_trcr()
    tblCaseProcessAction_trcr()
    tblCaseEvent()
    tblCaseDocket_Garnishment_Details()
    tblCaseNote()
    tblCaseCompliance()
    tblCaseDocket_civil_Judgments()
    tblCaseDocket_plaintiffs()
    tblCaseDocket_defendants()
    tblCaseDocket_garnishments()
    tblCaseDocket_Garnishment_Number_Details()
    tblCaseDocket_Garnishment_Details()
    tblCaseDocket_Garnishment_Detail_Splits()

    end_time = time.time() 
    execution_time = end_time - start_time  
    print(f"Total execution time: {execution_time:.2f} seconds") 

    print('\a')
