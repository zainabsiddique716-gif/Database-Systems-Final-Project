
-- 1. SIMPLE PL/SQL BLOCK

DECLARE
    total_challans NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO total_challans
    FROM challan;

    DBMS_OUTPUT.PUT_LINE('Total Challans: ' || total_challans);
END;
/

-- 2. VARIABLE + SELECT INTO

DECLARE
    c_name citizen.full_name%TYPE;
BEGIN
    SELECT full_name
    INTO c_name
    FROM citizen
    WHERE citizen_id = 1001;

    DBMS_OUTPUT.PUT_LINE('Citizen Name: ' || c_name);
END;
/

-- 3. IF-ELSE CONDITION

DECLARE
    c_status challan.status%TYPE;
BEGIN
    SELECT status
    INTO c_status
    FROM challan
    WHERE challan_id = 5001;

    IF c_status = 'PAID' THEN
        DBMS_OUTPUT.PUT_LINE('Challan already paid');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Payment pending');
    END IF;
END;
/

-- 4. LOOP EXAMPLE

DECLARE
    counter NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('Vehicle Record: ' || counter);
        counter := counter + 1;

        EXIT WHEN counter > 5;
    END LOOP;
END;
/

-- 5. CURSOR EXAMPLE

DECLARE
    CURSOR pending_cursor IS
        SELECT challan_id, fine_amount
        FROM challan
        WHERE status = 'PENDING';

    c_id challan.challan_id%TYPE;
    c_fine challan.fine_amount%TYPE;

BEGIN
    OPEN pending_cursor;

    LOOP
        FETCH pending_cursor INTO c_id, c_fine;
        EXIT WHEN pending_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Challan ID: ' || c_id ||
            ' Fine: ' || c_fine
        );
    END LOOP;

    CLOSE pending_cursor;
END;
/
-- 6. PROCEDURE
-- Insert new location

CREATE OR REPLACE PROCEDURE add_location (
    p_city   VARCHAR2,
    p_sector VARCHAR2,
    p_road   VARCHAR2
)
IS
BEGIN
    INSERT INTO location (
        location_id,
        city_name,
        sector_name,
        road_name
    )
    VALUES (
        seq_location_id.NEXTVAL,
        p_city,
        p_sector,
        p_road
    );

    DBMS_OUTPUT.PUT_LINE('Location Added Successfully');

    COMMIT;
END;
/

-- Run Procedure
BEGIN
    add_location('Lahore', 'Model Town', 'Link Road');
END;
/

-- 7. FUNCTION

CREATE OR REPLACE FUNCTION get_total_fine (
    p_challan_id NUMBER
)
RETURN NUMBER
IS
    total_fine NUMBER;
BEGIN
    SELECT total_amount
    INTO total_fine
    FROM challan
    WHERE challan_id = p_challan_id;

    RETURN total_fine;
END;
/

-- Run Function
DECLARE
    fine NUMBER;
BEGIN
    fine := get_total_fine(5001);

    DBMS_OUTPUT.PUT_LINE('Total Fine: ' || fine);
END;
/
-- 8. EXCEPTION HANDLING

DECLARE
    c_name citizen.full_name%TYPE;
BEGIN
    SELECT full_name
    INTO c_name
    FROM citizen
    WHERE citizen_id = 9999;

    DBMS_OUTPUT.PUT_LINE(c_name);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Citizen not found');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Some error occurred');
END;
/

-- 9. UPDATE USING PL/SQL

BEGIN
    UPDATE challan
    SET status = 'PAID'
    WHERE challan_id = 5003;

    DBMS_OUTPUT.PUT_LINE('Status Updated');

    COMMIT;
END;
/
-- 10. DELETE USING PL/SQL

BEGIN
    DELETE FROM payment
    WHERE payment_id = 6001;

    DBMS_OUTPUT.PUT_LINE('Payment Deleted');

    COMMIT;
END;
/




CREATE OR REPLACE FUNCTION fn_get_total_outstanding_fines(
    p_citizen_id NUMBER
) RETURN NUMBER IS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(c.fine_amount), 0)
    INTO v_total
    FROM challan c
    JOIN citizen_vehicle cv ON c.vehicle_id = cv.vehicle_id
    WHERE cv.citizen_id = p_citizen_id
      AND c.status = 'PENDING';

    RETURN v_total;
END;
/


SELECT fn_get_total_outstanding_fines(1) FROM DUAL;



CREATE OR REPLACE FUNCTION fn_is_vehicle_blacklisted(
    p_vehicle_id NUMBER
) RETURN VARCHAR2 IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM challan
    WHERE vehicle_id = p_vehicle_id
      AND status = 'PENDING';

    IF v_count >= 3 THEN
        RETURN 'BLACKLISTED';
    ELSE
        RETURN 'CLEAR';
    END IF;
END;
/

SELECT fn_is_vehicle_blacklisted(10) FROM DUAL;




CREATE OR REPLACE PROCEDURE proc_issue_violation_simple(
    p_vehicle_id     IN NUMBER,
    p_officer_id     IN NUMBER,
    p_violation_code IN NUMBER,
    p_challan_id     OUT NUMBER
) IS
    v_fine NUMBER;
BEGIN
    SELECT fine_amount
    INTO v_fine
    FROM violation_type
    WHERE violation_code = p_violation_code;

    INSERT INTO challan(
        challan_id,
        vehicle_id,
        officer_id,
        violation_code,
        issue_date,
        fine_amount,
        status
    )
    VALUES(
        challan_seq.NEXTVAL,
        p_vehicle_id,
        p_officer_id,
        p_violation_code,
        SYSDATE,
        v_fine,
        'PENDING'
    )
    RETURNING challan_id INTO p_challan_id;
END;
/




CREATE OR REPLACE PROCEDURE proc_register_vehicle(
    p_vehicle_id      OUT NUMBER,
    p_citizen_id      IN NUMBER,
    p_plate_number    IN VARCHAR2,
    p_vehicle_type    IN VARCHAR2
) IS
BEGIN
    INSERT INTO vehicle(vehicle_id, plate_number, vehicle_type)
    VALUES (vehicle_seq.NEXTVAL, p_plate_number, p_vehicle_type)
    RETURNING vehicle_id INTO p_vehicle_id;

    INSERT INTO citizen_vehicle(citizen_id, vehicle_id, is_primary)
    VALUES (p_citizen_id, p_vehicle_id, 'Y');
END;
/







