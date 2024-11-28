from flask import Flask, jsonify, request
from flask_pymongo import PyMongo

app = Flask(__name__)

# Configure MongoDB connection (MongoDB running in a Docker container)
app.config["MONGO_URI"] = "mongodb://mongodb:27017/pokemon_db"  # Connect to MongoDB via Docker container name
mongo = PyMongo(app)

@app.route("/api/pokemon", methods=["GET"])
def get_pokemon():
    pokemon_list = mongo.db.pokemon.find()  # Retrieve all Pokémon from the DB
    pokemon_list = [pokemon for pokemon in pokemon_list]
    return jsonify(pokemon_list)

@app.route("/api/pokemon", methods=["POST"])
def add_pokemon():
    data = request.get_json()
    pokemon = {
        "name": data["name"],
        "type": data["type"],
        "abilities": data["abilities"]
    }
    mongo.db.pokemon.insert_one(pokemon)  # Insert new Pokémon into the DB
    return jsonify({"message": "Pokémon saved to database."}), 201

@app.route("/api/pokemon/<name>", methods=["GET"])
def get_pokemon_by_name(name):
    pokemon = mongo.db.pokemon.find_one({"name": name})
    if pokemon:
        return jsonify(pokemon)
    else:
        return jsonify({"message": "Pokémon not found."}), 404

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
