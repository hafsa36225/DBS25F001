Create Database Hospital_Management_System;
Use Hospital_Management_System;
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    CNIC VARCHAR(15) NOT NULL UNIQUE,
    Gender ENUM('Male','Female') NOT NULL,
    DOB DATE NOT NULL
);
CREATE TABLE PatientContact (
    ContactID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(100)
);
CREATE TABLE Specialty (
    SpecialtyID INT AUTO_INCREMENT PRIMARY KEY,
    SpecialtyName VARCHAR(50) UNIQUE
);
CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    CNIC VARCHAR(15) NOT NULL UNIQUE,
    Gender ENUM('Male','Female') NOT NULL,
    Phone VARCHAR(15),
    DOB DATE NOT NULL,
    SpecialtyID INT,
    DepartmentID INT,
    FOREIGN KEY (SpecialtyID) REFERENCES Specialty(SpecialtyID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);
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
CREATE TABLE MedicalRecord (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    Diagnosis TEXT,
    RecordDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);
CREATE TABLE Medicine (
    MedicineID INT AUTO_INCREMENT PRIMARY KEY,
    MedicineName VARCHAR(100) UNIQUE
);
CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    RecordID INT NOT NULL,
    FOREIGN KEY (RecordID) REFERENCES MedicalRecord(RecordID)
);
CREATE TABLE PrescriptionItem (
    PrescriptionID INT,
    MedicineID INT,
    Dosage VARCHAR(50),
    PRIMARY KEY (PrescriptionID, MedicineID),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID),
    FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID)
);
CREATE TABLE Room (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    RoomType VARCHAR(50),
    DailyCharges DECIMAL(10,2)
);
CREATE TABLE Admission (
    AdmissionID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    RoomID INT,
    AdmitDate DATE,
    DischargeDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);
CREATE TABLE Billing (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    BillDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
CREATE TABLE BillItem (
    BillItemID INT AUTO_INCREMENT PRIMARY KEY,
    BillID INT,
    Description VARCHAR(100),
    Amount DECIMAL(10,2),
    FOREIGN KEY (BillID) REFERENCES Billing(BillID)
);
CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BillID INT NOT NULL,
    Amount DECIMAL(10,2),
    PaymentMethod ENUM('Cash','Card','Online'),
    PaymentStatus ENUM('Paid','Pending'),
    PaymentDate DATE,
    FOREIGN KEY (BillID) REFERENCES Billing(BillID)
);
CREATE TABLE Role (
    RoleID INT AUTO_INCREMENT PRIMARY KEY,
    RoleName VARCHAR(50) UNIQUE
);
CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    RoleID INT,
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID)
);
CREATE TABLE Report (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    ReportType VARCHAR(50),
    GeneratedDate DATE
);
INSERT INTO Patient (Name, CNIC, Gender, DOB) VALUES
('Ali Raza', '35202-1234567-1', 'Male', '1998-05-12'),
('Ayesha Khan', '42101-7654321-2', 'Female', '2000-08-20'),
('Muhammad Usman', '61101-1122334-3', 'Male', '1995-01-15');
INSERT INTO PatientContact (PatientID, Phone, Address) VALUES
(1, '0301-1234567', 'Model Town, Lahore'),
(2, '0333-9876543', 'Gulshan-e-Iqbal, Karachi'),
(3, '0312-5558899', 'Satellite Town, Rawalpindi');
INSERT INTO Department (DepartmentName, Description) VALUES
('Cardiology', 'Heart related treatments'),
('Neurology', 'Brain and nerves'),
('Orthopedics', 'Bones and joints');
INSERT INTO Specialty (SpecialtyName) VALUES
('Heart Specialist'),
('Neuro Surgeon'),
('Orthopedic Surgeon');
INSERT INTO Doctor (Name, CNIC, Gender, Phone, DOB, SpecialtyID, DepartmentID) VALUES
('Dr. Ahmed Ali', '35201-4455667-1', 'Male', '0300-1112233', '1980-03-10', 1, 1),
('Dr. Sana Iqbal', '42101-9988776-2', 'Female', '0321-4445566', '1985-07-25', 2, 2),
('Dr. Hamza Sheikh', '61101-2233445-3', 'Male', '0345-7778899', '1978-11-05', 3, 3);
INSERT INTO Appointment (PatientID, DoctorID, AppointmentDate, AppointmentTime, Status) VALUES
(1, 1, '2024-02-01', '10:00:00', 'Scheduled'),
(2, 2, '2024-02-01', '11:30:00', 'Completed'),
(3, 3, '2024-02-02', '09:00:00', 'Scheduled');
INSERT INTO MedicalRecord (PatientID, DoctorID, Diagnosis, RecordDate) VALUES
(1, 1, 'High Blood Pressure', '2024-02-01'),
(2, 2, 'Migraine', '2024-02-01'),
(3, 3, 'Fractured Arm', '2024-02-02');
INSERT INTO Medicine (MedicineName) VALUES
('Panadol'),
('Brufen'),
('Disprin'),
('Augmentin');
INSERT INTO Prescription (RecordID) VALUES
(1),
(2),
(3);
INSERT INTO PrescriptionItem (PrescriptionID, MedicineID, Dosage) VALUES
(1, 1, '2 times daily'),
(1, 2, '1 time daily'),
(2, 3, 'Once daily'),
(3, 4, '2 times daily');
INSERT INTO Room (RoomType, DailyCharges) VALUES
('General Ward', 3000),
('Semi Private', 5000),
('Private', 8000);
INSERT INTO Admission (PatientID, RoomID, AdmitDate, DischargeDate) VALUES
(1, 2, '2024-02-01', '2024-02-05'),
(3, 3, '2024-02-02', NULL);
INSERT INTO Billing (PatientID, BillDate) VALUES
(1, '2024-02-05'),
(2, '2024-02-01'),
(3, '2024-02-03');
INSERT INTO BillItem (BillID, Description, Amount) VALUES
(1, 'Room Charges', 20000),
(1, 'Medicines', 3500),
(2, 'Consultation Fee', 2000),
(3, 'X-Ray', 5000),
(3, 'Medicines', 1500);
INSERT INTO Payment (BillID, Amount, PaymentMethod, PaymentStatus, PaymentDate) VALUES
(1, 23500, 'Cash', 'Paid', '2024-02-05'),
(2, 2000, 'Card', 'Paid', '2024-02-01'),
(3, 6500, 'Online', 'Pending', '2024-02-03');
INSERT INTO Role (RoleName) VALUES
('Admin'),
('Doctor'),
('Receptionist');
INSERT INTO User (Username, Password, RoleID) VALUES
('admin', 'admin123', 1),
('dr_ahmed', 'doc123', 2),
('reception1', 'rec123', 3);
INSERT INTO Report (ReportType, GeneratedDate) VALUES
('Daily Appointments', '2024-02-01'),
('Monthly Revenue', '2024-02-01'),
('Patient History', '2024-02-02');
