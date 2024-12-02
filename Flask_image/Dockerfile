# Start from a Python base image
FROM python:3.9-slim

# Set working directory inside the container
WORKDIR /app

# Install dependencies
# Copy the requirements.txt to the container first and install the dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask app into the container (all files from the current directory)
COPY . /app

# Expose the port the app will run on
EXPOSE 5000

# Command to run the Flask application and allow external connections
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
