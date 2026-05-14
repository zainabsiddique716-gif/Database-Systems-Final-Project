
-- Realistic Pakistani Traffic Data

-- 1. VIOLATION_TYPE (Master data)
INSERT INTO violation_type VALUES ('V001', 'Over Speeding', 1500, 3, 'MEDIUM');
INSERT INTO violation_type VALUES ('V002', 'Signal Jumping', 2000, 4, 'HIGH');
INSERT INTO violation_type VALUES ('V003', 'Wrong Lane Driving', 1000, 2, 'MEDIUM');
INSERT INTO violation_type VALUES ('V004', 'No Helmet', 500, 1, 'LOW');
INSERT INTO violation_type VALUES ('V005', 'Driving Without License', 3000, 5, 'CRITICAL');
INSERT INTO violation_type VALUES ('V006', 'Drunk Driving', 5000, 10, 'CRITICAL');
INSERT INTO violation_type VALUES ('V007', 'Illegal Parking', 800, 1, 'LOW');
INSERT INTO violation_type VALUES ('V008', 'Using Phone While Driving', 1200, 2, 'MEDIUM');

-- 2. LOCATION (5 locations)
INSERT INTO location VALUES (seq_location_id.NEXTVAL, 'Chiniot', 'Sector A', 'Railway Road', 'CAM001');
INSERT INTO location VALUES (seq_location_id.NEXTVAL, 'Chiniot', 'Sector B', 'Grain Market', 'CAM002');
INSERT INTO location VALUES (seq_location_id.NEXTVAL, 'Faisalabad', 'Samanabad', 'Satiana Road', 'CAM003');
INSERT INTO location VALUES (seq_location_id.NEXTVAL, 'Faisalabad', 'Gulberg', 'Main Boulevard', 'CAM004');
INSERT INTO location VALUES (seq_location_id.NEXTVAL, 'Chiniot', 'Sector C', 'Chenab Nagar', NULL);

-- 3. TRAFFIC_OFFICER (5 officers)
INSERT INTO traffic_officer VALUES (seq_officer_id.NEXTVAL, 'B1234', 'Ahmed Raza', 'Sub Inspector', 'Morning', TO_DATE('2020-01-15', 'YYYY-MM-DD'), '03001234567');
INSERT INTO traffic_officer VALUES (seq_officer_id.NEXTVAL, 'B1235', 'Fareed Ahmad', 'Assistant Sub Inspector', 'Evening', TO_DATE('2021-03-10', 'YYYY-MM-DD'), '03001234568');
INSERT INTO traffic_officer VALUES (seq_officer_id.NEXTVAL, 'B1236', 'Saima Bibi', 'Lady Constable', 'Morning', TO_DATE('2022-06-20', 'YYYY-MM-DD'), '03001234569');
INSERT INTO traffic_officer VALUES (seq_officer_id.NEXTVAL, 'B1237', 'Usman Ghani', 'Head Constable', 'Night', TO_DATE('2019-11-01', 'YYYY-MM-DD'), '03001234570');
INSERT INTO traffic_officer VALUES (seq_officer_id.NEXTVAL, 'B1238', 'Nadia Khan', 'Sub Inspector', 'Morning', TO_DATE('2020-08-25', 'YYYY-MM-DD'), '03001234571');

