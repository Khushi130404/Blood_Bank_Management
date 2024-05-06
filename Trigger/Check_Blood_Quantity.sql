CREATE OR REPLACE TRIGGER check_blood_quantity  
BEFORE INSERT OR UPDATE ON Orders  
FOR EACH ROW  
DECLARE  
    v_available_quantity NUMBER;  
BEGIN  
    SELECT COUNT(*) 
    INTO v_available_quantity 
    FROM Blood b 
    JOIN Blood_Bank bb ON b.Organization = bb.BB_Name 
    WHERE b.Blood_Type = :NEW.Blood_Type 
    AND bb.Blood_Bank_ID = :NEW.Blood_Bank_ID; 
 
    IF v_available_quantity = 0 OR v_available_quantity < :NEW.Blood_Quantity THEN  
        RAISE_APPLICATION_ERROR(-20001, 'Requested quantity exceeds available blood quantity for the given blood type in the Blood_Bank.');  
    END IF;  
END; 
