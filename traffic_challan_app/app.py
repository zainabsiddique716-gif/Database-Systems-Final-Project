"""
Smart City Traffic & Challan System
Backend: Flask + oracledb
Authors: Zainab Siddique (24f-0824), Malaika Imdad (24f-0776)
"""

from flask import Flask, render_template, request, jsonify, redirect, url_for, flash
import oracledb
oracledb.init_oracle_client(lib_dir=r"C:\oracle\instantclient_23\instantclient_23_0")

from datetime import datetime, date
import os

DB_USER     = "SYSTEM"
DB_PASSWORD = "12345"
DB_DSN      = "localhost:1521/XE"

app = Flask(__name__)
app.secret_key = "traffic_challan_secret_2026"


def get_connection():
    return oracledb.connect(user=DB_USER, password=DB_PASSWORD, dsn=DB_DSN)


def query(sql, params=None, fetch=True):
    """Run a SELECT and return list-of-dicts."""
    conn = get_connection()
    cur  = conn.cursor()
    cur.execute(sql, params or {})
    if fetch:
        cols = [d[0].lower() for d in cur.description]
        rows = [dict(zip(cols, row)) for row in cur.fetchall()]
        cur.close(); conn.close()
        return rows
    cur.close(); conn.close()
    return []


def execute(sql, params=None):
    """Run INSERT / UPDATE / DELETE."""
    conn = get_connection()
    cur  = conn.cursor()
    cur.execute(sql, params or {})
    conn.commit()
    cur.close(); conn.close()


# ═══════════════════════════════════════════════
#  DASHBOARD
# ═══════════════════════════════════════════════

@app.route("/")
def dashboard():
    stats = {}
    try:
        stats["total_challans"]   = query("SELECT COUNT(*) AS c FROM challan")[0]["c"]
        stats["pending_challans"] = query("SELECT COUNT(*) AS c FROM challan WHERE status='PENDING'")[0]["c"]
        stats["paid_challans"]    = query("SELECT COUNT(*) AS c FROM challan WHERE status='PAID'")[0]["c"]
        stats["total_revenue"]    = query("SELECT NVL(SUM(amount_paid),0) AS c FROM payment")[0]["c"]
        stats["total_citizens"]   = query("SELECT COUNT(*) AS c FROM citizen")[0]["c"]
        stats["total_vehicles"]   = query("SELECT COUNT(*) AS c FROM vehicle")[0]["c"]
        stats["total_officers"]   = query("SELECT COUNT(*) AS c FROM traffic_officer")[0]["c"]

        # Recent challans
        recent = query("""
            SELECT * FROM (
                SELECT ch.challan_id, v.plate_number, vt.violation_name,
                       ch.fine_amount, ch.status,
                       TO_CHAR(ch.issue_date,'DD-Mon-YYYY') AS issue_date
                FROM challan ch
                JOIN vehicle v         ON ch.vehicle_id    = v.vehicle_id
                JOIN violation_type vt ON ch.violation_code = vt.violation_code
                ORDER BY ch.issue_date DESC
            ) WHERE ROWNUM <= 8
        """)
        stats["recent_challans"] = recent

        # Violation breakdown
        viol = query("""
            SELECT * FROM (
                SELECT vt.violation_name, COUNT(*) AS cnt
                FROM challan ch
                JOIN violation_type vt ON ch.violation_code = vt.violation_code
                GROUP BY vt.violation_name
                ORDER BY cnt DESC
            ) WHERE ROWNUM <= 5
        """)
        stats["violation_breakdown"] = viol

    except Exception as e:
        stats["error"] = str(e)

    return render_template("dashboard.html", stats=stats)


# ═══════════════════════════════════════════════
#  CHALLANS
# ═══════════════════════════════════════════════

@app.route("/challans")
def challans():
    status_filter = request.args.get("status", "ALL")
    search        = request.args.get("search", "")
    try:
        sql = """
            SELECT ch.challan_id, v.plate_number, cz.full_name AS citizen_name,
                   vt.violation_name, ch.fine_amount, ch.total_amount,
                   ch.status, TO_CHAR(ch.issue_date,'DD-Mon-YYYY') AS issue_date,
                   TO_CHAR(ch.due_date,'DD-Mon-YYYY') AS due_date,
                   o.full_name AS officer_name
            FROM challan ch
            JOIN vehicle v         ON ch.vehicle_id    = v.vehicle_id
            JOIN violation_type vt ON ch.violation_code = vt.violation_code
            JOIN traffic_officer o ON ch.officer_id    = o.officer_id
            LEFT JOIN citizen_vehicle cv ON v.vehicle_id = cv.vehicle_id AND cv.is_primary='Y'
            LEFT JOIN citizen cz   ON cv.citizen_id = cz.citizen_id
            WHERE 1=1
        """
        params = {}
        if status_filter != "ALL":
            sql += " AND ch.status = :status"
            params["status"] = status_filter
        if search:
            sql += " AND (UPPER(v.plate_number) LIKE :s OR UPPER(cz.full_name) LIKE :s)"
            params["s"] = f"%{search.upper()}%"
        sql += " ORDER BY ch.issue_date DESC"
        rows = query(sql, params)
    except Exception as e:
        rows = []
        flash(f"DB Error: {e}", "error")
    return render_template("challans.html", challans=rows,
                           status_filter=status_filter, search=search)


