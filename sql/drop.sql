-- ===================================================
-- Smart City Traffic & Challan System
-- File: 10_drop_all.sql
-- Purpose: Drop all database objects for clean re-run
-- Authors: Zainab Siddique (24f-0824), Malaika Imdad (24f-0776)
-- Date: May 2026
-- ===================================================


-- ===================================================
-- DROP PROCEDURES
-- ===================================================
BEGIN
   EXECUTE IMMEDIATE 'DROP PROCEDURE proc_process_payment';
   EXECUTE IMMEDIATE 'DROP PROCEDURE proc_generate_challan_for_violation';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
-- ===================================================
-- DROP FUNCTIONS
-- ===================================================
BEGIN
   EXECUTE IMMEDIATE 'DROP FUNCTION fn_check_license_status';
   EXECUTE IMMEDIATE 'DROP FUNCTION fn_get_total_deduction_points';
   EXECUTE IMMEDIATE 'DROP FUNCTION fn_calculate_challan_amount';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
-- ===================================================
-- DROP TRIGGERS
-- ===================================================
BEGIN
   EXECUTE IMMEDIATE 'DROP TRIGGER trg_update_challan_on_payment';
   EXECUTE IMMEDIATE 'DROP TRIGGER trg_verify_vehicle_registration';
   EXECUTE IMMEDIATE 'DROP TRIGGER trg_prevent_duplicate_violations';
   EXECUTE IMMEDIATE 'DROP TRIGGER trg_generate_challan_number';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
-- ===================================================
-- DROP VIEWS
-- ===================================================
BEGIN
   EXECUTE IMMEDIATE 'DROP VIEW v_monthly_traffic_statistics';
   EXECUTE IMMEDIATE 'DROP VIEW v_pending_payments_followup';
   EXECUTE IMMEDIATE 'DROP VIEW v_camera_performance_metrics';
   EXECUTE IMMEDIATE 'DROP VIEW v_officer_challan_tracking';
   EXECUTE IMMEDIATE 'DROP VIEW v_violation_challan_payment_trail';
   EXECUTE IMMEDIATE 'DROP VIEW v_vehicle_owner_details';
   EXECUTE IMMEDIATE 'DROP VIEW v_city_violation_summary';
   EXECUTE IMMEDIATE 'DROP VIEW v_user_specific_violations';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
-- ===================================================
-- DROP TABLES
-- ===================================================
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE challan_payments CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE challans CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE traffic_violations CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE traffic_cameras CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE vehicle_registrations CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE vehicle_owners CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE traffic_rules CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE traffic_officers CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE traffic_zones CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE payment_methods CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE violation_types CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE vehicle_types CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE cities CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE audit_log CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
-- ===================================================
-- DROP SEQUENCES
-- ===================================================
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_payment_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_challan_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_violation_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_registration_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_owner_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_camera_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_officer_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_zone_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_rule_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_payment_method_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_violation_type_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_vehicle_type_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_city_id';
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_audit_id';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
-- ===================================================
-- DROP USERS
-- ===================================================
BEGIN
   EXECUTE IMMEDIATE 'DROP USER traffic_admin CASCADE';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP USER traffic_officer CASCADE';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP USER vehicle_owner CASCADE';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP USER billing_officer CASCADE';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
-- ===================================================
-- FINAL MESSAGE
-- ===================================================
COMMIT;
