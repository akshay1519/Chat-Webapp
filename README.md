# Azure Chat Web App

A production-ready Python chat application using Flask and Azure OpenAI, designed for deployment on Azure App Service with Managed Identity support.

## Features
- Modern chat UI with session management
- Azure OpenAI integration (Managed Identity or API Key)
- In-memory conversation storage (easy to extend to DB)
- RESTful API endpoints for chat and session management
- Configurable via environment variables
- Logging and error handling
- Ready for Docker and Azure deployment

## Project Structure
```
app/
  api/           # Flask API blueprints
  models/        # Pydantic models for messages/conversations
  services/      # OpenAI and auth services
  static/        # CSS/JS assets
  templates/     # Jinja2 HTML templates
  utils/         # Logging and Azure auth utils
  config.py      # App configuration
  main.py        # Flask app entrypoint
requirements.txt # Python dependencies
Dockerfile       # Container build file
.dockerignore    # Docker ignore rules
```

## Getting Started

### Prerequisites
- Python 3.12+
- Azure subscription (for OpenAI/Managed Identity)
- Docker (for containerization)

### Local Development
1. Clone the repo and install dependencies:
   ```bash
   python -m venv env
   source env/bin/activate
   pip install -r requirements.txt
   ```
2. Set environment variables (see `.env.example` or config section below).
3. Run the app:
   ```bash
   python app/main.py
   ```
4. Visit [http://localhost:9090](http://localhost:9090)

## Docker Image Build & Run

To build and run the Docker image for this project:

1. Build the Docker image:
   ```bash
   docker build -t azure-chat-webapp .
   ```
2. Create a `.env` file in your project root with the required environment variables (see Configuration section above).
3. Run the Docker container with your environment file:
   ```bash
   docker run -p 9090:9090 --env-file .env azure-chat-webapp
   ```

This will start the app on [http://localhost:9090](http://localhost:9090).

If you want to override environment variables directly, you can use `-e` flags:
```bash
docker run -p 9090:9090 -e AZURE_OPENAI_ENDPOINT=... -e FLASK_SECRET_KEY=... azure-chat-webapp
   ```

### Azure Deployment
- Deploy using Azure App Service or Azure Container Apps.
- Use Managed Identity for secure OpenAI access (recommended).

## Configuration
Set the following environment variables:
- `AZURE_OPENAI_ENDPOINT` - Your Azure OpenAI endpoint
- `AZURE_OPENAI_DEPLOYMENT` - Deployment name
- `AZURE_OPENAI_API_VERSION` - API version
- `USE_MANAGED_IDENTITY` - true/false
- `MANAGED_IDENTITY_CLIENT_ID` - (optional) Client ID for user-assigned identity
- `FLASK_SECRET_KEY` - Flask session secret
- `LOG_LEVEL` - Logging level (default: INFO)

```
