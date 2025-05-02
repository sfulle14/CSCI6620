from Connection import connect_to_db

def truncate_tables():
    """Execute the truncate operations"""
    try:
        conn = connect_to_db()
        cursor = conn.cursor()
        
        # First drop constraints
        tables = 'tblCase,tblCaseParty,tblCasePartyAddress,tblCasePartyAttribute,tblCasePartyAlert,tblCaseNote,tblCaseDocket,tblEvent,tblCaseEvent,tblCaseProcessAction,tblDocument,tblCaseTask,tblTaskType,tblCaseNote'
        cursor.execute(f"EXEC DropConstraints '{tables}'")
        
        # List of tables to truncate
        tables_to_truncate = [
            'tblCase',
            'tblCaseParty',
            'tblCasePartyAddress',
            'tblCasePartyAttribute',
            'tblCasePartyAlert',
            'tblCaseNote',
            'tblCaseDocket',
            'tblEvent',
            'tblCaseEvent',
            'tblCaseProcessAction',
            'tblDocument',
            'tblCaseTask',
            'tblTaskType',
            'tblCaseNote'
        ]
        
        # Truncate each table
        for table in tables_to_truncate:
            print(f"Truncating {table}...")
            cursor.execute(f"TRUNCATE TABLE {table}")
        
        # Readd constraints
        cursor.execute("EXEC READD")
        
        # Commit the changes
        conn.commit()
        print("All tables truncated successfully!")
        
    except Exception as e:
        print(f"An error occurred: {str(e)}")
    finally:
        cursor.close()
        conn.close()
