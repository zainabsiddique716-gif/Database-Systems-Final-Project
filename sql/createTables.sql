
-- 1. CITIZEN TABLE
CREATE TABLE citizen (
    citizen_id      NUMBER(10)      PRIMARY KEY,
    cnic           VARCHAR2(15)    NOT NULL UNIQUE,
    full_name      VARCHAR2(100)   NOT NULL,
    father_name    VARCHAR2(100),
    date_of_birth  DATE            NOT NULL,
    license_number VARCHAR2(20)    UNIQUE,
    phone          VARCHAR2(15)    NOT NULL,
    email          VARCHAR2(100),
    address        VARCHAR2(200),
    created_date   DATE            DEFAULT SYSDATE
);

-- 2. VEHICLE TABLE
CREATE TABLE vehicle (
    vehicle_id          NUMBER(10)      PRIMARY KEY,
    plate_number        VARCHAR2(15)    NOT NULL UNIQUE,
    vehicle_type        VARCHAR2(20)    NOT NULL,
    model_year          NUMBER(4)       NOT NULL,
    engine_number       VARCHAR2(30)    UNIQUE,
    registration_date   DATE            NOT NULL,
    registration_expiry DATE            NOT NULL,
    color               VARCHAR2(20),
    status              VARCHAR2(15)    DEFAULT 'ACTIVE'
);

-- 3. TRAFFIC_OFFICER TABLE
CREATE TABLE traffic_officer (
    officer_id      NUMBER(10)      PRIMARY KEY,
    badge_number    VARCHAR2(20)    NOT NULL UNIQUE,
    full_name       VARCHAR2(100)   NOT NULL,
    rank_name       VARCHAR2(30)    NOT NULL,
    shift_timing    VARCHAR2(20),
    joining_date    DATE            DEFAULT SYSDATE,
    contact_number  VARCHAR2(15)
);

-- 4. VIOLATION_TYPE TABLE
CREATE TABLE violation_type (
    violation_code      VARCHAR2(10)    PRIMARY KEY,
    violation_name      VARCHAR2(100)   NOT NULL,
    fine_amount         NUMBER(10,2)    NOT NULL,
    penalty_points      NUMBER(3)       DEFAULT 0,
    severity_level      VARCHAR2(20)    CHECK (severity_level IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL'))
);

-- 5. LOCATION TABLE
CREATE TABLE location (
    location_id     NUMBER(10)      PRIMARY KEY,
    city_name       VARCHAR2(50)    NOT NULL,
    sector_name     VARCHAR2(50)    NOT NULL,
    road_name       VARCHAR2(100),
    camera_id       VARCHAR2(20)
);

-- 6. CHALLAN TABLE (Main Transaction Table)
CREATE TABLE challan (
    challan_id          NUMBER(10)      PRIMARY KEY,
    vehicle_id          NUMBER(10)      NOT NULL,
    officer_id          NUMBER(10)      NOT NULL,
    violation_code      VARCHAR2(10)    NOT NULL,
    location_id         NUMBER(10)      NOT NULL,
    issue_date          DATE            DEFAULT SYSDATE,
    due_date            DATE,
    fine_amount         NUMBER(10,2)    NOT NULL,
    late_fee            NUMBER(10,2)    DEFAULT 0,
    total_amount        NUMBER(10,2)    NOT NULL,
    status              VARCHAR2(15)    DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'PAID', 'DISPUTED', 'CANCELLED')),
    remarks             VARCHAR2(200),
    CONSTRAINT chk_fine_positive CHECK (fine_amount > 0)
);

-- 7. PAYMENT TABLE
CREATE TABLE payment (
    payment_id      NUMBER(10)      PRIMARY KEY,
    challan_id      NUMBER(10)      NOT NULL UNIQUE,
    payment_date    DATE            DEFAULT SYSDATE,
    amount_paid     NUMBER(10,2)    NOT NULL,
    payment_method  VARCHAR2(20)    CHECK (payment_method IN ('CASH', 'CARD', 'BANK_TRANSFER', 'JAZZCASH', 'EASYPEASA')),
    transaction_id  VARCHAR2(50)    UNIQUE,
    receipt_number  VARCHAR2(30)    UNIQUE,
    CONSTRAINT chk_payment_amount CHECK (amount_paid > 0)
);

-- 8. CITIZEN_VEHICLE (Junction Table - M:N Relationship)
CREATE TABLE citizen_vehicle (
    citizen_id      NUMBER(10)      NOT NULL,
    vehicle_id      NUMBER(10)      NOT NULL,
    ownership_date  DATE            DEFAULT SYSDATE,
    is_primary      CHAR(1)         DEFAULT 'N' CHECK (is_primary IN ('Y', 'N')),
    CONSTRAINT pk_citizen_vehicle PRIMARY KEY (citizen_id, vehicle_id)
);

