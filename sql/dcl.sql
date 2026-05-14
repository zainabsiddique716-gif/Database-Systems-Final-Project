CREATE USER traffic_officer IDENTIFIED BY officer123;
CREATE USER citizen_user IDENTIFIED BY citizen123;


-- Grant basic connection privileges
GRANT CONNECT, RESOURCE TO traffic_officer;
GRANT CONNECT, RESOURCE TO citizen_user;
GRANT CONNECT, RESOURCE, DBA TO admin_user;

-- Role 1: Traffic Officer privileges
GRANT SELECT ON vehicle TO traffic_officer;
GRANT SELECT ON location TO traffic_officer;
GRANT INSERT, UPDATE ON challan TO traffic_officer;

-- Role 2: Citizen User privileges (restricted)
GRANT SELECT ON payment TO citizen_user;

 Test the privileges 
-- CONNECT traffic_officer/officer123;
-- SELECT * FROM admin_user.traffic_officer; -- This should fail

COMMIT;
```

---
