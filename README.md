# DBS25F001
Course Code: CMPE-341 
Course Name: DataBase Management 
Project Name: "Hospital Management System"
# Group Members 
Hafsa 
Aiman 
# Project 
This project is based on Hospital Management System that manages patients, doctors, appointments, billing, and reports.
# Start 
# Patient
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    CNIC VARCHAR(15) NOT NULL UNIQUE,
    Gender ENUM('Male','Female') NOT NULL,
    DOB DATE NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255)
    );
<img width="512" height="292" alt="image" src="https://github.com/user-attachments/assets/b61fb102-4180-4bd1-805f-088113d47b38" />
# Doctor 
CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    CNIC VARCHAR(15) NOT NULL UNIQUE,
    Gender ENUM('Male','Female') NOT NULL,
    Phone VARCHAR(15),
    Specialty VARCHAR(50),
    DOB DATE NOT NULL
);
<img width="516" height="297" alt="image" src="https://github.com/user-attachments/assets/2ced56b0-f4f0-4a6f-a20d-ebccc272a289" />
# Patient Appointment 
CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME,
    Status ENUM('Scheduled','Completed','Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);
<img width="812" height="320" alt="image" src="https://github.com/user-attachments/assets/67e7f1e2-c463-44be-8be4-76dc9e9f8f49" />





