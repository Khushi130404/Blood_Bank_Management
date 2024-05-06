CREATE OR REPLACE TRIGGER eligibility  
BEFORE INSERT ON Donor 
FOR EACH ROW 
DECLARE  
    donor_weight DECIMAL(5,2); 
    donor_date_of_birth DATE; 
    donor_age INT; 
BEGIN 
    SELECT Weight INTO donor_weight FROM Check_ups WHERE Vol_ID = :new.Donor_ID; 
    SELECT DOB INTO donor_date_of_birth FROM Check_ups WHERE Vol_ID = :new.Donor_Id; 
 
    donor_age := FindAge(donor_date_of_birth); 
 
    IF donor_age >= 18 AND donor_age <= 65 AND donor_weight >= 50 THEN 
        NULL; 
    ELSE 
        RAISE_APPLICATION_ERROR(-20000, 'Not eligible to donate blood'); 
    END IF; 
END;
