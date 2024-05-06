CREATE OR REPLACE TRIGGER prevent_donor_deletion 
BEFORE DELETE ON Donor 
FOR EACH ROW 
DECLARE 
    v_blood_count NUMBER; 
BEGIN 
    SELECT COUNT(*) 
    INTO v_blood_count 
    FROM Blood 
    WHERE Donor_ID = :OLD.Donor_ID; 
 
    IF v_blood_count > 0 THEN 
        RAISE_APPLICATION_ERROR(-20002, 'Cannot delete Donor record as there are associated Blood records.'); 
    END IF; 
END;
