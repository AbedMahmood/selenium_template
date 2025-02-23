from flask import Flask, send_from_directory, request, jsonify

app = Flask(__name__)

@app.errorhandler(404)
def page_not_found(error):
    return send_from_directory("pages", "error.html"), 404

@app.route("/")
def serve_index():
    return send_from_directory("pages", "index.html")

@app.route("/pages/<path:filename>")
def serve_app_files(filename):
    return send_from_directory("pages", filename)

@app.route("/submit", methods=["POST"])
def handle_form():
    data = request.json  # Capture JSON data from frontend

    username = data.get("username")
    password = data.get("password")
    email = data.get("email")

    if not username or not password or not email:
        return jsonify({"status": "error", "message": "All fields are required"}), 400

    # Simulating user validation or database interaction
    if username == "test" or email == "test@example.com":
        return jsonify({"status": "error", "message": "User already exists"}), 400

    return jsonify({"status": "success", "message": f"Welcome, {username}!"})

if __name__ == "__main__":
    app.run(debug=True)