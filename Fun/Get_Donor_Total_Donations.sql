CREATE OR REPLACE FUNCTION get_donor_total_donations(
    p_donor_id IN Donor.Donor_ID%TYPE
)
RETURN NUMBER
IS
    v_total_donations NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total_donations
    FROM Blood
    WHERE Donor_ID = p_donor_id;

    RETURN v_total_donations;
END;
