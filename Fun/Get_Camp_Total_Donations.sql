CREATE OR REPLACE FUNCTION get_camp_total_donations(
    p_camp_id IN Blood.Camp_ID%TYPE,
    p_organization IN Blood.Organization%TYPE
)
RETURN NUMBER
IS
    v_total_donations NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total_donations
    FROM Blood
    WHERE Camp_ID = p_camp_id
      AND Organization = p_organization;

    RETURN v_total_donations;
END;

