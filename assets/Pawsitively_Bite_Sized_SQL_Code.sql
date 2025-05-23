USE group_pawsitively;
-- droping the tables so the code is able to run multiple times
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS addresses; 
DROP TABLE IF EXISTS customers; 
DROP TABLE IF EXISTS customers_patients; 
DROP TABLE IF EXISTS customers_addresses; 
DROP TABLE IF EXISTS discounts; 
DROP TABLE IF EXISTS doctors; 
DROP TABLE IF EXISTS doctors_addresses; 
DROP TABLE IF EXISTS doctors_offices; 
DROP TABLE IF EXISTS invoices; 
DROP TABLE IF EXISTS invoices_discounts; 
DROP TABLE IF EXISTS invoices_patients; 
DROP TABLE IF EXISTS invoices_procedures; 
DROP TABLE IF EXISTS invoices_vaccinations; 
DROP TABLE IF EXISTS invoices_visits; 
DROP TABLE IF EXISTS meds; 
DROP TABLE IF EXISTS meds_strenghts; 
DROP TABLE IF EXISTS meds_strengths; 
DROP TABLE IF EXISTS offices; 
DROP TABLE IF EXISTS patients; 
DROP TABLE IF EXISTS patient_types; 
DROP TABLE IF EXISTS procedures; 
DROP TABLE IF EXISTS staff; 
DROP TABLE IF EXISTS staff_addresses; 
DROP TABLE IF EXISTS staff_offices; 
DROP TABLE IF EXISTS vaccinations; 
DROP TABLE IF EXISTS vaccines; 
DROP TABLE IF EXISTS visits; 
DROP TABLE IF EXISTS visits_meds; 
DROP TABLE IF EXISTS visits_procedures; 
DROP TABLE IF EXISTS visit_types; 


/*
creating the core tables
*/
CREATE TABLE patients (
    patient_id INT NOT NULL AUTO_INCREMENT,
    patient_name VARCHAR(255) NOT NULL,
    type_id INT NOT NULL,
    patient_dob DATE NOT NULL,
    microchip_number INT,
    alteration BOOLEAN,
    health_issues VARCHAR(255),
    fractious VARCHAR(255),
    PRIMARY KEY (patient_id)
) ENGINE=InnoDB;

CREATE TABLE patient_types (
    type_id INT NOT NULL AUTO_INCREMENT,
    type_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (type_id)
) ENGINE=InnoDB;

CREATE TABLE customers (
    customer_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (customer_id)
) ENGINE=InnoDB;

CREATE TABLE doctors (
    doctor_id INT NOT NULL AUTO_INCREMENT,
    doctor_first_name VARCHAR(255) NOT NULL,
    doctor_last_name VARCHAR(255) NOT NULL,
    vet_license_number VARCHAR(255) NOT NULL,
    dea_license_number VARCHAR(255),
    usda_license_number VARCHAR(255),
    office_id INT NOT NULL,
    PRIMARY KEY (doctor_id)
) ENGINE=InnoDB;

CREATE TABLE staff (
    staff_id INT NOT NULL AUTO_INCREMENT,
    staff_first_name VARCHAR(255) NOT NULL,
    staff_last_name VARCHAR(255) NOT NULL,
    tech_license_number VARCHAR(255),
    PRIMARY KEY (staff_id)
) ENGINE=InnoDB;

CREATE TABLE offices (
    office_id INT NOT NULL AUTO_INCREMENT,
    office_name VARCHAR(255) NOT NULL,
    address_id INT NOT NULL,
    tax_rate FLOAT NOT NULL,
    PRIMARY KEY (office_id)
) ENGINE=InnoDB;

CREATE TABLE addresses (
    address_id INT NOT NULL AUTO_INCREMENT,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    PRIMARY KEY (address_id)
) ENGINE=InnoDB;

CREATE TABLE visits (
    visit_id INT NOT NULL AUTO_INCREMENT,
    visit_type_id INT NOT NULL,
    visit_date DATE NOT NULL,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    vaccination_id INT NOT NULL,
    weight FLOAT NOT NULL,
    dental VARCHAR(255),
    eyes VARCHAR(255),
    notes VARCHAR(255),
    PRIMARY KEY (visit_id)
) ENGINE=InnoDB;

CREATE TABLE visit_types (
    visit_type_id INT NOT NULL AUTO_INCREMENT,
    visit_type_name VARCHAR(255) NOT NULL,
    visit_cost DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (visit_type_id)
) ENGINE=InnoDB;

CREATE TABLE procedures (
    procedure_id INT NOT NULL AUTO_INCREMENT,
    procedure_name VARCHAR(255) NOT NULL,
    procedure_cost DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (procedure_id)
) ENGINE=InnoDB;

CREATE TABLE vaccinations (
    vaccination_id INT NOT NULL AUTO_INCREMENT,
    vaccine_id INT NOT NULL,
    vaccination_date DATE NOT NULL,
    patient_id INT NOT NULL,
    PRIMARY KEY (vaccination_id)
) ENGINE=InnoDB;

CREATE TABLE vaccines (
    vaccine_id INT NOT NULL AUTO_INCREMENT,
    vaccine_name VARCHAR(255) NOT NULL,
    vaccine_cost DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (vaccine_id)
) ENGINE=InnoDB;

CREATE TABLE meds (
    meds_id INT NOT NULL AUTO_INCREMENT,
    meds_name VARCHAR(255) NOT NULL,
    meds_strength_id INT NOT NULL,
    meds_cost DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (meds_id)
) ENGINE=InnoDB;

