-- VIEW 1: Summary/Reporting View
CREATE OR REPLACE VIEW vw_daily_challan_summary AS
SELECT 
    TO_CHAR(issue_date, 'YYYY-MM-DD') as challan_date,
    COUNT(challan_id) as total_challans,
    SUM(fine_amount) as total_fine_amount,
    SUM(CASE WHEN status = 'PAID' THEN 1 ELSE 0 END) as paid_count,
    SUM(CASE WHEN status = 'PENDING' THEN 1 ELSE 0 END) as pending_count
FROM challan
GROUP BY TO_CHAR(issue_date, 'YYYY-MM-DD')
ORDER BY challan_date DESC;

-- VIEW 2: Role-specific view (for Citizen)
CREATE OR REPLACE VIEW vw_citizen_challan_info AS
SELECT 
    cz.citizen_id,
    cz.full_name,
    cz.cnic,
    v.plate_number,
    ch.challan_id,
    ch.issue_date,
    ch.due_date,
    ch.fine_amount,
    ch.status,
    vt.violation_name
FROM citizen cz
JOIN citizen_vehicle cv ON cz.citizen_id = cv.citizen_id
JOIN vehicle v ON cv.vehicle_id = v.vehicle_id
JOIN challan ch ON v.vehicle_id = ch.vehicle_id
JOIN violation_type vt ON ch.violation_code = vt.violation_code;

-- VIEW 3: Complex view (3+ tables for dashboard)
CREATE OR REPLACE VIEW vw_officer_performance AS
SELECT 
    o.officer_id,
    o.full_name as officer_name,
    o.rank_name,
    COUNT(ch.challan_id) as total_challans,
    SUM(CASE WHEN ch.status = 'PAID' THEN ch.total_amount ELSE 0 END) as revenue_generated,
    AVG(ch.fine_amount) as avg_fine_amount,
    COUNT(DISTINCT ch.vehicle_id) as unique_vehicles
FROM traffic_officer o
LEFT JOIN challan ch ON o.officer_id = ch.officer_id
GROUP BY o.officer_id, o.full_name, o.rank_name
ORDER BY revenue_generated DESC;

COMMIT;
```

