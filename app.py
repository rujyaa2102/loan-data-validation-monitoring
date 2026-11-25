import os
from flask import Flask, jsonify

app = Flask(__name__)

LOG = os.path.expanduser("~/loan-project/app.log")


@app.route("/health")
def health():
    return jsonify({
        "status": "UP"
    })


@app.route("/status")
def status():
    errors = 0
    last_line = ""

    with open(LOG, "r") as f:
        for line in f:
            last_line = line.strip()

            if " ERROR " in line:
                errors += 1

    return jsonify({
        "error_count": errors,
        "last_log_line": last_line
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
