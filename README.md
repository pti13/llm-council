# LLM Council

![llmcouncil](header.jpg)

The idea of this repo is that instead of asking a question to your favorite LLM provider, you can group multiple LLMs into your "LLM Council". This repo is a simple, local web app that essentially looks like ChatGPT except it uses Ollama to run multiple LLMs locally, it then asks them to review and rank each other's work, and finally a Chairman LLM produces the final response.

In a bit more detail, here is what happens when you submit a query:

1. **Stage 1: First opinions**. The user query is given to all LLMs individually, and the responses are collected. The individual responses are shown in a "tab view", so that the user can inspect them all one by one.
2. **Stage 2: Review**. Each individual LLM is given the responses of the other LLMs. Under the hood, the LLM identities are anonymized so that the LLM can't play favorites when judging their outputs. The LLM is asked to rank them in accuracy and insight.
3. **Stage 3: Final response**. The designated Chairman of the LLM Council takes all of the model's responses and compiles them into a single final answer that is presented to the user.

## Vibe Code Alert

This project was 99% vibe coded as a fun Saturday hack because I wanted to explore and evaluate a number of LLMs side by side in the process of [reading books together with LLMs](https://x.com/karpathy/status/1990577951671509438). It's nice and useful to see multiple responses side by side, and also the cross-opinions of all LLMs on each other's outputs. I'm not going to support it in any way, it's provided here as is for other people's inspiration and I don't intend to improve it. Code is ephemeral now and libraries are over, ask your LLM to change it in whatever way you like.

## Setup

### 1. Install Ollama

First, install Ollama from [ollama.ai](https://ollama.ai). Then start the Ollama service:

```bash
ollama serve
```

By default, Ollama runs on `http://localhost:11434`

### 2. Pull Models

Pull the models you want to use in the council. Examples:

```bash
ollama pull mistral
ollama pull neural-chat
ollama pull dolphin-mixtral
ollama pull llama2
```

You can find more models at [ollama.ai/library](https://ollama.ai/library). Pull at least 2-3 models for a good council experience.

### 3. Install Dependencies

The project uses [uv](https://docs.astral.sh/uv/) for project management.

**Backend:**
```bash
uv sync
```

**Frontend:**
```bash
cd frontend
npm install
cd ..
```

### 4. Configure Models (Optional)

Edit `backend/config.py` to customize the council with your pulled models:

```python
COUNCIL_MODELS = [
    "mistral",
    "neural-chat",
    "dolphin-mixtral",
    "llama2",
]

CHAIRMAN_MODEL = "mistral"
```

You can also set the Ollama API URL via environment variable:

```bash
export OLLAMA_API_URL=http://localhost:11434
```

Or in `.env`:

```bash
OLLAMA_API_URL=http://localhost:11434
```

## Running the Application

**Option 1: Use the start script**
```bash
./start.sh
```

**Option 2: Run manually**

Terminal 1 (Ollama - if not already running):
```bash
ollama serve
```

Terminal 2 (Backend):
```bash
uv run python -m backend.main
```

Terminal 3 (Frontend):
```bash
cd frontend
npm run dev
```

Then open http://localhost:5173 in your browser.

## API Endpoints

- `GET /` - Health check
- `GET /api/health` - Check Ollama connection status
- `GET /api/models` - List available Ollama models
- `GET /api/conversations` - List all conversations
- `POST /api/conversations` - Create new conversation
- `GET /api/conversations/{id}` - Get conversation
- `POST /api/conversations/{id}/message` - Send message
- `POST /api/conversations/{id}/message/stream` - Send message with streaming

## Troubleshooting

**Models not found:**
```bash
# Check available models
ollama list

# Pull a model
ollama pull mistral
```

**Can't connect to Ollama:**
- Ensure Ollama is running: `ollama serve`
- Check OLLAMA_API_URL is correct (default: http://localhost:11434)
- Check firewall settings if using a remote Ollama instance

**Slow responses:**
- Larger models (7B+ parameters) will be slower
- Start with smaller models like "mistral" or "neural-chat"
- Ensure sufficient RAM/VRAM available

## Tech Stack

- **Backend:** FastAPI (Python 3.10+), async httpx, Ollama API
- **Frontend:** React + Vite, react-markdown for rendering
- **Storage:** JSON files in `data/conversations/`
- **Package Management:** uv for Python, npm for JavaScript
- **LLM Backend:** Ollama (local, no API keys needed)
