SHOW VARIABLES LIKE 'secure_file_priv';

DROP TABLE IF EXISTS Diagnoses;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;

Select DATABASE();
Use healthcaredb;
-- Patients table
CREATE TABLE IF NOT EXISTS Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    DOB DATE,
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

-- Doctors table
CREATE TABLE IF NOT EXISTS Doctors (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

-- Appointments table
CREATE TABLE IF NOT EXISTS Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    Reason VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Diagnoses table
CREATE TABLE IF NOT EXISTS Diagnoses (
    DiagnosisID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT,
    DiagnosisText TEXT,
    PrescribedMedication TEXT,
    FollowUpDate DATE,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Load patient data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/patients.csv'
INTO TABLE Patients
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(patientid, firstname, lastname, gender, dob, phone, email);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/doctors.csv'
INTO TABLE Doctors
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(DoctorID, FirstName, LastName, Specialty, Phone, Email);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/appointments.csv'
INTO TABLE Appointments
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(AppointmentID, PatientID, DoctorID, AppointmentDate, Reason);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/diagnoses.csv'
INTO TABLE Diagnoses
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(DiagnosisID, AppointmentID, DiagnosisText, PrescribedMedication, FollowUpDate);

-- Filter on patient table for patients born after 1990
DESCRIBE Patients;
SELECT * from Patients WHERE DOB > "1990-07-01";

-- Find all appointments for each patient and list the respective doctors

SELECT a.AppointmentID, a.AppointmentDate, p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName, a.Reason
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
WHERE a.AppointmentDate >= NOW()
ORDER BY a.AppointmentDate;

-- Current doctors per speciality in the hospital

SELECT Specialty, COUNT(*) AS NumDoctors
FROM Doctors
GROUP BY Specialty
ORDER BY NumDoctors DESC;