@app.route("/challans/new", methods=["GET", "POST"])
def new_challan():
    if request.method == "POST":
        try:
            execute("""
                INSERT INTO challan (
                    challan_id, vehicle_id, officer_id, violation_code,
                    location_id, issue_date, due_date,
                    fine_amount, late_fee, total_amount, status, remarks
                ) VALUES (
                    seq_challan_id.NEXTVAL,
                    :vid, :oid, :vcode, :lid,
                    TO_DATE(:idate,'YYYY-MM-DD'), TO_DATE(:ddate,'YYYY-MM-DD'),
                    :fine, :late_fee, :total, :status, :remarks
                )
            """, {
                "vid":      request.form["vehicle_id"],
                "oid":      request.form["officer_id"],
                "vcode":    request.form["violation_code"],
                "lid":      request.form["location_id"],
                "idate":    request.form["issue_date"],
                "ddate":    request.form["due_date"],
                "fine":     request.form["fine_amount"],
                "late_fee": request.form.get("late_fee", 0),
                "total":    request.form["total_amount"],
                "status":   request.form.get("status", "PENDING"),
                "remarks":  request.form.get("remarks", "")
            })
            flash("Challan issued successfully!", "success")
            return redirect(url_for("challans"))
        except Exception as e:
            flash(f"Error: {e}", "error")

    vehicles   = query("SELECT vehicle_id, plate_number FROM vehicle ORDER BY plate_number")
    officers   = query("SELECT officer_id, full_name, badge_number FROM traffic_officer ORDER BY full_name")
    violations = query("SELECT violation_code, violation_name, fine_amount FROM violation_type ORDER BY violation_name")
    locations  = query("SELECT location_id, city_name, sector_name, road_name FROM location ORDER BY city_name")
    citizens   = query("SELECT citizen_id, full_name, cnic FROM citizen ORDER BY full_name")
    return render_template("challan_form.html",
                           vehicles=vehicles, officers=officers,
                           violations=violations, locations=locations,
                           citizens=citizens)


@app.route("/challans/<int:cid>/update_status", methods=["POST"])
def update_challan_status(cid):
    new_status = request.form["status"]
    try:
        execute("UPDATE challan SET status=:s WHERE challan_id=:id",
                {"s": new_status, "id": cid})
        flash("Status updated.", "success")
    except Exception as e:
        flash(f"Error: {e}", "error")
    return redirect(url_for("challans"))


# ═══════════════════════════════════════════════
#  CITIZENS
# ═══════════════════════════════════════════════

@app.route("/citizens")
def citizens():
    search = request.args.get("search", "")
    try:
        sql = """
            SELECT c.citizen_id, c.full_name, c.cnic, c.phone,
                   c.license_number, c.email, c.address,
                   COUNT(DISTINCT cv.vehicle_id) AS vehicle_count,
                   COUNT(DISTINCT ch.challan_id) AS challan_count
            FROM citizen c
            LEFT JOIN citizen_vehicle cv ON c.citizen_id = cv.citizen_id
            LEFT JOIN challan ch         ON cv.vehicle_id = ch.vehicle_id
            WHERE 1=1
        """
        params = {}
        if search:
            sql += " AND (UPPER(c.full_name) LIKE :s OR UPPER(c.cnic) LIKE :s)"
            params["s"] = f"%{search.upper()}%"
        sql += " GROUP BY c.citizen_id, c.full_name, c.cnic, c.phone, c.license_number, c.email, c.address ORDER BY c.full_name"
        rows = query(sql, params)
    except Exception as e:
        rows = []
        flash(f"DB Error: {e}", "error")
    return render_template("citizens.html", citizens=rows, search=search)


