from flask import Flask
from flask_sqlalchemy import sqlalchemy
from sqlalchemy import *
import os 
from  dotenv import load_dotenv

project_folder = os.path.expanduser('/home/ubuntu/app')
load_dotenv(os.path.join(project_folder, '.env'))

app = Flask(__name__)
app.testing = True
print (os.environ)
SQLALCHEMY_DATABASE_URI = os.environ.get('SQLALCHEMY_DATABASE_URI')
print (SQLALCHEMY_DATABASE_URI)
engine = sqlalchemy.create_engine(SQLALCHEMY_DATABASE_URI)

@app.route('/')
def hello():
        metadata = MetaData()
       # Declare a table
        table = Table('Employee',metadata, Column('EmployeeId', Integer), Column('EmployeeName', String(16)), schema="Employees")
        # Create all tables
        metadata.create_all(engine)
        inspector = inspect(engine)
        return str(inspector.get_columns('Employee'))


if __name__ == '__main__':
        app.run(port=80, host='0.0.0.0')
