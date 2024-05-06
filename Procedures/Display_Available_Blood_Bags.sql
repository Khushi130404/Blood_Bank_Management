CREATE OR REPLACE PROCEDURE display_available_blood_bags(
    p_Blood_Type VARCHAR2,
    p_Result OUT SYS_REFCURSOR
) IS
    l_Blood_Bank_ID Bank_Blood_Type.Blood_Bank_ID%TYPE;
    l_Blood_Bank_Name VARCHAR2(100);
    l_Blood_Type Bank_Blood_Type.Blood_Type%TYPE;
    l_Available_Bags NUMBER;
BEGIN
    OPEN p_Result FOR
    SELECT bb.Blood_Bank_ID, bb.BB_Name AS Blood_Bank_Name,
           bbt.Blood_Type, COUNT(*) AS Available_Bags
    FROM Bank_Blood_Type bbt
    JOIN Blood_Bank bb ON bbt.Blood_Bank_ID = bb.Blood_Bank_ID
    WHERE bbt.Blood_Type = p_Blood_Type
    GROUP BY bb.Blood_Bank_ID, bb.BB_Name, bbt.Blood_Type;

    DBMS_OUTPUT.PUT_LINE('Available blood bags for blood type ' || p_Blood_Type || ':');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
    LOOP
        FETCH p_Result INTO
            l_Blood_Bank_ID,
            l_Blood_Bank_Name,
            l_Blood_Type,
            l_Available_Bags;
        EXIT WHEN p_Result%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Blood Bank ID: ' || l_Blood_Bank_ID || ', Blood Bank Name: ' || l_Blood_Bank_Name || ', Blood Type: ' || l_Blood_Type || ', Available Bags: ' || l_Available_Bags);
    END LOOP;

    CLOSE p_Result;
END display_available_blood_bags;


