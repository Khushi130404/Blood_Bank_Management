
CREATE TABLE Check_ups ( 
    Vol_ID INT PRIMARY KEY, 
    First_Name VARCHAR(50), 
    Middle_Name VARCHAR(50), 
    Last_Name VARCHAR(50), 
    Weight DECIMAL(5,2), 
    DOB DATE 
);

CREATE TABLE Blood_Bank ( 
    Blood_Bank_ID NUMBER PRIMARY KEY, 
    BB_Name VARCHAR2(50), 
    BB_Location VARCHAR2(100), 
    Capacity NUMBER 
);

CREATE TABLE Bank_Blood_Type ( 
    Blood_Bank_ID NUMBER, 
    Blood_Type VARCHAR2(5), 
    Cost NUMBER(10,2), 
    PRIMARY KEY (Blood_Bank_ID, Blood_Type), 
    CONSTRAINT fk_blood_bank_2 FOREIGN KEY (Blood_Bank_ID) REFERENCES Blood_Bank(Blood_Bank_ID) 
);

CREATE TABLE Organization_Blood_Bank (
    Organization VARCHAR2(100) PRIMARY KEY,
    Blood_Bank_ID NUMBER,
    CONSTRAINT fk_Blood_Bank FOREIGN KEY (Blood_Bank_ID) REFERENCES Blood_Bank(Blood_Bank_ID)
);

CREATE TABLE Blood_Donation_Camp (
    Organization VARCHAR2(100),
    Camp_ID NUMBER,
    Location VARCHAR2(100),
    Start_Date DATE,
    End_Date DATE,
    PRIMARY KEY (Organization, Camp_ID),
    CONSTRAINT fk_Org_Blood_Donation_Camp FOREIGN KEY (Organization) REFERENCES Organization_Blood_Bank(Organization)
);;

CREATE TABLE Camp_Contact ( 
    Organization VARCHAR2(100), 
    Camp_ID NUMBER, 
    Contact_info VARCHAR2(100), 
    PRIMARY KEY (Organization, Camp_ID, Contact_info), 
    CONSTRAINT fk_blood_donation_camp_3 FOREIGN KEY (Organization, Camp_ID) REFERENCES Blood_Donation_Camp(Organization, Camp_ID) 
);

CREATE TABLE Nurse ( 
    Nurse_ID NUMBER PRIMARY KEY, 
    First_Name VARCHAR2(50), 
    Middle_Name VARCHAR2(50), 
    Last_Name VARCHAR2(50), 
    DOB DATE, 
    Organization VARCHAR2(100), 
    Camp_ID NUMBER, 
    CONSTRAINT fk_blood_donation_camp FOREIGN KEY (Organization,Camp_ID) REFERENCES Blood_Donation_Camp(Organization,Camp_ID) 
);

CREATE TABLE Nurse_Contact ( 
    Nurse_ID NUMBER, 
    Contact_info VARCHAR2(100), 
    PRIMARY KEY (Nurse_ID, Contact_info), 
    CONSTRAINT fk_nurse_contact FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID) 
);

CREATE TABLE Donor ( 
    Donor_ID NUMBER PRIMARY KEY, 
    First_Name VARCHAR2(50), 
    Middle_Name VARCHAR2(50), 
    Last_Name VARCHAR2(50), 
    DOB DATE, 
    Nurse_ID NUMBER, 
    CONSTRAINT fk_nurse FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID) 
);

CREATE TABLE Donor_Contact ( 
    Donor_ID NUMBER, 
    Contact_info VARCHAR2(100), 
    PRIMARY KEY (Donor_ID, Contact_info), 
    CONSTRAINT fk_donor_contact FOREIGN KEY (Donor_ID) REFERENCES Donor(Donor_ID) 
);

CREATE TABLE Blood (
    Donor_ID NUMBER,
    Organization VARCHAR2(100),
    Camp_ID NUMBER,
    Blood_Type VARCHAR2(5),
    Haemoglobin NUMBER(5,2),
    Red_blood_cells NUMBER(5,2),
    White_blood_cells NUMBER(5,2),
    Platelets NUMBER(5,2),
    Plazma NUMBER(5,2),
    Donation_Date DATE,
    PRIMARY KEY (Donor_ID),
    CONSTRAINT fk_donor FOREIGN KEY (Donor_ID) REFERENCES Donor(Donor_ID),
    CONSTRAINT fk_blood_donation_camp_2 FOREIGN KEY (Organization, Camp_ID) REFERENCES Blood_Donation_Camp(Organization, Camp_ID)
);;

CREATE TABLE Hospital ( 
    Hospital_ID NUMBER PRIMARY KEY, 
    Hospital_Name VARCHAR2(50), 
    Hos_Address VARCHAR2(100) 
);

CREATE TABLE Hospital_Contact ( 
    Hospital_ID NUMBER, 
    Contact_Info VARCHAR2(100), 
    PRIMARY KEY (Hospital_ID, Contact_Info), 
    CONSTRAINT fk_hospital_contact FOREIGN KEY (Hospital_ID) REFERENCES Hospital(Hospital_ID) 
);

CREATE TABLE Hospital_Email ( 
    Hospital_ID NUMBER, 
    Hos_Email VARCHAR2(100), 
    PRIMARY KEY (Hospital_ID, Hos_Email), 
    CONSTRAINT fk_hospital_email FOREIGN KEY (Hospital_ID) REFERENCES Hospital(Hospital_ID) 
);

CREATE TABLE Orders ( 
    Blood_Bank_ID NUMBER, 
    Hospital_ID NUMBER, 
    Issue_Date DATE, 
    Blood_Type VARCHAR2(25), 
    Blood_Quantity NUMBER, 
    PRIMARY KEY (Blood_Bank_ID, Hospital_ID), 
    CONSTRAINT fk_blood_bank_3 FOREIGN KEY (Blood_Bank_ID) REFERENCES Blood_Bank(Blood_Bank_ID), 
    CONSTRAINT fk_hospital FOREIGN KEY (Hospital_ID) REFERENCES Hospital(Hospital_ID) 
);

CREATE TABLE Patient ( 
    Hospital_ID NUMBER, 
    Patient_ID NUMBER, 
    First_Name VARCHAR2(50), 
    Middle_Name VARCHAR2(50), 
    Last_Name VARCHAR2(50), 
    Sex CHAR(1), 
    Blood_Type VARCHAR2(5), 
    Date_Admitted DATE, 
    Date_Discharged DATE, 
    PRIMARY KEY (Hospital_ID, Patient_ID), 
    CONSTRAINT fk_hospital_2 FOREIGN KEY (Hospital_ID) REFERENCES Hospital(Hospital_ID) 
);

CREATE TABLE Patient_Contact ( 
    Hospital_ID NUMBER, 
    Patient_ID NUMBER, 
    Contact_Info VARCHAR2(100), 
    PRIMARY KEY (Hospital_ID, Patient_ID, Contact_Info), 
    CONSTRAINT fk_patient_contact FOREIGN KEY (Hospital_ID, Patient_ID) REFERENCES Patient(Hospital_ID, Patient_ID) 
);
