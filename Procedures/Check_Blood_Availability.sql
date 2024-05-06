CREATE OR REPLACE PROCEDURE Check_Blood_Availability 
( blood_type IN VARCHAR2 ) 
IS 
 
    CURSOR blood_bank_cursor IS 
        SELECT bb.BB_Name 
        FROM Blood_Bank bb 
        JOIN Bank_Blood_Type bbt ON bb.Blood_Bank_ID = bbt.Blood_Bank_ID 
        WHERE bbt.Blood_Type = blood_type; 
 
    blood_bank_name Blood_Bank.BB_Name%TYPE; 
    blood_found BOOLEAN := FALSE;  
 
BEGIN 
 
    FOR blood_bank_rec IN blood_bank_cursor LOOP 
        DBMS_OUTPUT.PUT_LINE('Blood bank with blood type ' || blood_type || ' is available: ' || blood_bank_rec.BB_Name); 
        blood_found := TRUE;  
    END LOOP; 
 
EXCEPTION 
 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('No blood banks found for blood type ' || blood_type || '.'); 
    WHEN TOO_MANY_ROWS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: Multiple blood banks found for blood type ' || blood_type || '.'); 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An error occurred while checking blood availability.'); 
 
END;
