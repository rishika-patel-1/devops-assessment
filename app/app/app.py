@app.route("/api/health", methods=["GET"])
def health_check():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT 1;")
        cursor.close()
        conn.close()

        return {
            "status": "UP",
            "application": "Running",
            "database": "Connected"
        }, 200

    except Exception as error:
        return {
            "status": "DOWN",
            "application": "Running",
            "database": "Disconnected",
            "error": str(error)
        }, 500