CREATE OR REPLACE PROCEDURE get_blood_counts  
(  
    p_blood_bank_id IN NUMBER,    
    p_blood_type    IN VARCHAR2  
)    
IS  
    v_total_count   NUMBER := 0;    
    v_camp_id       NUMBER;    
    v_organization  VARCHAR2(100);    
    v_blood_count   NUMBER; 
 
    CURSOR camp_cursor IS   
        SELECT Camp_ID, Organization    
        FROM Blood_Donation_Camp    
        WHERE Organization IN (SELECT Organization FROM Organization_Blood_Bank WHERE Blood_Bank_ID = p_blood_bank_id);   
 
    CURSOR blood_count_cursor (c_camp_id NUMBER, c_organization VARCHAR2, c_blood_type VARCHAR2) IS   
        SELECT COUNT(*) AS blood_count   
        FROM Blood    
        WHERE Camp_ID = c_camp_id    
          AND Organization = c_organization    
          AND Blood_Type = c_blood_type;   
 
BEGIN    
 
    FOR rec IN camp_cursor LOOP    
        v_camp_id := rec.Camp_ID;    
        v_organization := rec.Organization;   
           
        OPEN blood_count_cursor(v_camp_id, v_organization, p_blood_type);   
        FETCH blood_count_cursor INTO v_blood_count;  
 
        v_total_count := v_total_count + v_blood_count;  
               
        IF blood_count_cursor%NOTFOUND THEN   
            DBMS_OUTPUT.PUT_LINE('No data found for blood type ' || p_blood_type || ' in camp ID ' || v_camp_id || ' and organization ' || v_organization);   
        ELSIF blood_count_cursor%ROWCOUNT > 1 THEN   
            DBMS_OUTPUT.PUT_LINE('Error: Multiple rows found for blood type ' || p_blood_type || ' in camp ID ' || v_camp_id || ' and organization ' || v_organization);   
        ELSE   
            DBMS_OUTPUT.PUT_LINE('Total blood count for blood type ' || p_blood_type || ': ' || v_total_count);    
        END IF;   
             
        CLOSE blood_count_cursor;   
             
    END LOOP;    
 
EXCEPTION  
    WHEN NO_DATA_FOUND THEN   
        DBMS_OUTPUT.PUT_LINE('No data found for blood type ' || p_blood_type || ' in camp ID ' || v_camp_id || ' and organization ' || v_organization);   
    WHEN TOO_MANY_ROWS THEN   
        DBMS_OUTPUT.PUT_LINE('Error: Multiple rows found for blood type ' || p_blood_type || ' in camp ID ' || v_camp_id || ' and organization ' || v_organization);    
    WHEN OTHERS THEN   
        DBMS_OUTPUT.PUT_LINE('An error occurred while processing camps.');  
 
END;
