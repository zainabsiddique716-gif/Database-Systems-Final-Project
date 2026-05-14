

-- QUERY 1:
SELECT challan_id, vehicle_id, issue_date, fine_amount, status
FROM challan
WHERE status = 'PENDING' 
  AND issue_date < SYSDATE - 15;
  
-- QUERY 2: 
SELECT o.officer_id, o.full_name, SUM(c.total_amount) as total_collected
FROM traffic_officer o
JOIN challan c ON o.officer_id = c.officer_id
WHERE c.status = 'PAID'
GROUP BY o.officer_id, o.full_name
ORDER BY total_collected DESC;

-- QUERY 3: 
SELECT o.officer_id, o.full_name, COUNT(c.challan_id) as challan_count
FROM traffic_officer o
JOIN challan c ON o.officer_id = c.officer_id
GROUP BY o.officer_id, o.full_name
HAVING COUNT(c.challan_id) > 10;

-- QUERY 4:
SELECT c.challan_id, cz.full_name as citizen_name, v.plate_number, 
       c.issue_date, c.fine_amount, c.status
FROM challan c
JOIN vehicle v ON c.vehicle_id = v.vehicle_id
JOIN citizen_vehicle cv ON v.vehicle_id = cv.vehicle_id
JOIN citizen cz ON cv.citizen_id = cz.citizen_id
WHERE cv.is_primary = 'Y';

-- QUERY 5: 
SELECT o.officer_id, o.full_name, COUNT(c.challan_id) as total_challans
FROM traffic_officer o
LEFT JOIN challan c ON o.officer_id = c.officer_id
GROUP BY o.officer_id, o.full_name
ORDER BY total_challans DESC;

-- QUERY 6:
SELECT violation_code, violation_name, fine_amount
FROM violation_type
WHERE fine_amount > (SELECT AVG(fine_amount) FROM violation_type)
ORDER BY fine_amount DESC;

-- QUERY 7: 
SELECT c1.challan_id, c1.officer_id, c1.fine_amount
FROM challan c1
WHERE c1.fine_amount > (
    SELECT AVG(c2.fine_amount)
    FROM challan c2
    WHERE c2.officer_id = c1.officer_id
)
ORDER BY c1.officer_id, c1.fine_amount DESC;

-- QUERY 8:
SELECT 
    ch.challan_id,
    cz.full_name as citizen_name,
    v.plate_number,
    vt.violation_name,
    ch.issue_date,
    ch.fine_amount,
    ch.status,
    p.payment_date,
    p.amount_paid,
    p.payment_method
FROM challan ch
JOIN vehicle v ON ch.vehicle_id = v.vehicle_id
JOIN citizen_vehicle cv ON v.vehicle_id = cv.vehicle_id
JOIN citizen cz ON cv.citizen_id = cz.citizen_id
JOIN violation_type vt ON ch.violation_code = vt.violation_code
LEFT JOIN payment p ON ch.challan_id = p.challan_id
WHERE cv.is_primary = 'Y';

-- QUERY 9:
SELECT 
    TO_CHAR(payment_date, 'YYYY-MM') as month,
    COUNT(p.payment_id) as payment_count,
    SUM(amount_paid) as total_revenue
FROM payment p
WHERE payment_date >= ADD_MONTHS(SYSDATE, -6)
GROUP BY TO_CHAR(payment_date, 'YYYY-MM')
ORDER BY month DESC;

-- QUERY 10:
SELECT 
    l.city_name,
    l.sector_name,
    l.road_name,
    COUNT(ch.challan_id) as violation_count
FROM location l
JOIN challan ch ON l.location_id = ch.location_id
GROUP BY l.city_name, l.sector_name, l.road_name
ORDER BY violation_count DESC;

