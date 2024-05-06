CREATE OR REPLACE FUNCTION Duration_Of_Camp(  
    Organization IN Blood_Donation_Camp.Organization%TYPE,  
    Camp_ID IN Blood_Donation_Camp.Camp_ID%TYPE  
)  
RETURN NUMBER 
IS  
    days NUMBER(4);  
BEGIN  
    SELECT End_Date - Start_Date  
    INTO days  
    FROM Blood_Donation_Camp  
    WHERE Organization = Duration_Of_Camp.Organization  
    AND Camp_ID = Duration_Of_Camp.Camp_ID;  
      
    RETURN days;  
EXCEPTION  
    WHEN NO_DATA_FOUND THEN  
        RETURN NULL;  
    WHEN OTHERS THEN  
        RETURN NULL;  
END;