@app.route("/citizens/new", methods=["GET", "POST"])
def new_citizen():
    if request.method == "POST":
        try:
            execute("""
                INSERT INTO citizen (citizen_id, cnic, full_name, father_name,
                    date_of_birth, license_number, phone, email, address, created_date)
                VALUES (seq_citizen_id.NEXTVAL, :cnic, :name, :fname,
                    TO_DATE(:dob,'YYYY-MM-DD'), :lic, :phone, :email, :addr, SYSDATE)
            """, {
                "cnic":  request.form["cnic"],
                "name":  request.form["full_name"],
                "fname": request.form.get("father_name", ""),
                "dob":   request.form["date_of_birth"],
                "lic":   request.form.get("license_number", ""),
                "phone": request.form["phone"],
                "email": request.form.get("email", ""),
                "addr":  request.form.get("address", "")
            })
            flash("Citizen registered!", "success")
            return redirect(url_for("citizens"))
        except Exception as e:
            flash(f"Error: {e}", "error")
    return render_template("citizen_form.html")


# ═══════════════════════════════════════════════
#  VEHICLES
# ═══════════════════════════════════════════════

@app.route("/vehicles")
def vehicles():
    search = request.args.get("search", "")
    try:
        sql = """
            SELECT v.vehicle_id, v.plate_number, v.vehicle_type,
                   v.model_year, v.color, v.status,
                   TO_CHAR(v.registration_expiry,'DD-Mon-YYYY') AS reg_expiry,
                   cz.full_name AS owner_name
            FROM vehicle v
            LEFT JOIN citizen_vehicle cv ON v.vehicle_id = cv.vehicle_id AND cv.is_primary='Y'
            LEFT JOIN citizen cz         ON cv.citizen_id = cz.citizen_id
            WHERE 1=1
        """
        params = {}
        if search:
            sql += " AND (UPPER(v.plate_number) LIKE :s OR UPPER(cz.full_name) LIKE :s)"
            params["s"] = f"%{search.upper()}%"
        sql += " ORDER BY v.plate_number"
        rows = query(sql, params)
    except Exception as e:
        rows = []
        flash(f"DB Error: {e}", "error")
    return render_template("vehicles.html", vehicles=rows, search=search)


@app.route("/vehicles/new", methods=["GET", "POST"])
def new_vehicle():
    if request.method == "POST":
        try:
            execute("""
                INSERT INTO vehicle (vehicle_id, plate_number, vehicle_type, model_year,
                    engine_number, registration_date, registration_expiry, color, status)
                VALUES (seq_vehicle_id.NEXTVAL, :plate, :vtype, :myear,
                    :eng, TO_DATE(:rdate,'YYYY-MM-DD'), TO_DATE(:edate,'YYYY-MM-DD'), :color, :status)
            """, {
                "plate":  request.form["plate_number"].upper(),
                "vtype":  request.form["vehicle_type"],
                "myear":  request.form["model_year"],
                "eng":    request.form.get("engine_number", ""),
                "rdate":  request.form["registration_date"],
                "edate":  request.form["registration_expiry"],
                "color":  request.form.get("color", ""),
                "status": request.form.get("status", "ACTIVE")
            })
            flash("Vehicle registered!", "success")
            return redirect(url_for("vehicles"))
        except Exception as e:
            flash(f"Error: {e}", "error")
    return render_template("vehicle_form.html")


# ═══════════════════════════════════════════════
#  PAYMENTS
# ═══════════════════════════════════════════════

@app.route("/payments")
def payments():
    try:
        rows = query("""
            SELECT p.payment_id, p.challan_id, v.plate_number,
                   cz.full_name AS citizen_name,
                   p.amount_paid, p.payment_method,
                   TO_CHAR(p.payment_date,'DD-Mon-YYYY') AS payment_date,
                   p.receipt_number, p.transaction_id
            FROM payment p
            JOIN challan ch              ON p.challan_id  = ch.challan_id
            JOIN vehicle v               ON ch.vehicle_id = v.vehicle_id
            LEFT JOIN citizen_vehicle cv ON v.vehicle_id  = cv.vehicle_id AND cv.is_primary='Y'
            LEFT JOIN citizen cz         ON cv.citizen_id = cz.citizen_id
            ORDER BY p.payment_date DESC
        """)
    except Exception as e:
        rows = []
        flash(f"DB Error: {e}", "error")
    return render_template("payments.html", payments=rows)


