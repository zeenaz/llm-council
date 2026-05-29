#!/bin/bash

# LLM Council - Start script

echo "Starting LLM Council..."
echo ""

BACKEND_PORT="${LLM_COUNCIL_BACKEND_PORT:-8002}"
export VITE_API_BASE="${VITE_API_BASE:-http://localhost:${BACKEND_PORT}}"

# Start backend
echo "Starting backend on http://localhost:${BACKEND_PORT}..."
uv run python -m backend.main &
BACKEND_PID=$!

# Wait a bit for backend to start
sleep 2

# Start frontend
echo "Starting frontend on http://localhost:5173..."
cd frontend
npm run dev &
FRONTEND_PID=$!

echo ""
echo "✓ LLM Council is running!"
echo "  Backend:  http://localhost:${BACKEND_PORT}"
echo "  Frontend: http://localhost:5173"
echo ""
echo "Press Ctrl+C to stop both servers"

# Wait for Ctrl+C
trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; exit" SIGINT SIGTERM
wait