-- 4. CITIZEN (15 citizens)
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-1234567-8', 'Ali Hassan', 'Mohammad Hassan', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'L123456', '03011111111', 'ali@gmail.com', 'House 1, Chiniot', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-2345678-9', 'Sara Ahmed', 'Ahmed Ali', TO_DATE('1995-08-20', 'YYYY-MM-DD'), 'L123457', '03012222222', 'sara@yahoo.com', 'House 2, Faisalabad', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-3456789-0', 'Bilal Aslam', 'Aslam Khan', TO_DATE('1988-12-10', 'YYYY-MM-DD'), 'L123458', '03013333333', 'bilal@hotmail.com', 'Street 5, Chiniot', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-4567890-1', 'Fatima Zafar', 'Zafar Ali', TO_DATE('2000-03-25', 'YYYY-MM-DD'), 'L123459', '03014444444', 'fatima@gmail.com', 'Apartment 3, Faisalabad', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-5678901-2', 'Hamza Tariq', 'Tariq Mehmood', TO_DATE('1992-07-18', 'YYYY-MM-DD'), 'L123460', '03015555555', 'hamza@outlook.com', 'House 10, Chiniot', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-6789012-3', 'Ayesha Arif', 'Arif Mahmood', TO_DATE('1998-11-30', 'YYYY-MM-DD'), 'L123461', '03016666666', 'ayesha@gmail.com', 'Street 8, Faisalabad', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-7890123-4', 'Usman Chaudhry', 'Chaudhry Latif', TO_DATE('1985-01-05', 'YYYY-MM-DD'), 'L123462', '03017777777', 'usman@yahoo.com', 'House 25, Chiniot', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-8901234-5', 'Zainab Malik', 'Malik Riaz', TO_DATE('1996-09-12', 'YYYY-MM-DD'), 'L123463', '03018888888', 'zainab@gmail.com', 'Apartment 7, Faisalabad', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-9012345-6', 'Omar Farooq', 'Farooq Ahmed', TO_DATE('1993-04-22', 'YYYY-MM-DD'), 'L123464', '03019999999', 'omar@gmail.com', 'House 3, Chiniot', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-0123456-7', 'Hira Naeem', 'Naeem Akhtar', TO_DATE('1997-06-15', 'YYYY-MM-DD'), 'L123465', '03101111111', 'hira@hotmail.com', 'Street 12, Faisalabad', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-1234501-2', 'Kamran Ashraf', 'Ashraf Ali', TO_DATE('1980-10-08', 'YYYY-MM-DD'), 'L123466', '03102222222', 'kamran@gmail.com', 'House 15, Chiniot', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-2345602-3', 'Nadia Mushtaq', 'Mushtaq Ahmad', TO_DATE('2001-02-28', 'YYYY-MM-DD'), 'L123467', '03103333333', 'nadia@yahoo.com', 'Apartment 2, Faisalabad', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-3456703-4', 'Shahid Iqbal', 'Iqbal Hussain', TO_DATE('1975-07-19', 'YYYY-MM-DD'), 'L123468', '03104444444', 'shahid@gmail.com', 'House 7, Chiniot', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-4567804-5', 'Rabia Batool', 'Mohammad Yousaf', TO_DATE('1999-12-01', 'YYYY-MM-DD'), 'L123469', '03105555555', 'rabia@gmail.com', 'Street 20, Faisalabad', SYSDATE);
INSERT INTO citizen VALUES (seq_citizen_id.NEXTVAL, '61101-5678905-6', 'Tariq Mehmood', 'Mehmood Ali', TO_DATE('1983-03-11', 'YYYY-MM-DD'), 'L123470', '03106666666', 'tariq@outlook.com', 'House 30, Chiniot', SYSDATE);

