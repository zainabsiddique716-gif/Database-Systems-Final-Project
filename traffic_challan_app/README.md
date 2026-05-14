# Smart City Traffic & Challan System
**Authors:** Zainab Siddique (24f-0824) · Malaika Imdad (24f-0776)

---

## Prerequisites
- Python 3.9+  
- Oracle Database (XE or full) with your SQL files already run  
- Oracle Instant Client installed (required by cx_Oracle)

---

## Step 1 — Install Oracle Instant Client
Download from: https://www.oracle.com/database/technologies/instant-client/downloads.html  
Extract to e.g. `C:\oracle\instantclient_21_x` and add to PATH.

---

## Step 2 — Set Up the Project

Open Command Prompt and run:

```
cd traffic_app
python -m venv venv
venv\Scripts\activate          (Windows)
source venv/bin/activate        (Linux/Mac)

pip install Flask cx_Oracle
```

---

## Step 3 — Configure Database

Open **app.py** and edit these 3 lines near the top:

```python
DB_USER     = "system"          # your Oracle username
DB_PASSWORD = "oracle"          # your Oracle password
DB_DSN      = "localhost:1521/XE"  # host:port/service_name
```

Make sure your Oracle SQL files have been run in this order:
1. drop.sql (clean slate)
2. createTables.sql
3. sequences.sql
4. constraints.sql
5. indexes.sql
6. insertion.sql
7. views.sql
8. PLSQL.sql

---

## Step 4 — Run the App

```
python app.py
```

Then open your browser at: **http://localhost:5000**

---

## Pages & Features

| URL | Feature |
|-----|---------|
| `/` | Dashboard with stats & recent challans |
| `/challans` | List, filter, search, update challan status |
| `/challans/new` | Issue a new challan (auto-fills fine) |
| `/citizens` | View all citizens with challan counts |
| `/citizens/new` | Register new citizen |
| `/vehicles` | Vehicle list with owner & status |
| `/vehicles/new` | Register new vehicle |
| `/officers` | Officers with challan counts |
| `/payments` | All payments list |
| `/payments/new` | Record payment (auto-marks challan PAID) |
| `/reports` | 8 SQL reports from queries.sql |
| `/views/vw_daily_challan_summary` | Daily summary view |
| `/views/vw_officer_performance` | Officer performance view |
| `/api/outstanding_fines/<id>` | JSON — calls PL/SQL function |
| `/api/vehicle_status/<id>` | JSON — calls fn_is_vehicle_blacklisted |

---

## Troubleshooting

**DPI-1047: Cannot locate Oracle Client libraries**  
→ Install Oracle Instant Client and add to PATH / LD_LIBRARY_PATH

**ORA-12541: No listener**  
→ Start Oracle service: `net start OracleServiceXE` (Windows)  
  or `sudo systemctl start oracle-xe` (Linux)

**ORA-01017: invalid username/password**  
→ Check DB_USER and DB_PASSWORD in app.py
