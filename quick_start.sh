#!/bin/bash
# Quick start guide for LLM Council with Ollama

echo "🚀 LLM Council with Ollama - Quick Start"
echo "========================================"
echo ""

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "❌ Ollama is not installed!"
    echo "📥 Download from: https://ollama.ai"
    exit 1
fi

echo "✓ Ollama is installed"

# Check if Ollama service is running
if ! curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
    echo ""
    echo "⚠️  Ollama is not running!"
    echo "💡 Start it with: ollama serve"
    echo ""
    exit 1
fi

echo "✓ Ollama service is running"

# Check available models
echo ""
echo "📋 Available models:"
curl -s http://localhost:11434/api/tags | python3 -c "
import sys, json
data = json.load(sys.stdin)
if data.get('models'):
    models = [m['name'].split(':')[0] for m in data['models']]
    for m in sorted(set(models)):
        print(f'  - {m}')
else:
    print('  (none - run: ollama pull mistral)')
"

echo ""
echo "🎯 Recommended models to pull:"
echo "  ollama pull mistral          # Fast, good quality"
echo "  ollama pull neural-chat      # Chat-optimized"
echo "  ollama pull dolphin-mixtral  # MoE, higher quality"
echo "  ollama pull llama2           # General purpose"
echo ""

# Check if Python dependencies are installed
if ! python3 -c "import fastapi, httpx" 2>/dev/null; then
    echo "📦 Installing Python dependencies..."
    echo "   uv sync"
    echo ""
fi

echo "✅ Ready to start LLM Council!"
echo ""
echo "🚀 Run one of these in different terminals:"
echo "   Terminal 1: ollama serve"
echo "   Terminal 2: uv run python -m backend.main"
echo "   Terminal 3: cd frontend && npm run dev"
echo ""
echo "🌐 Open: http://localhost:5173"