-- 5. VEHICLE (20 vehicles)
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-1234', 'Car', 2020, 'ENG001', TO_DATE('2020-05-10', 'YYYY-MM-DD'), TO_DATE('2025-05-09', 'YYYY-MM-DD'), 'White', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-5678', 'Motorcycle', 2021, 'ENG002', TO_DATE('2021-03-15', 'YYYY-MM-DD'), TO_DATE('2026-03-14', 'YYYY-MM-DD'), 'Black', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-9012', 'Car', 2019, 'ENG003', TO_DATE('2019-08-20', 'YYYY-MM-DD'), TO_DATE('2024-08-19', 'YYYY-MM-DD'), 'Silver', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-3456', 'Car', 2022, 'ENG004', TO_DATE('2022-01-10', 'YYYY-MM-DD'), TO_DATE('2027-01-09', 'YYYY-MM-DD'), 'Blue', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-7890', 'Motorcycle', 2020, 'ENG005', TO_DATE('2020-11-01', 'YYYY-MM-DD'), TO_DATE('2025-10-31', 'YYYY-MM-DD'), 'Red', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-1111', 'Truck', 2018, 'ENG006', TO_DATE('2018-07-15', 'YYYY-MM-DD'), TO_DATE('2023-07-14', 'YYYY-MM-DD'), 'White', 'EXPIRED');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-2222', 'Car', 2021, 'ENG007', TO_DATE('2021-09-05', 'YYYY-MM-DD'), TO_DATE('2026-09-04', 'YYYY-MM-DD'), 'Green', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-3333', 'Motorcycle', 2022, 'ENG008', TO_DATE('2022-02-20', 'YYYY-MM-DD'), TO_DATE('2027-02-19', 'YYYY-MM-DD'), 'Blue', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-4444', 'Car', 2017, 'ENG009', TO_DATE('2017-10-10', 'YYYY-MM-DD'), TO_DATE('2022-10-09', 'YYYY-MM-DD'), 'Black', 'EXPIRED');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-5555', 'Van', 2020, 'ENG010', TO_DATE('2020-04-25', 'YYYY-MM-DD'), TO_DATE('2025-04-24', 'YYYY-MM-DD'), 'White', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-6666', 'Car', 2023, 'ENG011', TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('2028-01-14', 'YYYY-MM-DD'), 'Red', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-7777', 'Motorcycle', 2021, 'ENG012', TO_DATE('2021-06-30', 'YYYY-MM-DD'), TO_DATE('2026-06-29', 'YYYY-MM-DD'), 'Black', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-8888', 'Car', 2019, 'ENG013', TO_DATE('2019-12-01', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'Silver', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-9999', 'Auto Rickshaw', 2020, 'ENG014', TO_DATE('2020-03-10', 'YYYY-MM-DD'), TO_DATE('2025-03-09', 'YYYY-MM-DD'), 'Yellow', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEB-0000', 'Car', 2022, 'ENG015', TO_DATE('2022-08-05', 'YYYY-MM-DD'), TO_DATE('2027-08-04', 'YYYY-MM-DD'), 'White', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEC-1234', 'Car', 2021, 'ENG016', TO_DATE('2021-05-20', 'YYYY-MM-DD'), TO_DATE('2026-05-19', 'YYYY-MM-DD'), 'Gray', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEC-5678', 'Motorcycle', 2020, 'ENG017', TO_DATE('2020-09-15', 'YYYY-MM-DD'), TO_DATE('2025-09-14', 'YYYY-MM-DD'), 'Red', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEC-9012', 'Car', 2018, 'ENG018', TO_DATE('2018-11-25', 'YYYY-MM-DD'), TO_DATE('2023-11-24', 'YYYY-MM-DD'), 'Blue', 'EXPIRED');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEC-3456', 'Car', 2023, 'ENG019', TO_DATE('2023-02-14', 'YYYY-MM-DD'), TO_DATE('2028-02-13', 'YYYY-MM-DD'), 'Black', 'ACTIVE');
INSERT INTO vehicle VALUES (seq_vehicle_id.NEXTVAL, 'LEC-7890', 'Motorcycle', 2022, 'ENG020', TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2027-03-31', 'YYYY-MM-DD'), 'White', 'ACTIVE');

-- 6. CITIZEN_VEHICLE (Junction table - 25 records)
INSERT INTO citizen_vehicle VALUES (1001, 2001, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1002, 2002, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1003, 2003, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1004, 2004, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1005, 2005, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1006, 2006, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1007, 2007, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1008, 2008, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1009, 2009, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1010, 2010, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1001, 2011, SYSDATE, 'N');
INSERT INTO citizen_vehicle VALUES (1002, 2012, SYSDATE, 'N');
INSERT INTO citizen_vehicle VALUES (1011, 2013, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1012, 2014, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1013, 2015, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1014, 2016, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1015, 2017, SYSDATE, 'Y');
INSERT INTO citizen_vehicle VALUES (1003, 2018, SYSDATE, 'N');
INSERT INTO citizen_vehicle VALUES (1005, 2019, SYSDATE, 'N');
INSERT INTO citizen_vehicle VALUES (1007, 2020, SYSDATE, 'N');
INSERT INTO citizen_vehicle VALUES (1009, 2011, SYSDATE, 'N');
INSERT INTO citizen_vehicle VALUES (1011, 2012, SYSDATE, 'N');
INSERT INTO citizen_vehicle VALUES (1013, 2013, SYSDATE, 'N');
INSERT INTO citizen_vehicle VALUES (1002, 2015, SYSDATE, 'N');
INSERT INTO citizen_vehicle VALUES (1004, 2017, SYSDATE, 'N');

-- 7. CHALLAN (40 challans - main transaction records)
-- Challan 1-10
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2001, 3001, 'V001', 4001, TO_DATE('2026-03-01', 'YYYY-MM-DD'), TO_DATE('2026-03-16', 'YYYY-MM-DD'), 1500, 0, 1500, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2002, 3002, 'V002', 4002, TO_DATE('2026-03-05', 'YYYY-MM-DD'), TO_DATE('2026-03-20', 'YYYY-MM-DD'), 2000, 0, 2000, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2003, 3003, 'V003', 4003, TO_DATE('2026-03-10', 'YYYY-MM-DD'), TO_DATE('2026-03-25', 'YYYY-MM-DD'), 1000, 0, 1000, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2004, 3004, 'V005', 4004, TO_DATE('2026-03-12', 'YYYY-MM-DD'), TO_DATE('2026-03-27', 'YYYY-MM-DD'), 3000, 0, 3000, 'PENDING', 'No license found');
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2005, 3005, 'V001', 4005, TO_DATE('2026-03-15', 'YYYY-MM-DD'), TO_DATE('2026-03-30', 'YYYY-MM-DD'), 1500, 0, 1500, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2006, 3001, 'V006', 4001, TO_DATE('2026-03-18', 'YYYY-MM-DD'), TO_DATE('2026-04-02', 'YYYY-MM-DD'), 5000, 0, 5000, 'DISPUTED', 'Case registered');
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2007, 3002, 'V007', 4002, TO_DATE('2026-03-20', 'YYYY-MM-DD'), TO_DATE('2026-04-04', 'YYYY-MM-DD'), 800, 0, 800, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2008, 3003, 'V008', 4003, TO_DATE('2026-03-22', 'YYYY-MM-DD'), TO_DATE('2026-04-06', 'YYYY-MM-DD'), 1200, 0, 1200, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2009, 3004, 'V004', 4004, TO_DATE('2026-03-25', 'YYYY-MM-DD'), TO_DATE('2026-04-09', 'YYYY-MM-DD'), 500, 0, 500, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2010, 3005, 'V002', 4005, TO_DATE('2026-03-28', 'YYYY-MM-DD'), TO_DATE('2026-04-12', 'YYYY-MM-DD'), 2000, 0, 2000, 'PAID', NULL);

