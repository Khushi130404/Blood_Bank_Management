CREATE OR REPLACE TRIGGER check_donor_eligibility   
BEFORE INSERT ON Blood   
FOR EACH ROW   
DECLARE   
    v_last_donation_date DATE;   
BEGIN   
    SELECT MAX(Donation_Date)   
    INTO v_last_donation_date   
    FROM Blood   
    WHERE Donor_ID = :NEW.Donor_ID;   
     
    IF v_last_donation_date IS NOT NULL AND v_last_donation_date > SYSDATE - 56 THEN    
        RAISE_APPLICATION_ERROR(-20001, 'Donor is not eligible to donate blood within 56 days of their last donation.');   
    END IF;   
END;
