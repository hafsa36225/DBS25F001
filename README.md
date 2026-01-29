# DBS25F001
Course Code: CMPE-341 
Course Name: DataBase Management 
Project Name: "Hospital Management System"
# Group Members 
Hafsa 
Aiman 
# Project 
This project is based on Hospital Management System that manages patients, doctors, appointments, billing, and reports.
# Core Modules
Patient Management  
Doctor Management  
Appointment Scheduling  
Department Management  
Billing & Payments  
Medical Records  
User Authentication  
Reports Generation 
# DOMAIN CLASSES (10)
   # Patient
PatientID(PK)
Name
CNIC
Gender
Date of birth (DOB)
# PatientContact 
ContactID(PK)
PatientID(FK)
Phone
Address
# Department
DepartmentID (PK)
DepartmentName
Description
# Speciality
specialityID (PK)
Specility Name
# Doctor
DoctorID(PK)
Name
CNIC
Gender
Phone
DOB
SpecialtyID (FK)
DepartmentID (FK)
# Appointment
AppointmentID(PK)
PatientID(FK)
DoctorID(FK)
AppointmentDate
AppointmentTime
AppointmentStatus
# MedicalRecord
RecordID(PK)
PatientID(FK)
DoctorID(FK)
Diagnosis
Prescription
RecordDate
# Medicine 
Medicine ID(PK)
MedicineName
# Prescription
PrescriptionID
RecordID
MedicineName
MedicinePeriod 
# PrescriptionItem
PrescriptionID (FK)
MedicineID (FK)
Dosage: Dosage information
Composite PK(PrescriptionID,MedicineID)
# Room 
RoomID (PK)
RoomType: Type of room (General, Semi-Private, Private)
DailyCharges
# Admission 
AdmissionID (PK)
PatientID (FK)
RoomID (FK)
AdmitDate
DischargeDate
# Billing
BillID(PK)
PatientID(FK)
BillDate
# Bill Item
BillItemID (PK)
BillID (FK)
Description
Amount
# Payment
PaymentID(PK)
BillID(FK)
Amount
PaymentMethod
PaymentStatus
PaymentDate
# ROLE 
RoleID(PK)
RoleName
# User
UserID
Username
Password
RoleID(FK)
   # Report
ReportID(PK)
ReportType
GeneratedDate
# SOFTWARE CLASSES (5)  
(Logic Handling)
   # PatientService
AddPatient()
UpdatePatient()
DeletePatient()
GetPatient()
   # DoctorService
Manage doctor records
   # AppointmentService
ScheduleAppointment()
CancelAppointment()
   # BillingService
GenerateBill()
CalculateTotal()
   # ReportService
GeneratePDFReport()
FilterReports()
# Start 
# Patient
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    CNIC VARCHAR(15) NOT NULL UNIQUE,
    Gender ENUM('Male','Female') NOT NULL,
    DOB DATE NOT NULL
);
<img width="512" height="292" alt="image" src="https://github.com/user-attachments/assets/b61fb102-4180-4bd1-805f-088113d47b38" />
# PatientContact
CREATE TABLE PatientContact (
    ContactID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

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
# Doctor Department
CREATE TABLE DoctorDepartment (
    DoctorDeptID INT AUTO_INCREMENT PRIMARY KEY,
    DoctorID INT NOT NULL,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);
<img width="755" height="227" alt="image" src="https://github.com/user-attachments/assets/316c3c2d-e3fb-456f-82ad-ebca37accfae" />
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
# Department 
CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(100)
);
<img width="563" height="184" alt="image" src="https://github.com/user-attachments/assets/648669f5-a5ec-4d26-8a37-dcd338355448" />
# User
CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Role ENUM('Admin','Doctor','Receptionist') NOT NULL
);
<img width="652" height="197" alt="image" src="https://github.com/user-attachments/assets/b30f1d46-6dac-4c2e-917a-8329baa01333" />
# Medical Records 
CREATE TABLE MedicalRecord (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    Diagnosis TEXT,
    RecordDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);