-- Challan 11-20 (older - for late fee demonstration)
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2011, 3001, 'V001', 4001, TO_DATE('2026-02-01', 'YYYY-MM-DD'), TO_DATE('2026-02-16', 'YYYY-MM-DD'), 1500, 150, 1650, 'PAID', 'Paid with late fee');
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2012, 3002, 'V003', 4002, TO_DATE('2026-02-05', 'YYYY-MM-DD'), TO_DATE('2026-02-20', 'YYYY-MM-DD'), 1000, 100, 1100, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2013, 3003, 'V005', 4003, TO_DATE('2026-02-10', 'YYYY-MM-DD'), TO_DATE('2026-02-25', 'YYYY-MM-DD'), 3000, 300, 3300, 'PENDING', 'Unpaid challan');
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2014, 3004, 'V007', 4004, TO_DATE('2026-02-15', 'YYYY-MM-DD'), TO_DATE('2026-03-02', 'YYYY-MM-DD'), 800, 80, 880, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2015, 3005, 'V001', 4005, TO_DATE('2026-02-20', 'YYYY-MM-DD'), TO_DATE('2026-03-07', 'YYYY-MM-DD'), 1500, 150, 1650, 'DISPUTED', NULL);

-- Challan 21-30 (April 2026 - recent)
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2013, 3001, 'V002', 4001, TO_DATE('2026-04-01', 'YYYY-MM-DD'), TO_DATE('2026-04-16', 'YYYY-MM-DD'), 2000, 0, 2000, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2014, 3002, 'V004', 4002, TO_DATE('2026-04-02', 'YYYY-MM-DD'), TO_DATE('2026-04-17', 'YYYY-MM-DD'), 500, 0, 500, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2015, 3003, 'V008', 4003, TO_DATE('2026-04-03', 'YYYY-MM-DD'), TO_DATE('2026-04-18', 'YYYY-MM-DD'), 1200, 0, 1200, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2016, 3004, 'V001', 4004, TO_DATE('2026-04-05', 'YYYY-MM-DD'), TO_DATE('2026-04-20', 'YYYY-MM-DD'), 1500, 0, 1500, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2017, 3005, 'V003', 4005, TO_DATE('2026-04-07', 'YYYY-MM-DD'), TO_DATE('2026-04-22', 'YYYY-MM-DD'), 1000, 0, 1000, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2018, 3001, 'V006', 4001, TO_DATE('2026-04-08', 'YYYY-MM-DD'), TO_DATE('2026-04-23', 'YYYY-MM-DD'), 5000, 0, 5000, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2019, 3002, 'V002', 4002, TO_DATE('2026-04-10', 'YYYY-MM-DD'), TO_DATE('2026-04-25', 'YYYY-MM-DD'), 2000, 0, 2000, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2020, 3003, 'V007', 4003, TO_DATE('2026-04-11', 'YYYY-MM-DD'), TO_DATE('2026-04-26', 'YYYY-MM-DD'), 800, 0, 800, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2001, 3004, 'V001', 4004, TO_DATE('2026-04-12', 'YYYY-MM-DD'), TO_DATE('2026-04-27', 'YYYY-MM-DD'), 1500, 0, 1500, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2002, 3005, 'V005', 4005, TO_DATE('2026-04-13', 'YYYY-MM-DD'), TO_DATE('2026-04-28', 'YYYY-MM-DD'), 3000, 0, 3000, 'PENDING', NULL);

