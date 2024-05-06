CREATE OR REPLACE PACKAGE Hospital_Package AS

  FUNCTION calculate_avg_length_of_stay(p_Hospital_ID NUMBER) RETURN NUMBER;

  FUNCTION get_admitted_patient_count(p_Hospital_ID NUMBER, p_Start_Date DATE, p_End_Date DATE) RETURN NUMBER;

  PROCEDURE discharge_patient(p_Hospital_ID NUMBER, p_Patient_ID NUMBER, p_Discharge_Date DATE);

END Hospital_Package;



CREATE OR REPLACE PACKAGE BODY Hospital_Package AS

  FUNCTION calculate_avg_length_of_stay(p_Hospital_ID NUMBER) RETURN NUMBER IS
    v_Total_Length NUMBER := 0;
    v_Total_Patients NUMBER := 0;
  BEGIN
    SELECT SUM(Date_Discharged - Date_Admitted)
    INTO v_Total_Length
    FROM Patient
    WHERE Hospital_ID = p_Hospital_ID
    AND Date_Discharged IS NOT NULL;

    SELECT COUNT(*)
    INTO v_Total_Patients
    FROM Patient
    WHERE Hospital_ID = p_Hospital_ID
    AND Date_Discharged IS NOT NULL;

    IF v_Total_Patients > 0 THEN
      RETURN v_Total_Length / v_Total_Patients;
    ELSE
      RETURN 0;
    END IF;
  END calculate_avg_length_of_stay;

  FUNCTION get_admitted_patient_count(p_Hospital_ID NUMBER, p_Start_Date DATE, p_End_Date DATE) RETURN NUMBER IS
    v_Patient_Count NUMBER := 0;
  BEGIN
    SELECT COUNT(*)
    INTO v_Patient_Count
    FROM Patient
    WHERE Hospital_ID = p_Hospital_ID
    AND Date_Admitted BETWEEN p_Start_Date AND p_End_Date;

    RETURN v_Patient_Count;
  END get_admitted_patient_count;

  PROCEDURE discharge_patient(p_Hospital_ID NUMBER, p_Patient_ID NUMBER, p_Discharge_Date DATE) IS
  BEGIN
    UPDATE Patient
    SET Date_Discharged = p_Discharge_Date
    WHERE Hospital_ID = p_Hospital_ID
    AND Patient_ID = p_Patient_ID;
  END discharge_patient;

END Hospital_Package;

