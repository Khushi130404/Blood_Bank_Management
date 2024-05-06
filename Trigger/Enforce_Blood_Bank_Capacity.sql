CREATE OR REPLACE TRIGGER enforce_blood_bank_capacity  
BEFORE INSERT ON Orders  
FOR EACH ROW  
DECLARE  
    v_current_count NUMBER;  
    v_capacity NUMBER; 
BEGIN  
    SELECT Capacity  
    INTO v_capacity  
    FROM Blood_Bank  
    WHERE Blood_Bank_ID = :NEW.Blood_Bank_ID;  
     
    SELECT COUNT(*)  
    INTO v_current_count  
    FROM Orders  
    WHERE Blood_Bank_ID = :NEW.Blood_Bank_ID;  
  
    IF v_current_count >= v_capacity THEN  
        RAISE_APPLICATION_ERROR(-20001, 'Blood bank capacity exceeded. Cannot insert more orders.');  
    END IF;  
END; 