-- Challan 31-40
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2003, 3001, 'V008', 4001, TO_DATE('2026-04-14', 'YYYY-MM-DD'), TO_DATE('2026-04-29', 'YYYY-MM-DD'), 1200, 0, 1200, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2004, 3002, 'V002', 4002, TO_DATE('2026-04-15', 'YYYY-MM-DD'), TO_DATE('2026-04-30', 'YYYY-MM-DD'), 2000, 0, 2000, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2005, 3003, 'V004', 4003, TO_DATE('2026-04-16', 'YYYY-MM-DD'), TO_DATE('2026-05-01', 'YYYY-MM-DD'), 500, 0, 500, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2006, 3004, 'V001', 4004, TO_DATE('2026-04-17', 'YYYY-MM-DD'), TO_DATE('2026-05-02', 'YYYY-MM-DD'), 1500, 0, 1500, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2007, 3005, 'V003', 4005, TO_DATE('2026-04-18', 'YYYY-MM-DD'), TO_DATE('2026-05-03', 'YYYY-MM-DD'), 1000, 0, 1000, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2008, 3001, 'V006', 4001, TO_DATE('2026-04-19', 'YYYY-MM-DD'), TO_DATE('2026-05-04', 'YYYY-MM-DD'), 5000, 0, 5000, 'DISPUTED', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2009, 3002, 'V002', 4002, TO_DATE('2026-04-20', 'YYYY-MM-DD'), TO_DATE('2026-05-05', 'YYYY-MM-DD'), 2000, 0, 2000, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2010, 3003, 'V007', 4003, TO_DATE('2026-04-21', 'YYYY-MM-DD'), TO_DATE('2026-05-06', 'YYYY-MM-DD'), 800, 0, 800, 'PENDING', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2011, 3004, 'V001', 4004, TO_DATE('2026-04-22', 'YYYY-MM-DD'), TO_DATE('2026-05-07', 'YYYY-MM-DD'), 1500, 0, 1500, 'PAID', NULL);
INSERT INTO challan VALUES (seq_challan_id.NEXTVAL, 2012, 3005, 'V005', 4005, TO_DATE('2026-04-23', 'YYYY-MM-DD'), TO_DATE('2026-05-08', 'YYYY-MM-DD'), 3000, 0, 3000, 'PENDING', NULL);

