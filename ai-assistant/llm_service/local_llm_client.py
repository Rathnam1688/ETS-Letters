"""
NFR 5.1: all LLM inference stays on organizational hardware. This client
talks to a local Ollama or vLLM server — never a public API.

Swap OLLAMA vs VLLM via the LLM_BACKEND env var; both expose
OpenAI-compatible-ish local endpoints so the calling code stays the same.
"""
from __future__ import annotations

import os

import requests

LLM_BACKEND = os.environ.get("LLM_BACKEND", "ollama")  # "ollama" | "vllm"
OLLAMA_URL = os.environ.get("OLLAMA_URL", "http://localhost:11434")
VLLM_URL = os.environ.get("VLLM_URL", "http://localhost:8000")
MODEL_NAME = os.environ.get("LLM_MODEL", "llama3")


def generate(prompt: str, system: str | None = None, max_tokens: int = 1024) -> str:
    if LLM_BACKEND == "ollama":
        return _generate_ollama(prompt, system, max_tokens)
    elif LLM_BACKEND == "vllm":
        return _generate_vllm(prompt, system, max_tokens)
    raise ValueError(f"Unknown LLM_BACKEND '{LLM_BACKEND}'")


def _generate_ollama(prompt: str, system: str | None, max_tokens: int) -> str:
    resp = requests.post(
        f"{OLLAMA_URL}/api/generate",
        json={
            "model": MODEL_NAME,
            "prompt": prompt,
            "system": system or "",
            "stream": False,
            "options": {"num_predict": max_tokens},
        },
        timeout=120,
    )
    resp.raise_for_status()
    return resp.json()["response"]


def _generate_vllm(prompt: str, system: str | None, max_tokens: int) -> str:
    messages = []
    if system:
        messages.append({"role": "system", "content": system})
    messages.append({"role": "user", "content": prompt})

    resp = requests.post(
        f"{VLLM_URL}/v1/chat/completions",
        json={"model": MODEL_NAME, "messages": messages, "max_tokens": max_tokens},
        timeout=120,
    )
    resp.raise_for_status()
    return resp.json()["choices"][0]["message"]["content"]
