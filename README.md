# Smart City Traffic & Challan System

A complete database-driven web application for managing traffic challans, citizens, vehicles, officers, payments, and reports in a smart city environment.


# Project Overview

The **Smart City Traffic & Challan System** is designed to automate and digitize traffic violation management.

The system allows traffic officers to:

- Issue challans
- Manage citizens and vehicles
- Record payments
- Generate reports
- Monitor traffic violation statistics
- Track outstanding fines
- View officer performance

The application uses Oracle Database for secure and efficient data management and Flask for backend routing and APIs.

---

# Technologies Used

| Technology | Purpose |
|---|---|
| HTML/CSS | Frontend UI |
| JavaScript | Dynamic frontend interactions |
| Python | Backend logic |
| Flask | Web framework |
| Oracle Database XE | Database management |
| oracledb | Python Oracle connector |

---

# Main Features

## Dashboard

- Total challans
- Paid challans
- Pending challans
- Revenue statistics
- Recent challans
- Violation breakdown

---

## Challan Management

- Create new challans
- Update challan status
- Search challans
- Filter by status
- Due date management

---

## Citizen Management

- Register citizens
- Search citizens
- View citizen challan history
- View owned vehicles

---

## Vehicle Management

- Register vehicles
- Vehicle-owner mapping
- Vehicle status tracking

---

## Payment Management

- Record challan payments
- Update challan payment status
- Payment receipts and transaction records

---

## Officer Management

- Officer profiles
- Challan statistics
- Performance tracking



# Project Structure

```bash
Smart-City-Traffic-System/
│
├── app.py
├── templates/
│   ├── dashboard.html
│   ├── challans.html
│   ├── challan_form.html
│   ├── citizens.html
│   ├── citizen_form.html
│   ├── vehicles.html
│   ├── vehicle_form.html
│   ├── payments.html
│   ├── payment_form.html
│   ├── officers.html
│   ├── reports.html
│   └── view_data.html
│
├── static/
│   ├── css/
│   ├── js/
│   └── images/
│
└── README.md
```

---

# Database Design

The system uses Oracle Database tables including:

- citizen
- vehicle
- challan
- payment
- traffic_officer
- violation_type
- location
- citizen_vehicle

---

# Oracle Setup

## Install Oracle Database XE

Install Oracle XE and ensure:

```text
Service Name: XE
Port: 1521
```

---

## Install Oracle Instant Client

Download and install:

- Oracle Instant Client 23

Update this path in `app.py`:

```python
oracledb.init_oracle_client(
    lib_dir=r"C:\oracle\instantclient_23\instantclient_23_0"
)
```

---

# Python Requirements

Install required libraries:

```bash
pip install flask oracledb
```

---

# Database Connection Configuration

Inside `app.py`:

```python
DB_USER     = "SYSTEM"
DB_PASSWORD = "12345"
DB_DSN      = "localhost:1521/XE"
```

Update according to your Oracle credentials.

---

# How to Run the Project

## Step 1: Open Terminal / Bash

Navigate to project folder:

```bash
cd path/to/Smart-City-Traffic-System
```

Example:

```bash
cd Desktop/Smart-City-Traffic-System
```

---

## Step 2: Create Virtual Environment (Optional)

```bash
python -m venv venv
```

Activate environment:

### Windows CMD

```bash
venv\Scripts\activate
```

### Git Bash

```bash
source venv/Scripts/activate
```

---

## Step 3: Install Dependencies

```bash
pip install flask oracledb
```

---

## Step 4: Run Oracle Database

Make sure Oracle XE service is running.

---

## Step 5: Run Flask Application

```bash
python app.py
```

OR

```bash
py app.py
```

---

# Application URL

After running:

```text
http://127.0.0.1:5000
```

Open this in browser.

---

# Flask Routes

| Route | Description |
|---|---|
| `/` | Dashboard |
| `/challans` | View challans |
| `/challans/new` | Create challan |
| `/citizens` | View citizens |
| `/vehicles` | View vehicles |
| `/payments` | Payment records |
| `/officers` | Officer records |
| `/reports` | Reports section |

---

# APIs

| API | Purpose |
|---|---|
| `/api/outstanding_fines/<id>` | Outstanding fines |
| `/api/vehicle_status/<id>` | Vehicle blacklist status |
| `/api/citizen_vehicles/<id>` | Citizen vehicles |

---

# Oracle Features Used

- PL/SQL Functions
- Views
- Sequences
- Joins
- Aggregate Queries
- Subqueries
- Group By
- Having Clause
- Date Functions

---

# Sample SQL Concepts Used

## Aggregate Functions

```sql
SELECT COUNT(*) FROM challan;
```

## Group By

```sql
SELECT status, COUNT(*)
FROM challan
GROUP BY status;
```

## Joins

```sql
SELECT *
FROM challan ch
JOIN vehicle v
ON ch.vehicle_id = v.vehicle_id;
```

---

# Future Improvements

- JWT Authentication
- Online payment gateway
- AI-based violation detection
- Real-time CCTV integration
- SMS/Email notifications
- Responsive mobile UI