<img width="626" height="279" alt="image" src="https://github.com/user-attachments/assets/e2df9945-2811-41ce-b15d-ac75d18b5294" />
# Precription
CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    RecordID INT NOT NULL,
    MedicineName VARCHAR(100),
    Dosage VARCHAR(50),
    FOREIGN KEY (RecordID) REFERENCES MedicalRecord(RecordID)
);
<img width="677" height="226" alt="image" src="https://github.com/user-attachments/assets/4f37f8f1-c63f-4f29-ad0a-e089a1552e6d" />
# Billing
CREATE TABLE Billing (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    TotalAmount DECIMAL(10,2),
    BillDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
<img width="677" height="218" alt="image" src="https://github.com/user-attachments/assets/2385fd88-ea8d-4311-a077-4793b99f6488" />
# Payment 
CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BillID INT NOT NULL,
    PaymentMethod ENUM('Cash','Card','Online'),
    PaymentStatus ENUM('Paid','Pending'),
    PaymentDate DATE,
    FOREIGN KEY (BillID) REFERENCES Billing(BillID)
);
<img width="601" height="255" alt="image" src="https://github.com/user-attachments/assets/6ff8e4c8-b0b7-44d8-9fdf-d0779b21ed23" />
# Report 
CREATE TABLE Report (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    ReportName VARCHAR(50)
);
<img width="492" height="133" alt="image" src="https://github.com/user-attachments/assets/0b7424d9-5df8-43c3-b094-0a5b2e8ac39d" />
# Rooms
CREATE TABLE Room (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    RoomType VARCHAR(50
);
<img width="473" height="144" alt="image" src="https://github.com/user-attachments/assets/8f120726-0944-49e5-b4b1-bcb0e8aba42c" />
# Patient Admit 
CREATE TABLE Admit (
    AdmitID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    RoomID INT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);
<img width="689" height="234" alt="image" src="https://github.com/user-attachments/assets/f8374744-31a0-47c8-8e75-36b1010d90d1" />
# FeedBack \ Complain 
CREATE TABLE Feedback (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    Comments VARCHAR(200),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
<img width="619" height="211" alt="image" src="https://github.com/user-attachments/assets/46c55277-264e-46dc-b2a6-f83893f0144b" />
# System Login
CREATE TABLE LoginLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    LoginTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);
<img width="567" height="195" alt="image" src="https://github.com/user-attachments/assets/41a33b2a-968f-4e9a-8b62-5de263a4fe59" />
# ERD Daigram 
![ERD 2](https://github.com/user-attachments/assets/5a0abaa1-d77c-4680-bb00-e92780966d1d)
# Key Relationships Explaination:
#  Core Medical Entities
· Patient ↔ MedicalRecord (1:N) - One patient can have multiple medical records
· Patient ↔ Appointment (1:N) - One patient can have multiple appointments
· Doctor ↔ Appointment (1:N) - One doctor can have multiple appointments
· Doctor ↔ MedicalRecord (1:N) - One doctor can create multiple medical records
#   Prescription System
 MedicalRecord → Prescription (1:1) - Each medical record has one prescription
· Prescription → PrescriptionItem (1:N) - One prescription contains multiple medicines
· Medicine → PrescriptionItem (1:N) - One medicine can appear in multiple prescriptions
# Department & Specialty:
· Department → Doctor (1:N) - One department can have multiple doctors
· Specialty → Doctor (1:N) - One specialty can have multiple doctors
# Billing & Payment System:
· Patient → Billing (1:N) - One patient can have multiple bills
· Billing → BillItem (1:N) - One bill contains multiple items
· Billing → Payment (1:1) - Each bill has one payment record
# Admission & Room Management:
· Patient → Admission (1:N) - One patient can have multiple admissions
· Room → Admission (1:N) - One room can have multiple admissions over time
· Admission is linked to Billing through PatientID
# User Management:
· Role → User (1:N) - One role can be assigned to multiple users
# Cardinality Notations:
· 1:1 - One-to-One relationship
· 1:N - One-to-Many relationship
· N:1 - Many-to-One relationship
· (PK) - Primary Key
· (FK) - Foreign Key
# Important Constraints:
1. Patient and Doctor have unique CNIC constraints
2. Department and Specialty names are unique
3. PrescriptionItem has a composite primary key (PrescriptionID + MedicineID)
4. Status fields use ENUM types for data validation
5. All foreign key relationships maintain referential integrity
# This ERD represents a normalized database design suitable for a hospital management system with proper relationships between entities




















