from decimal import Decimal

from flask import Flask, jsonify, render_template, request

from db import get_connection


app = Flask(__name__)


def serialize_row(row):
    result = {}

    for key, value in row.items():
        if isinstance(value, Decimal):
            result[key] = float(value)
        elif hasattr(value, "isoformat"):
            result[key] = value.isoformat()
        else:
            result[key] = value

    return result


@app.get("/")
def home():
    return render_template("index.html")


@app.get("/api/health")
def health():
    try:
        with get_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute("SELECT 1")
                cursor.fetchone()

        return jsonify({
            "status": "healthy",
            "database": "connected",
        })

    except Exception as error:
        return jsonify({
            "status": "unhealthy",
            "error": str(error),
        }), 500


@app.get("/api/dashboard")
def dashboard():
    query = """
        SELECT
            COUNT(*) AS total_bookings,
            COALESCE(SUM(amount), 0) AS total_amount,
            COUNT(*) FILTER (
                WHERE status = 'confirmed'
            ) AS confirmed_bookings,
            COUNT(*) FILTER (
                WHERE status = 'pending'
            ) AS pending_bookings
        FROM hotel_bookings;
    """

    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(query)
            row = cursor.fetchone()

    return jsonify(serialize_row(row))


@app.get("/api/bookings")
def list_bookings():
    city = request.args.get("city")
    status = request.args.get("status")
    limit = min(request.args.get("limit", 100, type=int), 500)

    query = """
        SELECT
            id,
            org_id,
            hotel_id,
            city,
            checkin_date,
            checkout_date,
            amount,
            status,
            created_at
        FROM hotel_bookings
        WHERE (%s IS NULL OR city = %s)
          AND (%s IS NULL OR status = %s)
        ORDER BY created_at DESC
        LIMIT %s;
    """

    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(
                query,
                (city, city, status, status, limit),
            )
            rows = cursor.fetchall()

    return jsonify([serialize_row(row) for row in rows])


@app.get("/api/reports/delhi-last-30-days")
def delhi_report():
    query = """
        SELECT
            org_id,
            status,
            COUNT(*) AS booking_count,
            SUM(amount) AS total_amount
        FROM hotel_bookings
        WHERE city = 'delhi'
          AND created_at >= NOW() - INTERVAL '30 days'
        GROUP BY org_id, status
        ORDER BY org_id, status;
    """

    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(query)
            rows = cursor.fetchall()

    return jsonify([serialize_row(row) for row in rows])


@app.get("/api/bookings/<booking_id>/events")
def booking_events(booking_id):
    query = """
        SELECT
            id,
            booking_id,
            event_type,
            payload,
            created_at
        FROM booking_events
        WHERE booking_id = %s
        ORDER BY created_at DESC;
    """

    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(query, (booking_id,))
            rows = cursor.fetchall()

    return jsonify([serialize_row(row) for row in rows])


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)