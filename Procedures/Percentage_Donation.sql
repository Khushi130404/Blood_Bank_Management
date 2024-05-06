CREATE OR REPLACE PROCEDURE percentage_donation 
IS 
    total_participation INT; 
    total_donation INT; 
    donation_percentage NUMBER;
BEGIN 
    
    SELECT COUNT(*) INTO total_participation FROM check_ups; 
 
    SELECT COUNT(*) INTO total_donation 
    FROM donor d 
    JOIN blood b ON b.donor_id = d.donor_id; 
    
    donation_percentage := (total_donation / total_participation) * 100; 

    DBMS_OUTPUT.PUT_LINE('Percentage of donations out of total participation is: ' || donation_percentage); 
END;