CREATE TABLE meds_strenghts (
    meds_strength_id INT NOT NULL AUTO_INCREMENT,
    meds_strength_value VARCHAR(255) NOT NULL,
    meds_strength_unit VARCHAR(255) NOT NULL,
    PRIMARY KEY (meds_strength_id)
) ENGINE=InnoDB;

CREATE TABLE discounts (
    discount_id INT NOT NULL AUTO_INCREMENT,
    discount_amount FLOAT NOT NULL,
    PRIMARY KEY (discount_id)
) ENGINE=InnoDB;

CREATE TABLE invoices (
    invoice_number INT NOT NULL AUTO_INCREMENT,
    invoice_date DATE NOT NULL,
    office_id INT NOT NULL,
    customer_id INT NOT NULL,
    PRIMARY KEY (invoice_number)
) ENGINE=InnoDB;


/*
creating the junction tables
*/


CREATE TABLE customers_patients (
    fk_customer_id INT NOT NULL,
    fk_patient_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE customers_addresses (
    fk_customer_id INT NOT NULL,
    fk_address_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE staff_addresses (
    fk_staff_id INT NOT NULL,
    fk_address_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE doctors_addresses (
    fk_doctor_id INT NOT NULL,
    fk_address_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE staff_offices (
    fk_staff_id INT NOT NULL,
    fk_office_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE doctors_offices (
    fk_doctor_id INT NOT NULL,
    fk_office_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE visits_procedures (
    fk_visit_id INT NOT NULL,
    fk_procedure_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE invoices_visits (
    fk_invoice_number INT NOT NULL,
    fk_visit_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE invoices_discounts (
    fk_invoice_number INT NOT NULL,
    fk_discount_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE invoices_procedures (
    fk_invoice_number INT NOT NULL,
    fk_procedure_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE invoices_patients (
    fk_invoice_number INT NOT NULL,
    fk_patient_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE invoices_vaccinations (
    fk_invoice_number INT NOT NULL,
    fk_vaccination_id INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE visits_meds (
    fk_visit_id INT NOT NULL,
    fk_meds_id INT NOT NULL
) ENGINE=InnoDB;



/*
adding the foreign key constraints
*/

ALTER TABLE patients 
ADD CONSTRAINT fk_patient_types_type_id_patients_type_id 
	FOREIGN KEY (type_id) REFERENCES patient_types (type_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE doctors 
ADD CONSTRAINT fk_offices_office_id_doctors_office_id
	FOREIGN KEY (office_id) REFERENCES offices (office_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE offices 
ADD CONSTRAINT fk_addresses_address_id_offices_address_id
	FOREIGN KEY (address_id) REFERENCES addresses (address_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
        
ALTER TABLE visits
ADD CONSTRAINT fk_visit_types_visit_type_id_visits_visit_type_id
	FOREIGN KEY (visit_type_id) REFERENCES visit_types (visit_type_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT fk_patients_patient_id_visits_patient_id
	FOREIGN KEY (patient_id) REFERENCES patients (patient_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT doctors_doctor_id_visits_doctor_id
	FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT fk_vaccinations_vaccination_id_visits_vaccination_id
	FOREIGN KEY (vaccination_id) REFERENCES vaccinations (vaccination_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE;        
        
ALTER TABLE vaccinations
ADD CONSTRAINT fk_vaccines_vaccine_id_vaccinations_vaccine_id
	FOREIGN KEY (vaccine_id) REFERENCES vaccines (vaccine_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT fk_patients_patient_id_vaccinations_patient_id
	FOREIGN KEY (patient_id) REFERENCES patients (patient_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE;        
        
ALTER TABLE meds
ADD CONSTRAINT fk_meds_strenghts_meds_strength_id_meds_meds_strength_id
	FOREIGN KEY (meds_strength_id) REFERENCES meds_strenghts (meds_strength_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE;       
        
ALTER TABLE invoices
ADD CONSTRAINT fk_offices_office_id_invoices_office_id
	FOREIGN KEY (office_id) REFERENCES offices (office_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT fk_customers_customer_id_invoices_customer_id
	FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE;        
        


/*
adding the junction table constraints
*/

ALTER TABLE customers_patients
ADD CONSTRAINT fk_customers_customer_id_customers_patients_fk_customer_id
    FOREIGN KEY (fk_customer_id) REFERENCES customers (customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_patients_patient_id_customers_patients_fk_patient_id
    FOREIGN KEY (fk_patient_id) REFERENCES patients (patient_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE customers_addresses
ADD CONSTRAINT fk_customers_customer_id_customers_addresses_fk_customer_id
    FOREIGN KEY (fk_customer_id) REFERENCES customers (customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_addresses_address_id_customers_addresses_fk_address_id
    FOREIGN KEY (fk_address_id) REFERENCES addresses (address_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE staff_addresses
ADD CONSTRAINT fk_staff_staff_id_staff_addresses_fk_staff_id
    FOREIGN KEY (fk_staff_id) REFERENCES staff (staff_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_addresses_address_id_staff_addresses_fk_address_id
    FOREIGN KEY (fk_address_id) REFERENCES addresses (address_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE doctors_addresses
ADD CONSTRAINT fk_doctors_doctor_id_doctors_addresses_fk_doctor_id
    FOREIGN KEY (fk_doctor_id) REFERENCES doctors (doctor_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_addresses_address_id_doctors_addresses_fk_address_id
    FOREIGN KEY (fk_address_id) REFERENCES addresses (address_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE staff_offices
ADD CONSTRAINT fk_staff_staff_id_staff_offices_fk_staff_id
    FOREIGN KEY (fk_staff_id) REFERENCES staff (staff_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_offices_office_id_staff_offices_fk_office_id
    FOREIGN KEY (fk_office_id) REFERENCES offices (office_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE doctors_offices
ADD CONSTRAINT fk_doctors_doctor_id_doctors_offices_fk_doctor_id
    FOREIGN KEY (fk_doctor_id) REFERENCES doctors (doctor_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_offices_office_id_doctors_offices_fk_office_id
    FOREIGN KEY (fk_office_id) REFERENCES offices (office_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE visits_procedures
ADD CONSTRAINT fk_visits_visit_id_visits_procedures_fk_visit_id
    FOREIGN KEY (fk_visit_id) REFERENCES visits (visit_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_procedures_procedure_id_visits_procedures_fk_procedure_id
    FOREIGN KEY (fk_procedure_id) REFERENCES procedures (procedure_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE invoices_visits
ADD CONSTRAINT fk_invoices_invoice_number_invoices_visits_fk_invoice_number
    FOREIGN KEY (fk_invoice_number) REFERENCES invoices (invoice_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_visits_visit_id_invoices_visits_fk_visit_id
    FOREIGN KEY (fk_visit_id) REFERENCES visits (visit_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE invoices_discounts
ADD CONSTRAINT fk_invoices_invoice_number_invoices_discounts_fk_invoice_number
    FOREIGN KEY (fk_invoice_number) REFERENCES invoices (invoice_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_discounts_discount_id_invoices_discounts_fk_discount_id
    FOREIGN KEY (fk_discount_id) REFERENCES discounts (discount_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE invoices_procedures
ADD CONSTRAINT fk_invoices_invoice_number_invoices_procedures_fk_invoice_number
    FOREIGN KEY (fk_invoice_number) REFERENCES invoices (invoice_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_procedures_procedure_id_invoices_procedures_fk_procedure_id
    FOREIGN KEY (fk_procedure_id) REFERENCES procedures (procedure_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE invoices_patients
ADD CONSTRAINT fk_invoices_invoice_number_invoices_patients_fk_invoice_number
    FOREIGN KEY (fk_invoice_number) REFERENCES invoices (invoice_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_patients_patient_id_invoices_patients_fk_patient_id
    FOREIGN KEY (fk_patient_id) REFERENCES patients (patient_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE invoices_vaccinations
ADD CONSTRAINT fk_invoices_invoice_nr_invoices_vaccinations_fk_invoice_nr -- i got an error that the identifier name is too long, so it does not match the format
    FOREIGN KEY (fk_invoice_number) REFERENCES invoices (invoice_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_vaccinations_vacc_id_invoices_vaccinations_fk_vacc_id  -- i got an error that the identifier name is too long, so it does not match the format
    FOREIGN KEY (fk_vaccination_id) REFERENCES vaccinations (vaccination_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE visits_meds
ADD CONSTRAINT fk_visits_visit_id_visits_meds_fk_visit_id
    FOREIGN KEY (fk_visit_id) REFERENCES visits (visit_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
ADD CONSTRAINT fk_meds_meds_id_visits_meds_fk_meds_id
    FOREIGN KEY (fk_meds_id) REFERENCES meds (meds_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;


/*
adding data to the tables without foreign keys.
*/

INSERT INTO patient_types (type_name) 
VALUES
('dog'),
('cat');


INSERT INTO customers (first_name, last_name)
VALUES 
    ('John', 'Smith'),
    ('Emily', 'Johnson'),
    ('Michael', 'Williams'),
    ('Sarah', 'Brown'),
    ('Christopher', 'Davis'),
    ('Jessica', 'Miller'),
    ('Matthew', 'Wilson'),
    ('Samantha', 'Moore'),
    ('Nicholas', 'Taylor'),
    ('Amanda', 'Anderson'),
    ('Daniel', 'Martinez');


INSERT INTO staff (staff_first_name, staff_last_name, tech_license_number)
VALUES 
    ('Robert', 'Johnson', 'TLN123'),
    ('Jennifer', 'Williams', 'TLN234'),
    ('David', 'Jones', 'TLN345'),
    ('Mary', 'Brown', NULL),
    ('James', 'Miller', NULL),
    ('Patricia', 'Davis', 'TLN456'),
    ('John', 'Garcia', 'TLN567'),
    ('Susan', 'Rodriguez', NULL),
    ('Michael', 'Wilson', NULL),
    ('Linda', 'Martinez', NULL),
    ('William', 'Hernandez', 'TLN678'),
    ('Emily', 'Martinez', NULL),
    ('Michael', 'Anderson', NULL),
    ('Sarah', 'Thompson', NULL),
    ('Christopher', 'White', NULL),
    ('Jessica', 'Harris', NULL),
    ('Matthew', 'Martin', NULL),
    ('Samantha', 'Jackson', NULL),
    ('Nicholas', 'Garcia', NULL),
    ('Amanda', 'Thomas', 'ATN123'),
    ('Daniel', 'Rodriguez', 'DRN234'),
    ('Ashley', 'Wilson', 'AWN345'),
    ('Jason', 'Davis', 'JDN456'),
    ('Kimberly', 'Martinez', 'KMN567'),
    ('Ryan', 'Brown', 'RBN678'),
    ('Michelle', 'Thompson', 'MTN789');


INSERT INTO addresses (street, city, state, zip)
VALUES
    ('123 Main St', 'Monaca', 'PA', '15061'),
    ('456 Elm St', 'Monongahela', 'PA', '15063'),
    ('789 Oak St', 'Braddock', 'PA', '15104'),
    ('101 Maple St', 'Coraopolis', 'PA', '15108'),
    ('202 Pine St', 'White Oak', 'PA', '15131'),
    ('303 Cedar St', 'Pittsburgh', 'PA', '15201'),
    ('404 Walnut St', 'Pittsburgh', 'PA', '15224'),
    ('505 Birch St', 'Pittsburgh', 'PA', '15232'),
    ('606 Chestnut St', 'Pittsburgh', 'PA', '15238'),
    ('707 Spruce St', 'Pittsburgh', 'PA', '15217'),
    ('808 Ash St', 'Steubenville', 'OH', '43952'),
    ('909 Walnut St', 'East Liverpool', 'OH', '43920'),
    ('1010 Oak St', 'New Kensington', 'PA', '15068'),
    ('1111 Pine St', 'West Mifflin', 'PA', '15122'),
    ('1212 Cherry St', 'Monroeville', 'PA', '15146'),
    ('1313 Elm St', 'Greensburg', 'PA', '15601'),
    ('1414 Oak St', 'Wexford', 'PA', '15090'),
    ('1515 Maple St', 'Cranberry Township', 'PA', '16066'),
    ('1616 Pine St', 'Moon Township', 'PA', '15108'),
    ('1717 Walnut St', 'Bridgeville', 'PA', '15017'),
    ('1818 Birch St', 'Canonsburg', 'PA', '15317'),
    ('1919 Chestnut St', 'Bethel Park', 'PA', '15102'),
    ('2020 Spruce St', 'Mt. Lebanon', 'PA', '15228'),
    ('2121 Ash St', 'Sewickley', 'PA', '15143'),
    ('2222 Walnut St', 'Monessen', 'PA', '15062'),
    ('2323 Pine St', 'Washington', 'PA', '15301'),
    ('2424 Cedar St', 'McKeesport', 'PA', '15132'),
    ('2525 Oak St', 'Aliquippa', 'PA', '15001'),
    ('2626 Maple St', 'Bethany', 'WV', '26032'),
    ('2727 Pine St', 'Wellsburg', 'WV', '26070'),
    ('2828 Walnut St', 'Toronto', 'OH', '43964'),
    ('2929 Birch St', 'Weirton', 'WV', '26062'),
    ('3030 Chestnut St', 'Wheeling', 'WV', '26003'),
    ('3131 Spruce St', 'Follansbee', 'WV', '26037'),
    ('3232 Ash St', 'Pittsburgh', 'PA', '15221'),
    ('3333 Elm St', 'Pittsburgh', 'PA', '15225'),
    ('3434 Oak St', 'Pittsburgh', 'PA', '15236'),
    ('3535 Maple St', 'Pittsburgh', 'PA', '15239'),
    ('3636 Pine St', 'Pittsburgh', 'PA', '15241'),
    ('3737 Walnut St', 'Pittsburgh', 'PA', '15244'),
    ('3838 Birch St', 'Pittsburgh', 'PA', '15247'),
    ('3939 Chestnut St', 'Pittsburgh', 'PA', '15250'),
    ('4040 Spruce St', 'Pittsburgh', 'PA', '15253'),
    ('4141 Ash St', 'Pittsburgh', 'PA', '15256'),
    ('4242 Cherry St', 'Sewickley', 'PA', '15143'),
    ('4343 Elm St', 'Canonsburg', 'PA', '15317'),
    ('4444 Oak St', 'Monroeville', 'PA', '15146'),
    ('4545 Maple St', 'Bethel Park', 'PA', '15102'),
    ('4646 Pine St', 'Washington', 'PA', '15301'),
    ('4747 Walnut St', 'Greensburg', 'PA', '15601'),
    ('4848 Birch St', 'Wexford', 'PA', '15090'),
    ('4949 Chestnut St', 'Moon Township', 'PA', '15108'),
    ('5050 Spruce St', 'Bridgeville', 'PA', '15017'),
    ('5151 Ash St', 'Monessen', 'PA', '15062');



INSERT INTO visit_types (visit_type_name, visit_cost)
VALUES
    ('health check', 100),
    ('complete check', 150),
    ('tech visit', 50),
    ('vaccine', 50),
    ('dental cleaning', 120),
    ('ultrasound', 200),
    ('blood test', 80),
    ('flea treatment', 40),
    ('ear infection check', 90),
    ('surgery consultation', 175),
    ('other', 75);

INSERT INTO procedures (procedure_name, procedure_cost)
VALUES
    ('NA', 0),
    ('neuter', 250),
    ('spay', 350),
    ('dental', 300),
    ('mass removal', 350),
    ('amputation', 500),
    ('aural hematoma', 150),
    ('enucleation', 800),
    ('fracture repair', 1000),
    ('pyometra', 450),
    ('foreign body', 650),
    ('laparoscopy', 150);

INSERT INTO vaccines (vaccine_name, vaccine_cost)
VALUES
	('NA', 0),
    ('Rabies', 50),
    ('Parvovirus', 60),
    ('Canine Parainfluenza', 70),
    ('Canine Hepatitis', 80),
    ('Canine Distemper Virus', 50),
    ('Feline Panleukopenia', 55),
    ('Feline Rhinotracheitis', 45),
    ('Feline Calicivirus', 40),
    ('Leptospirosis', 65),
    ('Bordetella', 45),
    ('Lyme Disease', 70);

INSERT INTO meds_strenghts (meds_strength_value, meds_strength_unit)
VALUES
(1, 'ml'),
(5, 'ml'),
(15, 'ml'),
(25, 'ml'),
(35, 'ml'),
(45, 'ml'),
(10, 'mg'),
(20, 'mg'),
(30, 'mg'),
(40, 'mg'),
(50, 'mg'),
(60, 'mg');

INSERT INTO discounts (discount_amount) VALUES (10), (20), (30), (40), (50), (60), (70), (80), (90), (100);


/*
adding data to the tables with foreign keys.
*/


INSERT INTO patients (patient_name, type_id, patient_dob, microchip_number, alteration, health_issues, fractious)
VALUES
    ('Skippy', 1, '2020-01-01', 123456789, TRUE, 'back pain', 'does not like vaccines'),
    ('Tiger', 2, '2021-02-02', 987654321, TRUE, 'misses a leg', 'vicious'),
    ('Charlie', 1, '2018-03-03', 831038658, TRUE, 'blind', NULL),
    ('Luna', 1, '2017-05-05', 53296596, FALSE, 'ear infections', 'very scared'),
    ('Cooper', 1, '2022-06-15', 699859334, TRUE, 'diabetes', NULL),
    ('Daisy', 1, '2022-03-09', 96022642, NULL, 'deaf', 'hates muzzles'),
    ('Bella', 2, '2023-07-09', 785944559, FALSE, NULL, NULL),
    ('Simba', 2, '2024-01-15', 262000942, FALSE, NULL, NULL),
    ('Milo', 2, '2014-06-08', NULL, TRUE, 'kidney issues', 'scratches like crazy'),
    ('Kitty', 2, '2018-07-23', 923422356, TRUE, 'allergies', 'vicious'),
    ('Cleo', 2, '2020-09-03', 258694228, FALSE, NULL, 'vicious'),
	('Max', 1, '2019-08-12', 471258963, FALSE, NULL, NULL),
    ('Luna', 2, '2020-04-05', 582963147, TRUE, 'allergies', NULL),
    ('Rocky', 1, '2017-11-20', 695213874, TRUE, 'arthritis', NULL);

INSERT INTO offices (office_name, address_id, tax_rate)
VALUES
    ('Strip District', 1, 7),
    ('Squirell Hill', 2, 7),
    ('Brookline', 3, 7),
    ('Wexford', 4, 7),
    ('Homestead', 5, 7),
    ('Monroeville', 6, 7),
    ('Tarentum', 7, 7),
    ('Elwood City', 8, 6),
    ('Greensburgh', 9, 5),
    ('South Park', 10, 7),
    ('Gibsonia', 11, 7);

INSERT INTO doctors (doctor_first_name, doctor_last_name, vet_license_number, dea_license_number, usda_license_number, office_id)
VALUES
    ('Emma', 'Smith', 'VET123', 'DEA123', 'USDA123', 1),
    ('James', 'Johnson', 'VET234', 'DEA234', 'USDA234', 1),
    ('Olivia', 'Williams', 'VET345', 'DEA345', 'USDA345', 2),
    ('Liam', 'Brown', 'VET456', 'DEA456', 'USDA456', 2),
    ('Sophia', 'Miller', 'VET567', 'DEA567', 'USDA567', 3),
    ('Noah', 'Davis', 'VET678', 'DEA678', 'USDA678', 3),
    ('Ava', 'Garcia', 'VET789', 'DEA789', 'USDA789', 4),
    ('William', 'Rodriguez', 'VET890', 'DEA890', 'USDA890', 4),
    ('Isabella', 'Martinez', 'VET901', 'DEA901', 'USDA901', 5),
    ('Oliver', 'Wilson', 'VET012', 'DEA012', 'USDA012', 5),
    ('Mia', 'Anderson', 'VET123', 'DEA123', 'USDA123', 6),
    ('Elijah', 'Hernandez', 'VET234', 'DEA234', 'USDA234', 6),
    ('Charlotte', 'Taylor', 'VET345', 'DEA345', 'USDA345', 7),
    ('Lucas', 'Moore', 'VET456', 'DEA456', 'USDA456', 7),
    ('Amelia', 'Thomas', 'VET567', 'DEA567', 'USDA567', 8),
    ('Mason', 'Jackson', 'VET678', 'DEA678', 'USDA678', 8),
    ('Harper', 'White', 'VET789', 'DEA789', 'USDA789', 9),
    ('Ethan', 'Harris', 'VET890', 'DEA890', 'USDA890', 9),
    ('Evelyn', 'Martin', 'VET901', 'DEA901', 'USDA901', 10),
    ('Alexander', 'Thompson', 'VET012', 'DEA012', 'USDA012', 10),
    ('Abigail', 'Garcia', 'VET123', 'DEA123', 'USDA123', 11);

INSERT INTO meds (meds_name, meds_strength_id, meds_cost) 
VALUES
	('NA', 1, 0),
    ('Amoxicillin', 2, 20),
	('Cephalexin', 3, 25),
	('Clindamycin', 4, 30),
	('Enrofloxacin', 5, 35),
	('Metronidazole', 6, 18),
	('Doxycycline', 7, 27),
	('Prednisone', 8, 15),
	('Tramadol', 9, 22),
	('Carprofen', 10, 28),
	('Diazepam', 11, 19),
	('Furosemide', 12, 21);

INSERT INTO customers_patients (fk_customer_id, fk_patient_id)
VALUES
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
    (11, 11),
    (2, 12),
    (3, 13),
    (4, 14);

INSERT INTO customers_addresses (fk_customer_id, fk_address_id)
VALUES
    (1, 12),
    (2, 13),
    (3, 14),
    (4, 15),
    (5, 16),
    (6, 17),
    (7, 18),
    (8, 19),
    (9, 20),
    (10, 21),
    (11, 22);

INSERT INTO staff_addresses (fk_staff_id, fk_address_id)
VALUES
    (1, 23),
    (2, 24),
    (3, 25),
    (4, 26),
    (5, 27),
    (6, 28),
    (7, 29),
    (8, 30),
    (9, 31),
    (10, 32),
    (11, 23);

INSERT INTO doctors_addresses (fk_doctor_id, fk_address_id)
VALUES
    (1, 33),
    (2, 34),
    (3, 35),
    (4, 36),
    (5, 37),
    (6, 38),
    (7, 39),
    (8, 40),
    (9, 41),
    (10, 42),
    (11, 43),
    (12, 44),
    (13, 45),
    (14, 46),
    (15, 47),
    (16, 48),
    (17, 49),
    (18, 50),
    (19, 51),
    (20, 33),
    (21, 34);

INSERT INTO staff_offices (fk_staff_id, fk_office_id)
VALUES
    (1, 7),
    (2, 8),
    (3, 9),
    (4, 1),
    (5, 2), 
    (6, 10),
    (7, 11), 
    (8, 3),
    (9, 4),
    (10, 5),
    (11, 5),
    (12, 6),
    (13, 7),
    (14, 8),
    (15, 9),
    (16, 10),
    (17, 11),
    (18, 7),
    (19, 8),
    (20, 1),
    (21, 2), 
    (22, 3),
    (23, 4),
    (24, 5),
    (25, 6), 
    (22, 6);

INSERT INTO doctors_offices (fk_doctor_id, fk_office_id) 
VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 2),
	(5, 3),
	(6, 3),
	(7, 4),
	(8, 4),
	(9, 5),
	(10, 5),
	(11, 6),
	(12, 6),
	(13, 7),
	(14, 7),
	(15, 8),
	(16, 8),
	(17, 9),
	(18, 9),
	(19, 10),
	(20, 10),
	(21, 10);

-- TRANSACTION populating the fields with random data, this can be used to ensure that the queries are functioning.
DROP PROCEDURE IF EXISTS sp_visit_invoice; -- making sure it can be run again

DELIMITER //

CREATE PROCEDURE sp_visit_invoice()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Insert into vaccinations
    INSERT INTO vaccinations (vaccine_id, vaccination_date, patient_id)
    SELECT vaccine_id, CURDATE(), patient_id
    FROM vaccines
    CROSS JOIN (SELECT patient_id FROM patients ORDER BY RAND() LIMIT 1) AS p
    ORDER BY RAND() LIMIT 1;

    -- Insert into visits
    INSERT INTO visits (visit_type_id, visit_date, patient_id, doctor_id, vaccination_id, weight, dental, eyes, notes)
    SELECT visit_type_id, CURDATE(), patient_id, doctor_id, LAST_INSERT_ID(), RAND() * (50 - 10) + 10, 'Good', 'Clear', 'No abnormalities'
    FROM visit_types
    CROSS JOIN (SELECT patient_id FROM patients ORDER BY RAND() LIMIT 1) AS p
    CROSS JOIN (SELECT doctor_id FROM doctors ORDER BY RAND() LIMIT 1) AS d
    ORDER BY RAND() LIMIT 1;

    -- Insert into visits_procedures
    INSERT INTO visits_procedures (fk_visit_id, fk_procedure_id)
    SELECT LAST_INSERT_ID(), procedure_id
    FROM procedures
    ORDER BY RAND() LIMIT 1;

    -- Insert into visits_meds
    INSERT INTO visits_meds (fk_visit_id, fk_meds_id)
    SELECT LAST_INSERT_ID(), meds_id
    FROM meds
    ORDER BY RAND() LIMIT 1;

    -- Insert into invoices
    INSERT INTO invoices (invoice_date, office_id, customer_id)
    SELECT CURDATE(), (SELECT office_id FROM doctors WHERE doctor_id = visits.doctor_id), (SELECT fk_customer_id FROM customers_patients WHERE patient_id = visits.patient_id LIMIT 1)
    FROM visits
    ORDER BY RAND() LIMIT 1;

    -- Insert into invoices_visits
    INSERT INTO invoices_visits (fk_invoice_number, fk_visit_id)
    SELECT LAST_INSERT_ID(), visit_id
    FROM visits
    ORDER BY RAND() LIMIT 1;

    -- Insert into invoices_procedures
    INSERT INTO invoices_procedures (fk_invoice_number, fk_procedure_id)
    SELECT LAST_INSERT_ID(), fk_procedure_id
    FROM visits_procedures
    WHERE fk_visit_id = (SELECT fk_visit_id FROM invoices_visits WHERE fk_invoice_number = LAST_INSERT_ID());

    -- Insert into invoices_patients
    INSERT INTO invoices_patients (fk_invoice_number, fk_patient_id)
    SELECT LAST_INSERT_ID(), patient_id
    FROM visits
    WHERE visit_id = (SELECT fk_visit_id FROM invoices_visits WHERE fk_invoice_number = LAST_INSERT_ID());

    -- Insert into invoices_vaccinations
    INSERT INTO invoices_vaccinations (fk_invoice_number, fk_vaccination_id)
    SELECT LAST_INSERT_ID(), vaccination_id
    FROM visits
    WHERE visit_id = (SELECT fk_visit_id FROM invoices_visits WHERE fk_invoice_number = LAST_INSERT_ID());

    COMMIT;
END//

DELIMITER ;

/*
To call the procedure:
*/

CALL sp_visit_invoice();

-- TRANSACTION filling the tables -> requires input, this is the version employees would use to enter a visit.
DROP PROCEDURE IF EXISTS sp_visit_invoice_in;-- making sure it may run again

DELIMITER //

CREATE PROCEDURE sp_visit_invoice_in(
    IN tr_visit_type VARCHAR(255),
    IN tr_customer_first_name VARCHAR(255),
    IN tr_customer_last_name VARCHAR(255),
    IN tr_patient_name VARCHAR(255),
    IN tr_doctor_first_name VARCHAR(255),
    IN tr_doctor_last_name VARCHAR(255),
    IN tr_vaccine_name VARCHAR(255),
    IN tr_procedure_name VARCHAR(255),
    IN tr_meds_name VARCHAR(255),
    IN tr_weight FLOAT,
    IN tr_dental VARCHAR(255),
    IN tr_eyes VARCHAR(255),
    IN tr_notes VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Get visit type id
    SET @visit_type_id = (SELECT visit_type_id FROM visit_types WHERE visit_type_name = tr_visit_type LIMIT 1);

    -- Get customer id
    SET @customer_id = (SELECT customer_id FROM customers WHERE first_name = tr_customer_first_name AND last_name = tr_customer_last_name LIMIT 1);

    -- Get patient id based on customer and patient name
    SET @patient_id = (SELECT patient_id FROM patients WHERE patient_name = tr_patient_name AND type_id = @customer_id LIMIT 1);

    -- Get doctor id
    SET @doctor_id = (SELECT doctor_id FROM doctors WHERE doctor_first_name = tr_doctor_first_name AND doctor_last_name = tr_doctor_last_name LIMIT 1);

    -- Get office id
    SET @office_id = (SELECT fk_office_id FROM doctors_offices WHERE fk_doctor_id = @doctor_id LIMIT 1);

    -- Get vaccine id
    SET @vaccine_id = (SELECT vaccine_id FROM vaccines WHERE vaccine_name = tr_vaccine_name LIMIT 1);

    -- Get procedure id
    SET @procedure_id = (SELECT procedure_id FROM procedures WHERE procedure_name = tr_procedure_name LIMIT 1);

    -- Get meds id
    SET @meds_id = (SELECT meds_id FROM meds WHERE meds_name = tr_meds_name LIMIT 1);

    -- Insert into vaccinations
    INSERT INTO vaccinations (vaccine_id, vaccination_date, patient_id)
    VALUES (@vaccine_id, CURDATE(), @patient_id);

    -- Insert into visits
    INSERT INTO visits (visit_type_id, visit_date, patient_id, doctor_id, vaccination_id, weight, dental, eyes, notes)
    VALUES (@visit_type_id, CURDATE(), @patient_id, @doctor_id, LAST_INSERT_ID(), tr_weight, tr_dental, tr_eyes, tr_notes);

    -- Insert into visits_procedures
    INSERT INTO visits_procedures (fk_visit_id, fk_procedure_id)
    VALUES (LAST_INSERT_ID(), @procedure_id);

    -- Insert into visits_meds
    INSERT INTO visits_meds (fk_visit_id, fk_meds_id)
    VALUES (LAST_INSERT_ID(), @meds_id);

    -- Insert into invoices
    INSERT INTO invoices (invoice_date, office_id, customer_id)
    VALUES (CURDATE(), @office_id, @customer_id);

    -- Insert into invoices_visits
    INSERT INTO invoices_visits (fk_invoice_number, fk_visit_id)
    VALUES (LAST_INSERT_ID(), LAST_INSERT_ID());

    -- Insert into invoices_procedures
    INSERT INTO invoices_procedures (fk_invoice_number, fk_procedure_id)
    VALUES (LAST_INSERT_ID(), @procedure_id);

    -- Insert into invoices_patients
    INSERT INTO invoices_patients (fk_invoice_number, fk_patient_id)
    VALUES (LAST_INSERT_ID(), @patient_id);

    -- Insert into invoices_vaccinations
    INSERT INTO invoices_vaccinations (fk_invoice_number, fk_vaccination_id)
    VALUES (LAST_INSERT_ID(), LAST_INSERT_ID());

    COMMIT;
END//

DELIMITER ;

/*
To call the procedure, example:
*/

CALL sp_visit_invoice_in('health check','Emily', 'Johnson', 'Tiger','Liam', 'Brown','Rabies', 'spay', 'Amoxicillin','35','teeht are good', 'eyes are cloudy', 'no nothes');

    
-- 1.	Which patients are registered at the veterinary office, and who are their owners?
DROP VIEW IF EXISTS patient_owner_view; 

CREATE VIEW patient_owner_view AS
SELECT 
    p.patient_name AS Patient_Name,
    CONCAT(c.first_name, ' ', c.last_name) AS Owner_Name
FROM 
    patients p
JOIN 
    customers_patients cp ON p.patient_id = cp.fk_patient_id
JOIN 
    customers c ON cp.fk_customer_id = c.customer_id;

-- To run the query:

SELECT * FROM patient_owner_view;
DROP VIEW IF EXISTS patient_owner_view; 

-- 2.	Which patient files have "dog" as the type?
DROP VIEW IF EXISTS patient_type_view; 

CREATE VIEW patient_type_view AS
SELECT * FROM patients p
WHERE p.type_id IN (SELECT type_id FROM patient_types WHERE type_name = 'dog');

-- To run the query:

SELECT * FROM patient_type_view;
DROP VIEW IF EXISTS patient_type_view; 

-- 3.	How many visits has each patient made to the veterinary office?
DROP VIEW IF EXISTS patient_visit_office; 

CREATE VIEW patient_visit_office AS
SELECT 
	p.patient_name AS Patient_Name,
    CONCAT(c.first_name, ' ', c.last_name) AS Owner_Name,
    COUNT(v.visit_id) AS Number_of_Visits
FROM 
    patients p
JOIN 
    visits v ON p.patient_id = v.patient_id
JOIN 
    customers_patients cp ON p.patient_id = cp.fk_patient_id
JOIN 
    customers c ON cp.fk_customer_id = c.customer_id
GROUP BY p.patient_name,
    CONCAT(c.first_name, ' ', c.last_name);

-- To run the query:

SELECT * FROM patient_visit_office;
DROP VIEW IF EXISTS patient_visit_office; 

-- 4.	What is the average visit cost for the visit with the ID of 2?

CREATE VIEW average_visit_cost_view AS
SELECT 
    v.visit_id AS Visit_ID,
    AVG(vt.visit_cost + COALESCE(procedures_total.procedure_total_cost, 0) + COALESCE(vaccines_total.vaccine_total_cost, 0)) AS Average_Visit_Cost
FROM 
    visits v
JOIN 
    visit_types vt ON v.visit_type_id = vt.visit_type_id
LEFT JOIN 
    (
        SELECT 
            vp.fk_visit_id,
            SUM(p.procedure_cost) AS procedure_total_cost
        FROM 
            visits_procedures vp
        LEFT JOIN 
            procedures p ON vp.fk_procedure_id = p.procedure_id
        GROUP BY 
            vp.fk_visit_id
    ) AS procedures_total ON v.visit_id = procedures_total.fk_visit_id
LEFT JOIN 
    (
        SELECT 
            v.visit_id,
            SUM(vc.vaccine_cost) AS vaccine_total_cost
        FROM 
            visits v
        LEFT JOIN 
            vaccines vc ON v.vaccination_id = vc.vaccine_id
        GROUP BY 
            v.visit_id
    ) AS vaccines_total ON v.visit_id = vaccines_total.visit_id
GROUP BY 
    v.visit_id
HAVING 
	v.visit_id = '2';

-- To run the query:

SELECT * FROM average_visit_cost_view;
DROP VIEW IF EXISTS average_visit_cost_view; 

-- 5.	Which invoices have been issued by the veterinary office, and what are the details of each invoice?

CREATE VIEW invoice_details_view AS
SELECT 
    i.invoice_number AS Invoice_Number, 
    i.invoice_date AS Invoice_Date, 
    o.office_name AS Office_Name,
    c.first_name AS Customer_First_Name, 
    c.last_name AS Customer_Last_Name 
FROM 
    invoices i 
INNER JOIN 
    customers c ON i.customer_id = c.customer_id
INNER JOIN
    offices o ON i.office_id = o.office_id;

-- To run the query:

SELECT * FROM invoice_details_view;
DROP VIEW IF EXISTS invoice_details_view; 

-- 6.	What is the highest total cost of medication for a patient treated at the veterinary office?

CREATE VIEW patient_medication_cost_view AS
SELECT 
    p.patient_name AS Patient_Name, 
    SUM(m.meds_cost) AS Total_Medication_Cost
FROM 
    patients p
INNER JOIN 
    visits v ON p.patient_id = v.patient_id
INNER JOIN 
    visits_meds vm ON v.visit_id = vm.fk_visit_id
INNER JOIN 
    meds m ON vm.fk_meds_id = m.meds_id
GROUP BY 
    p.patient_name
ORDER BY
	SUM(m.meds_cost)
LIMIT 1;

-- To run the query:

SELECT * FROM patient_medication_cost_view;
DROP VIEW IF EXISTS patient_medication_cost_view; 

-- 7.	Which patients at the veterinary office have health issues or exhibit fractious behavior?

CREATE VIEW patient_health_issues_view AS
SELECT 
    patient_name AS Patient_Name, 
    health_issues AS Health_Issues, 
	fractious  AS Fractious_Behavior
FROM 
    patients
WHERE 
    health_issues IS NOT NULL OR 
    fractious IS NOT NULL;

-- To run the query:

SELECT * FROM patient_health_issues_view;
DROP VIEW IF EXISTS patient_health_issues_view; 

-- 8.	What are the address details of the veterinary office?

CREATE VIEW office_address_details_view AS
SELECT 
    o.office_name AS Office_Name,
    a.street AS Street,
    a.city AS City,
    a.state AS State,
    a.zip AS Zipcode
FROM 
    offices o
JOIN 
    addresses a ON o.address_id = a.address_id;

-- To run the query:

SELECT * FROM office_address_details_view;
DROP VIEW IF EXISTS office_address_details_view; 

-- 9.	Who are the staff members working at the veterinary office in South Park?

CREATE VIEW staff_office_details_view AS
SELECT 
    s.staff_first_name AS First_Name,
    s.staff_last_name AS Last_Name,
    o.office_name AS Office_Name
FROM 
    staff s
JOIN 
    staff_offices so ON s.staff_id = so.fk_staff_id
JOIN 
    offices o ON so.fk_office_id = o.office_id;

-- To run the query:

SELECT * FROM staff_office_details_view;
DROP VIEW IF EXISTS staff_office_details_view; 

-- 10.	How many vaccinations have been administered for each vaccine type at the veterinary office?
CREATE VIEW vaccination_counts_view AS
SELECT 
    v.vaccine_name AS Vaccine_Type,
    COUNT(*) AS Total_Vaccinations
FROM 
    vaccinations vac
JOIN 
    vaccines v ON vac.vaccine_id = v.vaccine_id
GROUP BY 
    v.vaccine_name;

-- To run the query:

SELECT * FROM vaccination_counts_view;
DROP VIEW IF EXISTS vaccination_counts_view; 