import pyodbc

def connect_to_db():
    """Establish connection to SQL Server database"""
    server = 'DESKTOP-TVGKBDE'
    database = 'Python_Target'

    
    connection_string = f'DRIVER={{ODBC Driver 18 for SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;TrustServerCertificate=yes'
    
    return pyodbc.connect(connection_string)