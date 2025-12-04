## Migration from OpenRouter to Ollama

This guide explains the changes made to switch the LLM Council from OpenRouter to Ollama.

### What Changed

1. **API Client**: Created new `backend/ollama.py` to replace OpenRouter integration
   - Uses Ollama's local API at `http://localhost:11434`
   - No API keys required
   - Models run locally on your machine

2. **Configuration**: Updated `backend/config.py`
   - Removed `OPENROUTER_API_KEY` 
   - Changed to `OLLAMA_API_URL` (configurable via env)
   - Updated `COUNCIL_MODELS` to use Ollama models (mistral, neural-chat, etc.)
   - No external API calls needed

3. **Council Logic**: Updated `backend/council.py`
   - Changed import from `openrouter` to `ollama`
   - Uses locally running models instead of paid API

4. **Backend Health**: Enhanced `backend/main.py`
   - Added startup check to verify Ollama is running
   - New endpoints: `/api/health` and `/api/models` for diagnostics
   - Better error messages for troubleshooting

5. **Documentation**: Updated README with Ollama setup instructions

### Setup Steps

1. **Install and Start Ollama**:
   ```bash
   # Install from ollama.ai
   ollama serve  # Run in a separate terminal
   ```

2. **Pull Models**:
   ```bash
   ollama pull mistral
   ollama pull neural-chat
   ollama pull dolphin-mixtral
   ollama pull llama2
   ```

3. **Update Configuration** (if needed):
   - Edit `backend/config.py` to use your pulled models
   - Or set `OLLAMA_API_URL` in `.env` if using a remote Ollama instance

4. **Run the App**:
   ```bash
   ./start.sh
   # or manually:
   # Terminal 1: uv run python -m backend.main
   # Terminal 2: cd frontend && npm run dev
   ```

### Benefits

- **No API Keys**: Models run locally
- **No Costs**: Free after initial setup
- **Full Privacy**: All data stays on your machine
- **Offline**: Works without internet (after models are pulled)
- **Full Control**: Choose which models to run

### Available Models

Popular Ollama models for the council:

- **mistral** - Fast, good quality (recommended for chairman)
- **neural-chat** - Chat-optimized
- **dolphin-mixtral** - MoE model, good quality
- **llama2** - Solid general purpose
- **openchat** - Fast and capable
- **orca-mini** - Small and fast
- **zephyr** - Code and reasoning optimized

See more at: https://ollama.ai/library

### Troubleshooting

**"Can't connect to Ollama"**:
- Ensure `ollama serve` is running in another terminal
- Check OLLAMA_API_URL is correct
- Default: http://localhost:11434

**"No models available"**:
- Run `ollama pull mistral` (or another model)
- Run `ollama list` to see what's installed

**Slow responses**:
- Larger models (7B+) need more computing power
- Start with smaller/faster models
- Check available RAM and GPU

### Optional: Remote Ollama

If running Ollama on another machine:

```bash
# .env file
OLLAMA_API_URL=http://192.168.1.100:11434
```

Or set the environment variable before running the backend:
```bash
export OLLAMA_API_URL=http://remote-machine:11434
uv run python -m backend.main
```
