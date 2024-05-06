CREATE OR REPLACE PACKAGE Blood_Bank_Package AS

  FUNCTION calculate_available_blood_bags(p_Blood_Bank_ID IN NUMBER) RETURN NUMBER;

  PROCEDURE print_max_blood_banks(p_Blood_Type VARCHAR2);

  CURSOR blood_bank_cursor(p_Blood_Type VARCHAR2) IS
    SELECT b.BB_Name AS Blood_Bank_Name
    FROM Blood_Bank b
    JOIN Bank_Blood_Type bb ON b.Blood_Bank_ID = bb.Blood_Bank_ID
    WHERE bb.Blood_Type = p_Blood_Type
    AND bb.Cost = (SELECT MAX(Cost) FROM Bank_Blood_Type WHERE Blood_Type = p_Blood_Type);

END Blood_Bank_Package;


CREATE OR REPLACE PACKAGE BODY Blood_Bank_Package AS

  FUNCTION calculate_available_blood_bags(p_Blood_Bank_ID IN NUMBER) RETURN NUMBER IS
    v_Available_Bags NUMBER;
  BEGIN
    SELECT COUNT(*)
    INTO v_Available_Bags
    FROM Bank_Blood_Type
    WHERE Blood_Bank_ID = p_Blood_Bank_ID
    GROUP BY Blood_Bank_ID;

    RETURN v_Available_Bags;
  END calculate_available_blood_bags;

  PROCEDURE print_max_blood_banks(p_Blood_Type VARCHAR2) IS
  BEGIN
    FOR r IN blood_bank_cursor(p_Blood_Type) LOOP
      DBMS_OUTPUT.PUT_LINE('Blood Bank with Max Quantity of ' || p_Blood_Type || ': ' || r.Blood_Bank_Name);
    END LOOP;
  END print_max_blood_banks;

END Blood_Bank_Package;










