# Dockerfile for Azure Chat Web App
FROM python:3.12-slim

# Set workdir to project root
WORKDIR /

# Install system dependencies
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# Install Azure CLI
RUN apt-get update && \
    apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg && \
    curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null && \
    AZ_REPO=$(lsb_release -cs) && \
    echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install -y azure-cli && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files 
COPY . .

# Expose port
EXPOSE 9090

# Set environment variables (can be overridden)
ENV FLASK_APP=app/main.py
ENV FLASK_RUN_PORT=9090

# Start the app using module syntax for correct import resolution
CMD ["python", "-m", "app.main"]
