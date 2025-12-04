"""Configuration for the LLM Council."""

import os
from dotenv import load_dotenv

load_dotenv()

# Ollama API endpoint (default: http://localhost:11434)
OLLAMA_API_URL = os.getenv("OLLAMA_API_URL", "http://localhost:11434")

# Council members - list of Ollama model identifiers
# Make sure these models are pulled in Ollama
COUNCIL_MODELS = [
    "mistral",
    "neural-chat",
    "dolphin-mixtral",
    "llama2",
]

# Chairman model - synthesizes final response
CHAIRMAN_MODEL = "mistral"

# Data directory for conversation storage
DATA_DIR = "data/conversations"
