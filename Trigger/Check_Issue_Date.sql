CREATE OR REPLACE TRIGGER check_issue_date 
BEFORE INSERT ON Orders 
FOR EACH ROW 
BEGIN 
    IF :NEW.Issue_Date > SYSDATE THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Issue date cannot be in the future'); 
    END IF; 
END;
