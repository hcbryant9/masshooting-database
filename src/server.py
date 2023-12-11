
import os
import sys
import pandas as pd
from flask import Flask, jsonify, request
from tabulate import tabulate
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.exc import OperationalError, ProgrammingError
from IPython.display import display, Markdown

# Loading DB params .env file
config_map = {
    'user':'CMSC508_USER',
    'password':'CMSC508_PASSWORD',
    'host':'CMSC508_HOST',
    'database':'GROUP15_DB_NAME'
}

# Load and store credentials
load_dotenv()
config = {}
for key in config_map.keys():
    config[key] = os.getenv(config_map[key])
flag = False
for param in config.keys():
    if config[param] is None:
        flag = True
        print(f"Missing {config_map[param]} in .env file")

# Build a sqlalchemy engine string
engine_uri = f"mysql+pymysql://{config['user']}:{config['password']}@{config['host']}/{config['database']}"

# Create a database connection.
try:
    conn = create_engine(engine_uri)
except ArgumentError as e:
    print(f"create_engine: Argument Error: {e}")
except NoSuchModuleError as e:
    print(f"create_engine: No Such Module Error: {e}")
except Exception as e:
    print(f"create_engine: An error occurred: {e}")

def my_sql_statement(statement):
    """ used with DDL, when the statement doesn't return any results. """
    try:
        with conn.begin() as x:
            x.execute(text(statement))
            x.commit()
    #    conn = create_engine(engine_uri)
        result = ""
    except Exception as e:
        result = f"Error: {str(e)}"
#    conn = create_engine(engine_uri)
    return result

# Create a flask web application
app = Flask(__name__)

# Create list of table names for error checking
tableNames = ['incident', 'perpetrator', 'victim', 'weapon']

# Define route
@app.route('/')
def show_all_tables():
    # Create data frame to store query results
    df = pd.read_sql("show tables", conn)

    # Convert to json and return results
    json_data = df.to_json()
    return jsonify(json_data)

# Route to get all records in specified table
@app.route('/<string:tableName>')
def select_table(tableName):
    # Check to make sure the table name exists
    if tableName in tableNames:
        # Create data frame to store query results
        df = pd.read_sql(f"select * from {tableName}", conn)

        # Convert to json and return results
        result = df.to_json()
        return jsonify(result)
    else:
        return jsonify({"error": "Table does not exist"}), 400

# Route to get a specific record for a specified table
@app.route('/<string:tableName>/<int:id>')
def select_record(tableName, id):
    # Check to make sure the table name exists
    if tableName in tableNames:
        # Create data frame to store query results
        df = pd.read_sql(f"select * from {tableName} where {tableName}_id = {id}", conn)

        # Convert to json and return results
        result = df.to_json()
        return jsonify(result)
    else:
        return jsonify({"error": "Table does not exist"}), 400

# Route to get perpetrators of a specified incident
@app.route('/incident/<int:id>/perpetrators')
def get_perpetrators(id):
    query = f"""
    SELECT p.perpetrator_id, p.name, p.age, p.sex, p.criminal_bg_description
    FROM incident i
    JOIN incident_perpetrator ip
    ON ip.incident_id = i.incident_id
    JOIN perpetrator p
    ON p.perpetrator_id = ip.perpetrator_id
    WHERE i.incident_id = {id}
    """
    # Create data frame to store query results
    df = pd.read_sql(query, conn)

    # Convert to json and return results
    result = df.to_json()
    return jsonify(result)

# Route to get victims of a specified incident
@app.route('/incident/<int:id>/victims')
def get_victims(id):
    # Create query string
    query = f"""
    SELECT i.incident_id, v.victim_id, v.name, v.age, v.sex, v.status
    FROM incident i
    JOIN incident_victim iv
    ON iv.incident_id = i.incident_id
    JOIN victim v
    ON v.victim_id = iv.victim_id
    WHERE i.incident_id = {id}
    """
    # Create data frame to store query results
    df = pd.read_sql(query, conn)

    # Convert to json and return results
    result = df.to_json()
    return jsonify(result)

# Route to get weapons used by a specified perpetrator
@app.route('/perpetrator/<int:id>/weapons')
def get_weapons(id):
    # Create query string
    query = f"""
    SELECT w.weapon_id, w.type, w.description
    FROM perpetrator p
    JOIN weapon w
    ON w.perpetrator_id = p.perpetrator_id
    WHERE p.perpetrator_id = {id}
    """
    # Create data frame to store query results
    df = pd.read_sql(query, conn)

    # Convert to json and return results
    result = df.to_json()
    return jsonify(result)

# Route to add an incident to the database
@app.route('/incident/add', methods=['POST'])
def add_record():
    # Get data from post request
    data = request.get_json()
    
    # Error checking
    if not data or 'date' not in data or 'city' not in data or 'state_code' not in data or 'description' not in data or 'motive' not in data:
        return jsonify({'error': 'Invalid JSON format. Ensure all required fields are present: date, city, state_code, description, motive'}), 400
    
    # Extract incident data from the JSON request
    date = data['date']
    city = data['city']
    state_code = data['state_code']
    description = data['description']
    motive = data['motive']

    # Create query string
    query = f"""INSERT INTO incident (date, city, state_code, description, motive) 
    VALUES ('{date}', '{city}', '{state_code}', '{description}', '{motive}')
    """

    # Run the query & return success message
    my_sql_statement(query)
    return jsonify({"message": "Incident Added"}), 201

# Route to update the incident
@app.route('/incident/update/<int:id>', methods=['POST'])
def update_record(id):
    # Get data from post request
    data = request.get_json()
    
    # Error checking
    if not data or 'date' not in data or 'city' not in data or 'state_code' not in data or 'description' not in data or 'motive' not in data:
        return jsonify({'error': 'Invalid JSON format. Ensure all required fields are present: date, city, state_code, description, motive'}), 400
    
    # Extract incident data from the JSON request
    date = data['date']
    city = data['city']
    state_code = data['state_code']
    description = data['description']
    motive = data['motive']

    # Create query string
    query = f"""
    UPDATE incident
    SET date = '{date}', city = '{city}', state_code = '{state_code}', description = '{description}', motive = '{motive}'
    WHERE incident_id = {id}
    """

    # Run the query & return success message
    my_sql_statement(query)
    return jsonify({"message": "Incident Updated"}), 201

# Route to delete a specified record from a specified table
@app.route('/<string:tableName>/remove/<int:id>')
def remove_record(tableName,id):
    # Check to make sure table name exists
    if tableName in tableNames:
        # Run query and return success message
        query = f"DELETE FROM {tableName} WHERE {tableName}_id = {id}"
        my_sql_statement(query)
        return jsonify({"message": "Record Deleted"}), 201
    else:
        return jsonify({"error": "Table does not exist"}), 400

# Run application
if __name__ == '__main__':
    app.run()