
ALTER TABLE challan ADD CONSTRAINT fk_challan_vehicle 
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id);
    
ALTER TABLE challan ADD CONSTRAINT fk_challan_officer 
    FOREIGN KEY (officer_id) REFERENCES traffic_officer(officer_id);
    
ALTER TABLE challan ADD CONSTRAINT fk_challan_violation 
    FOREIGN KEY (violation_code) REFERENCES violation_type(violation_code);
    
ALTER TABLE challan ADD CONSTRAINT fk_challan_location 
    FOREIGN KEY (location_id) REFERENCES location(location_id);
    
ALTER TABLE payment ADD CONSTRAINT fk_payment_challan 
    FOREIGN KEY (challan_id) REFERENCES challan(challan_id);
    
ALTER TABLE citizen_vehicle ADD CONSTRAINT fk_cv_citizen 
    FOREIGN KEY (citizen_id) REFERENCES citizen(citizen_id);
    
ALTER TABLE citizen_vehicle ADD CONSTRAINT fk_cv_vehicle 
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id);


ALTER TABLE citizen ADD CONSTRAINT chk_citizen_age CHECK (
    (date_of_birth <= ADD_MONTHS(SYSDATE, -216)) -- 18 years minimum
);

ALTER TABLE vehicle ADD CONSTRAINT chk_vehicle_year CHECK (
    model_year BETWEEN 1970 AND EXTRACT(YEAR FROM SYSDATE)
);

ALTER TABLE challan ADD CONSTRAINT chk_due_date CHECK (
    due_date >= issue_date
);