@app.route("/payments/new", methods=["GET", "POST"])
def new_payment():
    if request.method == "POST":
        try:
            challan_id = request.form["challan_id"]
            execute("""
                INSERT INTO payment (payment_id, challan_id, payment_date,
                    amount_paid, payment_method, transaction_id, receipt_number)
                VALUES (seq_payment_id.NEXTVAL, :cid, SYSDATE,
                    :amt, :method, :txn, :rcpt)
            """, {
                "cid":    challan_id,
                "amt":    request.form["amount_paid"],
                "method": request.form["payment_method"],
                "txn":    request.form.get("transaction_id", ""),
                "rcpt":   request.form.get("receipt_number", "")
            })
            execute("UPDATE challan SET status='PAID' WHERE challan_id=:id",
                    {"id": challan_id})
            flash("Payment recorded & challan marked PAID!", "success")
            return redirect(url_for("payments"))
        except Exception as e:
            flash(f"Error: {e}", "error")

    pending = query("""
        SELECT ch.challan_id, v.plate_number, ch.total_amount
        FROM challan ch
        JOIN vehicle v ON ch.vehicle_id = v.vehicle_id
        WHERE ch.status = 'PENDING'
        ORDER BY ch.challan_id
    """)
    return render_template("payment_form.html", pending_challans=pending)


# ═══════════════════════════════════════════════
#  OFFICERS
# ═══════════════════════════════════════════════

@app.route("/officers")
def officers():
    try:
        rows = query("""
            SELECT o.officer_id, o.badge_number, o.full_name, o.rank_name,
                   o.shift_timing, o.contact_number,
                   TO_CHAR(o.joining_date,'DD-Mon-YYYY') AS joining_date,
                   COUNT(ch.challan_id) AS total_challans
            FROM traffic_officer o
            LEFT JOIN challan ch ON o.officer_id = ch.officer_id
            GROUP BY o.officer_id, o.badge_number, o.full_name,
                     o.rank_name, o.shift_timing, o.contact_number, o.joining_date
            ORDER BY total_challans DESC
        """)
    except Exception as e:
        rows = []
        flash(f"DB Error: {e}", "error")
    return render_template("officers.html", officers=rows)


# ═══════════════════════════════════════════════
#  REPORTS
# ═══════════════════════════════════════════════

@app.route("/reports")
def reports():
    report = request.args.get("report", "")
    data = []; title = ""; cols = []

    try:
        if report == "overdue":
            title = "Overdue Challans (Pending > 15 days)"
            data  = query("""
                SELECT challan_id, vehicle_id,
                       TO_CHAR(issue_date,'DD-Mon-YYYY') AS issue_date,
                       fine_amount, status
                FROM challan
                WHERE status = 'PENDING' AND issue_date < SYSDATE - 15
                ORDER BY issue_date
            """)

        elif report == "officer_revenue":
            title = "Officer Revenue Collection"
            data  = query("""
                SELECT o.officer_id, o.full_name,
                       TO_CHAR(SUM(c.total_amount),'FM999,999,999') AS total_collected
                FROM traffic_officer o
                JOIN challan c ON o.officer_id = c.officer_id
                WHERE c.status = 'PAID'
                GROUP BY o.officer_id, o.full_name
                ORDER BY SUM(c.total_amount) DESC
            """)

        elif report == "top_officers":
            title = "Officers With More Than 10 Challans"
            data  = query("""
                SELECT o.officer_id, o.full_name, COUNT(c.challan_id) AS challan_count
                FROM traffic_officer o
                JOIN challan c ON o.officer_id = c.officer_id
                GROUP BY o.officer_id, o.full_name
                HAVING COUNT(c.challan_id) > 10
                ORDER BY challan_count DESC
            """)

        elif report == "citizen_challans":
            title = "Citizen Challan Details"
            data  = query("""
                SELECT ch.challan_id, cz.full_name AS citizen_name,
                       v.plate_number,
                       TO_CHAR(ch.issue_date,'DD-Mon-YYYY') AS issue_date,
                       ch.fine_amount, ch.status
                FROM challan ch
                JOIN vehicle v          ON ch.vehicle_id  = v.vehicle_id
                JOIN citizen_vehicle cv ON v.vehicle_id   = cv.vehicle_id
                JOIN citizen cz         ON cv.citizen_id  = cz.citizen_id
                WHERE cv.is_primary = 'Y'
                ORDER BY ch.issue_date DESC
            """)

        elif report == "above_avg_fines":
            title = "Challans With Above-Average Fines Per Officer"
            data  = query("""
                SELECT c1.challan_id, c1.officer_id, c1.fine_amount
                FROM challan c1
                WHERE c1.fine_amount > (
                    SELECT AVG(c2.fine_amount) FROM challan c2
                    WHERE c2.officer_id = c1.officer_id
                )
                ORDER BY c1.officer_id, c1.fine_amount DESC
            """)

        elif report == "monthly_revenue":
            title = "Monthly Revenue (Last 6 Months)"
            data  = query("""
                SELECT TO_CHAR(payment_date,'YYYY-MM') AS month,
                       COUNT(payment_id) AS payment_count,
                       TO_CHAR(SUM(amount_paid),'FM999,999,999') AS total_revenue
                FROM payment
                WHERE payment_date >= ADD_MONTHS(SYSDATE, -6)
                GROUP BY TO_CHAR(payment_date,'YYYY-MM')
                ORDER BY month DESC
            """)

        elif report == "hotspot_locations":
            title = "Violation Hotspot Locations"
            data  = query("""
                SELECT l.city_name, l.sector_name, l.road_name,
                       COUNT(ch.challan_id) AS violation_count
                FROM location l
                JOIN challan ch ON l.location_id = ch.location_id
                GROUP BY l.city_name, l.sector_name, l.road_name
                ORDER BY violation_count DESC
            """)

        elif report == "full_trail":
            title = "Full Challan Payment Trail"
            data  = query("""
                SELECT ch.challan_id, cz.full_name AS citizen_name,
                       v.plate_number, vt.violation_name,
                       TO_CHAR(ch.issue_date,'DD-Mon-YYYY') AS issue_date,
                       ch.fine_amount, ch.status,
                       TO_CHAR(p.payment_date,'DD-Mon-YYYY') AS payment_date,
                       p.amount_paid, p.payment_method
                FROM challan ch
                JOIN vehicle v          ON ch.vehicle_id    = v.vehicle_id
                JOIN citizen_vehicle cv ON v.vehicle_id     = cv.vehicle_id
                JOIN citizen cz         ON cv.citizen_id    = cz.citizen_id
                JOIN violation_type vt  ON ch.violation_code = vt.violation_code
                LEFT JOIN payment p     ON ch.challan_id    = p.challan_id
                WHERE cv.is_primary = 'Y'
                ORDER BY ch.issue_date DESC
            """)

        if data:
            cols = list(data[0].keys())

    except Exception as e:
        flash(f"Query Error: {e}", "error")

    return render_template("reports.html", data=data, title=title,
                           cols=cols, report=report)


