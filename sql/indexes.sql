
-- Index on foreign key columns
CREATE INDEX idx_challan_vehicle ON challan(vehicle_id);
CREATE INDEX idx_challan_officer ON challan(officer_id);
CREATE INDEX idx_challan_status ON challan(status);
CREATE INDEX idx_payment_challan ON payment(challan_id);

-- Index on frequently searched columns
CREATE INDEX idx_vehicle_plate ON vehicle(plate_number);
CREATE INDEX idx_citizen_cnic ON citizen(cnic);
CREATE INDEX idx_challan_issue_date ON challan(issue_date);

-- Unique index (additional to PK)
CREATE UNIQUE INDEX idx_vehicle_engine ON vehicle(engine_number);



