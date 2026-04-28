# Use the official Playwright Python image
FROM mcr.microsoft.com/playwright/python:v1.45.0-jammy

# Set environment variables to ensure Python output isn't buffered
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install the browser (dependencies are already in the base image)
RUN playwright install chromium

# Copy your source code
COPY . .

# Render defaults to port 10000
EXPOSE 10000

# Update this to your actual entry point (e.g., 'python main.py' or a gunicorn command)
CMD ["python", "main.py"]