# ═══════════════════════════════════════════════
#  PL/SQL FUNCTION API
# ═══════════════════════════════════════════════

@app.route("/api/outstanding_fines/<int:citizen_id>")
def api_outstanding_fines(citizen_id):
    try:
        conn   = get_connection()
        cur    = conn.cursor()
        result = cur.callfunc("fn_get_total_outstanding_fines",
                              oracledb.NUMBER, [citizen_id])
        cur.close(); conn.close()
        return jsonify({"citizen_id": citizen_id, "outstanding_fines": result})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/api/vehicle_status/<int:vehicle_id>")
def api_vehicle_status(vehicle_id):
    try:
        conn   = get_connection()
        cur    = conn.cursor()
        result = cur.callfunc("fn_is_vehicle_blacklisted",
                              oracledb.STRING, [vehicle_id])
        cur.close(); conn.close()
        return jsonify({"vehicle_id": vehicle_id, "status": result})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# ═══════════════════════════════════════════════
#  CITIZEN VEHICLES API (for challan form dropdown)
# ═══════════════════════════════════════════════

@app.route("/api/citizen_vehicles/<int:citizen_id>")
def api_citizen_vehicles(citizen_id):
    try:
        rows = query("""
            SELECT v.vehicle_id, v.plate_number
            FROM vehicle v
            JOIN citizen_vehicle cv ON v.vehicle_id = cv.vehicle_id
            WHERE cv.citizen_id = :cid
            ORDER BY v.plate_number
        """, {"cid": citizen_id})
        return jsonify(rows)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# ═══════════════════════════════════════════════
#  VIEWS
# ═══════════════════════════════════════════════

@app.route("/views/<view_name>")
def show_view(view_name):
    allowed = {
        "vw_daily_challan_summary": "Daily Challan Summary",
        "vw_citizen_challan_info":  "Citizen Challan Info",
        "vw_officer_performance":   "Officer Performance"
    }
    if view_name not in allowed:
        flash("View not found.", "error")
        return redirect(url_for("dashboard"))
    try:
        rows = query(f"SELECT * FROM {view_name}")
        cols = list(rows[0].keys()) if rows else []
    except Exception as e:
        rows = []; cols = []
        flash(f"Error: {e}", "error")
    return render_template("view_data.html", rows=rows, cols=cols,
                           view_name=allowed[view_name])


if __name__ == "__main__":
    app.run(debug=True, port=5000)