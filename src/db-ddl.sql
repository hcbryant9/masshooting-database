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
('2023-01-15', 'Springfield', 'IL', 'Supermarket shooting', 'Robbery'),
('2023-02-28', 'Phoenix', 'AZ', 'School shooting', 'Unknown'),
('2023-03-10', 'Dallas', 'TX', 'Office building attack', 'Disgruntled employee'),
('2023-04-05', 'Miami', 'FL', 'Nightclub shooting', NULL),
('2023-05-20', 'Denver', 'CO', 'Park incident', 'Domestic dispute'),
('2023-06-12', 'Seattle', 'WA', 'Community center shooting', 'Terrorism'),
('2023-07-04', 'Orlando', 'FL', 'Concert shooting', NULL),
('2023-08-18', 'Atlanta', 'GA', 'Bank robbery gone wrong', 'Financial desperation'),
('2023-09-22', 'Chicago', 'IL', 'Street altercation', 'Gang-related'),
('2023-10-30', 'Los Angeles', 'CA', 'Movie theater incident', 'Mental health crisis'),
('2023-11-12', 'Houston', 'TX', 'Shopping mall shooting', 'Personal conflict'),
('2023-12-25', 'New York City', 'NY', 'Bank hostage situation', 'Robbery'),
('2024-01-05', 'San Francisco', 'CA', 'Tech company office attack', 'Work-related dispute'),
('2024-02-20', 'Las Vegas', 'NV', 'Casino altercation', NULL),
('2024-03-08', 'Portland', 'OR', 'Protest violence', 'Political tension'),
('2023-11-11', 'Houston', 'TX', 'Shopping mall shooting', 'Robbery'),
('2023-12-25', 'New York City', 'NY', 'Holiday parade incident', 'Terrorism'),
('2024-04-18', 'Boston', 'MA', 'Bank robbery', 'Financial desperation'),
('2024-05-30', 'San Antonio', 'TX', 'Bar shooting', 'Gang-related'),
('2024-06-22', 'Philadelphia', 'PA', 'University campus incident', 'Student dispute');

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
('John Doe', 35, 'Male', 'Deceased'),
('Jane Smith', 25, 'Female', 'Injured'),
('Michael Johnson', 40, 'Male', 'Survivor'),
('Emily Brown', 30, 'Female', 'Injured'),
('Robert Davis', 22, 'Male', 'Deceased'),
('Sophia Wilson', 28, 'Female', 'Injured'),
('William Garcia', 19, 'Male', 'Injured'),
('Olivia Clark', 33, 'Female', 'Deceased'),
('Daniel Lee', 45, 'Male', 'Survivor'),
('Ella Adams', 27, 'Female', 'Injured'),
('Liam Miller', 31, 'Male', 'Deceased'),
('Ava Thompson', 29, 'Female', 'Injured'),
('Noah Hernandez', 24, 'Male', 'Survivor'),
('Isabella Wright', 26, 'Female', 'Injured'),
('Mason Martinez', 21, 'Male', 'Injured'),
('Grace Wilson', 40, 'Female', 'Deceased'),
('Luke Johnson', 24, 'Male', 'Injured'),
('Avery Carter', 31, 'Female', 'Survivor'),
('Nathan Brown', 27, 'Male', 'Injured'),
('Samantha Evans', 22, 'Female', 'Deceased'),
('Zoe Perez', 19, 'Female', 'Injured'),
('Ethan Rivera', 36, 'Male', 'Survivor'),
('Madison Hall', 26, 'Female', 'Injured'),
('Landon Cooper', 29, 'Male', 'Deceased'),
('Victoria Reed', 33, 'Female', 'Injured'),
('Gabriel Morris', 25, 'Male', 'Survivor'),
('Chloe Stewart', 23, 'Female', 'Injured'),
('Owen Bennett', 28, 'Male', 'Deceased'),
('Hailey Murphy', 30, 'Female', 'Injured'),
('Tristan Gray', 32, 'Male', 'Survivor'),
('Lilly Turner', 21, 'Female', 'Injured'),
('Logan Wright', 35, 'Male', 'Deceased'),
('Penelope Scott', 20, 'Female', 'Injured'),
('Xavier Hill', 37, 'Male', 'Survivor'),
('Harper Hughes', 34, 'Female', 'Injured'),
('Evelyn Rodriguez', 29, 'Female', 'Survivor'),
('Hudson Brooks', 33, 'Male', 'Deceased'),
('Nora Price', 26, 'Female', 'Injured'),
('Asher Foster', 35, 'Male', 'Survivor'),
('Clara Wood', 30, 'Female', 'Deceased'),
('Gavin Peterson', 28, 'Male', 'Injured'),
('Luna Flores', 24, 'Female', 'Survivor'),
('Mateo Simmons', 31, 'Male', 'Deceased'),
('Violet Collins', 27, 'Female', 'Injured'),
('Zachary Barnes', 32, 'Male', 'Survivor'),
('Aubrey Cook', 25, 'Female', 'Deceased'),
('Eli Nelson', 29, 'Male', 'Injured'),
('Harmony Butler', 23, 'Female', 'Survivor'),
('Oscar Ross', 34, 'Male', 'Deceased'),
('Sienna Hayes', 28, 'Female', 'Injured'),
('Xander Coleman', 30, 'Male', 'Survivor'),
('Aria Henderson', 26, 'Female', 'Deceased'),
('Jasper Powell', 27, 'Male', 'Injured'),
('Sophie Watson', 22, 'Female', 'Survivor'),
('Theodore Rivera', 33, 'Male', 'Deceased'),
('Bella Foster', 25, 'Female', 'Injured'),
('Caleb Long', 29, 'Male', 'Survivor'),
('Daisy Simmons', 24, 'Female', 'Deceased'),
('Emmett Parker', 30, 'Male', 'Injured'),
('Fiona Mitchell', 26, 'Female', 'Survivor'),
('Graham Carter', 32, 'Male', 'Deceased'),
('Hazel James', 27, 'Female', 'Injured'),
('Ian Wood', 31, 'Male', 'Survivor'),
('Jade Rodriguez', 28, 'Female', 'Deceased'),
('Kai Hayes', 26, 'Male', 'Injured'),
('Lily White', 23, 'Female', 'Survivor'),
('Milo Turner', 34, 'Male', 'Deceased'),
('Natalie Carter', 29, 'Female', 'Injured'),
('Oliver Scott', 30, 'Male', 'Survivor'),
('Piper Mitchell', 25, 'Female', 'Deceased'),
('Mia Wright', 26, 'Female', 'Injured'),
('Aiden Brooks', 30, 'Male', 'Deceased'),
('Zoe Campbell', 27, 'Female', 'Survivor'),
('Jackson Bennett', 25, 'Male', 'Injured'),
('Hannah Carter', 29, 'Female', 'Injured'),
('Lucas Rodriguez', 31, 'Male', 'Deceased'),
('Sofia Reed', 28, 'Female', 'Survivor'),
('Carter Turner', 24, 'Male', 'Injured'),
('Natalie King', 33, 'Female', 'Deceased'),
('Elijah Cooper', 26, 'Male', 'Injured'),
('Scarlett Hughes', 35, 'Female', 'Survivor'),
('Grayson Parker', 23, 'Male', 'Injured'),
('Vivian Foster', 30, 'Female', 'Deceased'),
('Mason Richardson', 27, 'Male', 'Survivor'),
('Alice Adams', 32, 'Female', 'Injured'),
('Leo Hill', 22, 'Male', 'Deceased'),
('Clara Morgan', 28, 'Female', 'Survivor'),
('Eliana Stewart', 34, 'Female', 'Injured'),
('Wyatt Barnes', 25, 'Male', 'Deceased'),
('Luna Peterson', 29, 'Female', 'Survivor'),
('Quinn Harris', 27, 'Male', 'Injured'),
('Rose Parker', 22, 'Female', 'Survivor'),
('Sawyer Nelson', 33, 'Male', 'Deceased'),
('Tessa Wright', 28, 'Female', 'Injured'),
('Uriah Brooks', 31, 'Male', 'Survivor'),
('Valerie Adams', 24, 'Female', 'Deceased');
    

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
('Mark Thompson', 28, 'Male', 'Previous assault charges'),
('Sarah Johnson', 35, 'Female', 'No previous record'),
('David White', 40, 'Male', 'Convicted for robbery'),
('Emma Baker', 22, 'Female', 'History of mental illness'),
('Christopher Hill', 30, 'Male', 'Suspected ties to organized crime'),
('Sophie Roberts', 33, 'Female', 'Arrested for vandalism'),
('James Green', 27, 'Male', 'Prior drug-related offenses'),
('Rachel Adams', 25, 'Female', 'Convicted for fraud'),
('Brandon Scott', 36, 'Male', 'History of domestic violence'),
('Megan Harris', 31, 'Female', 'Previously charged with theft'),
('Sophia Turner', 26, 'Female', 'Suspected involvement in illegal gambling'),
('Jack Nelson', 38, 'Male', 'Previous charges related to white-collar crime'),
('Aiden Garcia', 29, 'Male', 'History of assault charges'),
('Aria Perez', 24, 'Female', 'Previously arrested for vandalism'),
('William Miller', 31, 'Male', 'Convicted for drug trafficking'),
('Lila Martinez', 26, 'Female', 'Prior convictions for assault'),
('Maxwell Cooper', 38, 'Male', 'History of theft and burglary'),
('Sophia Miller', 24, 'Female', 'Previous assault charges'),
('Ethan Turner', 32, 'Male', 'Arrested for theft'),
('Olivia Harris', 28, 'Female', 'Convicted for drug possession');

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
(1, 1, 'Handgun', '9mm semi-automatic pistol'),
(2, 2, 'Rifle', 'AR-15'),
(3, 3, 'Shotgun', '12-gauge pump-action'),
(4, 4, 'Other', 'Improvised explosive device (IED)'),
(5, 5, 'Handgun', 'Glock 19'),
(6, 6, 'Rifle', 'AK-47'),
(7, 7, 'Rifle', 'M4'),
(8, 8, 'Handgun', 'Smith & Wesson M&P 9mm'),
(9, 9, 'Shotgun', 'Mossberg 500 Tactical'),
(10, 10, 'Rifle', 'Remington 700 Sniper Rifle'),
(11, 11, 'Handgun', 'Beretta 92FS'),
(12, 12, 'Rifle', 'Winchester Model 70'),
(13, 13, 'Shotgun', 'Benelli M4 Tactical'),
(14, 14, 'Melee', 'Baseball bat'),
(15, 15, 'Handgun', 'Sig Sauer P320'),
(16, 16, 'Handgun', 'Sig Sauer P226'),
(17, 17, 'Rifle', 'Winchester Model 70'),
(18, 18, 'Handgun', 'Walther PPK'),
(19, 19, 'Shotgun', 'Remington 870'),
(20, 20, 'Rifle', 'Bolt-action hunting rifle');

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
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(3, 9),
(4, 10),
(5, 11),
(6, 12),
(6, 13),
(6, 14),
(6, 15),
(7, 16),
(7, 17),
(8, 18),
(8, 19),
(9, 20),
(9, 21),
(9, 22),
(10, 23),
(10, 24),
(10, 25),
(10, 26),
(10, 27),
(11, 28),
(11, 29),
(11, 30),
(11, 31),
(11, 32),
(12, 33),
(12, 34),
(12, 35),
(12, 36),
(12, 37),
(12, 38),
(13, 39),
(13, 40),
(13, 41),
(13, 42),
(13, 43),
(13, 44),
(13, 45),
(14, 46),
(14, 47),
(14, 48),
(14, 49),
(14, 50),
(14, 51),
(14, 52),
(14, 53),
(14, 54),
(14, 55),
(15, 57),
(14, 58),
(14, 59),
(14, 60),
(14, 61),
(14, 62),
(14, 63),
(14, 64),
(14, 65),
(15, 66),
(15, 67),
(16, 69),
(16, 70),
(16, 71),
(17, 72),
(17, 73),
(17, 74),
(17, 75),
(17, 76),
(18, 77),
(18, 78),
(18, 79),
(18, 80),
(18, 81),
(18, 82),
(18, 83),
(19, 84),
(19, 85),
(19, 86),
(19, 87),
(19, 88),
(20, 89),
(20, 90),
(20, 91),
(20, 92),
(20, 93),
(20, 94),
(20, 95),
(20, 96);



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
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20);