# Use Python 3.10
FROM python:3.10-slim

# Set workdir
WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install requirements
RUN pip install --no-cache-dir -r requirements.txt

# Copy project code
COPY . .

# Default command (can be overridden)
CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]
