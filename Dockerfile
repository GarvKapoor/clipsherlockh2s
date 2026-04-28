# 1. Use the official Playwright Python image
FROM mcr.microsoft.com/playwright/python:v1.45.0-jammy

# 2. Environment variables
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# 3. Install xvfb (Required for headed mode on servers)
RUN apt-get update && apt-get install -y xvfb && rm -rf /var/lib/apt/lists/*

# 4. Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Install the browser
RUN playwright install chromium

# 6. Copy your source code
COPY . .

# 7. Start command using shell execution to expand $PORT
CMD ["sh", "-c", "xvfb-run --server-args='-screen 0 1280x1024x24' streamlit run app.py --server.port $PORT --server.address 0.0.0.0"]
