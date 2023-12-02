#db-sql.sql

# Code specifications.

# 1. Table names must MATCH EXACTLY to schemas provided.
# 2. Define primary keys in each table as appropriate.
# 3. Define foreign keys connecting tables as appropriate.
# 4. Data types: ONLY use "int", "varchar(255)", "varchar(4096)" or "date" as appropriate.



# Section 1 
# Drops all tables. 

DROP TABLE IF EXISTS INCIDENT

# ...

#Section 2
# Create incident (int incident_id, date date, str city, str state_code, str  description,str motive )
# incident_id, date, city, state_code, and description cannot be null
# motive can be null
# incident_id is the primary key



#Section 3
# Create victim (int victim_id ,str  name, int age, str sex, str status)
# victim_id, name , age, sex, status cannot be null



#Section 4
# Create perpetrator
# int perpetrator_id , string name, int age, str sex, str criminal_bg_description
# perpetrator_id, name, age, sex, criminal_bg_description cannot be null
# perpetrator_id is PK

#Section 5
# Create weapon
# int perpetrator_id, int weapon_id, tr type, str description
# perpetrator_id, weapon_id cannot be null
# perpetrator_id is FK
# weapon_id is PK

#Section 6
# Create incident_victim
# int incident_id , int victim_id
# neither can be null
# incident_id references incident(incident id)
# victim_id references victim(victim_id)
# both are PK 

#Section 7
# Create incident_perpetrator
# int incident_id, int perpetrator_id
# neither can be null
# incident_id references incident(incident id)
# perpetrator_id references perpetrator(perpetrator_id)
# both are PK