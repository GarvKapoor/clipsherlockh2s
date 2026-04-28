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
# We use 'sh -c' to make sure the $PORT variable is correctly read as a number
CMD sh -c "xvfb-run --server-args='-screen 0 1280x1024x24' streamlit run app.py --server.port $PORT --server.address 0.0.0.0"