-- 8. PAYMENT (30 payments)
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5001, TO_DATE('2026-03-10', 'YYYY-MM-DD'), 1500, 'CARD', 'TXN001', 'RCP001');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5002, TO_DATE('2026-03-12', 'YYYY-MM-DD'), 2000, 'CASH', 'TXN002', 'RCP002');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5005, TO_DATE('2026-03-20', 'YYYY-MM-DD'), 1500, 'JAZZCASH', 'TXN003', 'RCP003');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5008, TO_DATE('2026-03-28', 'YYYY-MM-DD'), 1200, 'CARD', 'TXN004', 'RCP004');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5010, TO_DATE('2026-04-05', 'YYYY-MM-DD'), 2000, 'EASYPEASA', 'TXN005', 'RCP005');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5011, TO_DATE('2026-02-20', 'YYYY-MM-DD'), 1650, 'CASH', 'TXN006', 'RCP006');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5012, TO_DATE('2026-02-22', 'YYYY-MM-DD'), 1100, 'CARD', 'TXN007', 'RCP007');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5015, TO_DATE('2026-03-15', 'YYYY-MM-DD'), 1650, 'BANK_TRANSFER', 'TXN008', 'RCP008');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5017, TO_DATE('2026-04-08', 'YYYY-MM-DD'), 1200, 'JAZZCASH', 'TXN009', 'RCP009');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5019, TO_DATE('2026-04-18', 'YYYY-MM-DD'), 2000, 'CARD', 'TXN010', 'RCP010');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5020, TO_DATE('2026-04-20', 'YYYY-MM-DD'), 800, 'CASH', 'TXN011', 'RCP011');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5021, TO_DATE('2026-04-22', 'YYYY-MM-DD'), 1500, 'EASYPEASA', 'TXN012', 'RCP012');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5022, TO_DATE('2026-04-25', 'YYYY-MM-DD'), 3000, 'CARD', 'TXN013', 'RCP013');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5023, TO_DATE('2026-04-28', 'YYYY-MM-DD'), 1200, 'JAZZCASH', 'TXN014', 'RCP014');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5024, TO_DATE('2026-05-01', 'YYYY-MM-DD'), 2000, 'CARD', 'TXN015', 'RCP015');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5025, TO_DATE('2026-05-02', 'YYYY-MM-DD'), 500, 'CASH', 'TXN016', 'RCP016');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5026, TO_DATE('2026-05-05', 'YYYY-MM-DD'), 1500, 'BANK_TRANSFER', 'TXN017', 'RCP017');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5027, TO_DATE('2026-05-06', 'YYYY-MM-DD'), 1000, 'CARD', 'TXN018', 'RCP018');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5029, TO_DATE('2026-04-29', 'YYYY-MM-DD'), 2000, 'JAZZCASH', 'TXN019', 'RCP019');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5030, TO_DATE('2026-04-30', 'YYYY-MM-DD'), 800, 'CARD', 'TXN020', 'RCP020');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5031, TO_DATE('2026-05-07', 'YYYY-MM-DD'), 1500, 'EASYPEASA', 'TXN021', 'RCP021');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5032, TO_DATE('2026-05-08', 'YYYY-MM-DD'), 3000, 'CASH', 'TXN022', 'RCP022');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5033, TO_DATE('2026-05-09', 'YYYY-MM-DD'), 1200, 'CARD', 'TXN023', 'RCP023');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5035, TO_DATE('2026-05-10', 'YYYY-MM-DD'), 2000, 'JAZZCASH', 'TXN024', 'RCP024');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5036, TO_DATE('2026-05-11', 'YYYY-MM-DD'), 500, 'CARD', 'TXN025', 'RCP025');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5037, TO_DATE('2026-05-12', 'YYYY-MM-DD'), 1500, 'EASYPEASA', 'TXN026', 'RCP026');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5038, TO_DATE('2026-05-13', 'YYYY-MM-DD'), 1000, 'CASH', 'TXN027', 'RCP027');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5040, TO_DATE('2026-05-14', 'YYYY-MM-DD'), 2000, 'CARD', 'TXN028', 'RCP028');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5041, TO_DATE('2026-05-15', 'YYYY-MM-DD'), 800, 'JAZZCASH', 'TXN029', 'RCP029');
INSERT INTO payment VALUES (seq_payment_id.NEXTVAL, 5042, TO_DATE('2026-05-16', 'YYYY-MM-DD'), 1500, 'CARD', 'TXN030', 'RCP030');

