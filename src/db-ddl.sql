# United States Mass Shooting Database (Group 15)
# Authors - Alex Lutterloah & Henry Bryant
# Creating tables for database: 23FA_groups_group15

# Section 1 - Drops all tables ---------------------------------------

DROP TABLE IF EXISTS incident;
DROP TABLE IF EXISTS victim;
DROP TABLE IF EXISTS perpetrator;
DROP TABLE IF EXISTS weapon;
DROP TABLE IF EXISTS incident_victim;
DROP TABLE IF EXISTS incident_perpetrator;



# Section 2 - Create incident table ------------------------------------
# Create incident (int incident_id, date DATE, VARCHAR(255) city, VARCHAR(255) state_code, VARCHAR(255) description, VARCHAR(255) motive)
# incident_id, date, city, state_code, and description cannot be NULL.
# motive can be NULL.
# incident_id is the PRIMARY KEY.

CREATE TABLE incident (
    incident_id INT NOT NULL AUTO_INCREMENT,
    date DATE NOT NULL,
    city VARCHAR(255) NOT NULL,
    state_code VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    motive VARCHAR(255),
    PRIMARY KEY (incident_id)
);

ALTER TABLE incident
ADD CONSTRAINT check_state_code
CHECK (state_code IN ('AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'));

INSERT INTO incident (date, city, state_code, description, motive) VALUES
('2023-01-01', 'CityA', 'CA', 'Robbery', 'need car'),
('2023-02-15', 'CityB', 'NY', 'Assault', 'domestic abuse'),
('2023-03-22', 'CityC', 'TX', 'Burglary', 'need money'),
('2023-04-10', 'CityD', 'FL', 'Kidnapping', 'psychotic'),
('2023-05-05', 'CityE', 'IL', 'Homicide', 'retaliation');



# Section 3 - Create victim table -------------------------------------
# Create victim (INT victim_id, VARCHAR(255) name, INT age, VARCHAR(255) sex, VARCHAR(255) status)
# victim_id, name, age, sex, status cannot be NULL.

CREATE TABLE victim (
    victim_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    sex VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    PRIMARY KEY (victim_id)
);

ALTER TABLE victim
ADD CONSTRAINT check_victim_sex CHECK (sex IN ('Male', 'Female')),
ADD CONSTRAINT check_status CHECK (status IN ('Injured', 'Deceased', 'Survivor'));

INSERT INTO victim (name, age, sex, status) VALUES
('John Doe', 30, 'Male', 'Injured'),
('Jane Smith', 25, 'Female', 'Deceased'),
('Sam Johnson', 40, 'Male', 'Survivor'),
('Emily White', 22, 'Female', 'Injured'),
('Mark Brown', 35, 'Male', 'Deceased');



# Section 4 - Create perpetrator table --------------------------------
# Create perpetrator (int perpetrator_id , VARCHAR(255) name, int age, VARCHAR(255) sex, VARCHAR(255) criminal_bg_description)
# perpetrator_id, name, age, sex, criminal_bg_description cannot be NULL.
# perpetrator_id is PK.

CREATE TABLE perpetrator (
    perpetrator_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    sex VARCHAR(255) NOT NULL,
    criminal_bg_description VARCHAR(255) NOT NULL,
    PRIMARY KEY (perpetrator_id)
);

ALTER TABLE perpetrator
ADD CONSTRAINT check_perpetrator_sex CHECK (sex IN ('Male', 'Female'));

INSERT INTO perpetrator (name, age, sex, criminal_bg_description) VALUES
('Tom Jones', 28, 'Male', 'Previous convictions for theft'),
('Sara Miller', 35, 'Female', 'No criminal record'),
('Mike Davis', 40, 'Male', 'Convicted for assault'),
('Laura Turner', 30, 'Female', 'Previously arrested for robbery'),
('Chris Harris', 22, 'Male', 'No criminal record');



# Section 5 - Create weapon table -------------------------------------
# Create weapon (INT perpetrator_id, INT weapon_id, VARCHAR(255) type, VARCHAR(255) description)
# perpetrator_id, weapon_id cannot be NULL.
# perpetrator_id, weapon_id are PKs.

CREATE TABLE weapon (
    perpetrator_id INT NOT NULL,
    weapon_id INT NOT NULL,
    type VARCHAR(255),
    description VARCHAR(255),
    PRIMARY KEY (perpetrator_id, weapon_id)
);

ALTER TABLE weapon
ADD CONSTRAINT check_type CHECK (type IN ('Rifle', 'Handgun', 'Shotgun', 'Explosive', 'Melee', 'Other'));

# Insert data into the weapon table
INSERT INTO weapon (perpetrator_id, weapon_id, type, description) VALUES
(1, 1, 'Explosive', 'C4 charge'),
(2, 1, 'Handgun', 'Glock 17'),
(3, 1, 'Shotgun', 'Remington 1187'),
(4, 1, 'Melee', 'Knife'),
(5, 1, 'Melee', 'Hammer'),
(5, 2, 'Other', 'Shoelace');



# Section 6 - Create incident_victim table ----------------------------
# Create incident_victim (INT incident_id, INT victim_id)
# incident_id, victim_id cannot be NULL.
# incident_id, victim_id are PKs.

CREATE TABLE incident_victim (
    incident_id INT NOT NULL,
    victim_id INT NOT NULL,
    PRIMARY KEY (incident_id, victim_id)
);

# Insert data into the incident_victim table
INSERT INTO incident_victim (incident_id, victim_id) VALUES
(1, 1), # John Doe was a victim in the robbery
(2, 2), # Jane Smith was a victim in the assault
(3, 3), # Sam Johnson was a victim in the burglary
(4, 4), # Emily White was a victim in the kidnapping
(5, 5); # Mark Brown was a victim in the homicide



# Section 7 - Create incident_perpetrator table -----------------------
# Create incident_perpetrator (INT incident_id, INT perpetrator_id)
# incident_id, perpetrator_id cannot be NULL.
# incident_id, perpetrator_id are PKs.

CREATE TABLE incident_perpetrator (
    incident_id INT NOT NULL,
    perpetrator_id INT NOT NULL,
    PRIMARY KEY (incident_id, perpetrator_id)
);

# Insert data into the incident_perpetrator table
INSERT INTO incident_perpetrator (incident_id, perpetrator_id) VALUES
(1, 1), # Tom Jones was a perpetrator in the robbery
(2, 2), # Sara Miller was a perpetrator in the assault
(3, 3), # Mike Davis was a perpetrator in the burglary
(4, 4), # Laura Turner was a perpetrator in the kidnapping
(5, 5); # Chris Harris was a perpetrator in the homicide