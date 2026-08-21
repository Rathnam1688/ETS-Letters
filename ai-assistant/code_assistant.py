"""
FR-06: Local AI Code Assistant.

Drafts or updates XSL-FO / HTML+CSS template code. Every prompt is
grounded with retrieved CMS Knowledge Base context (BR-04) so the model
can't hallucinate layout rules, and inference never leaves the org
(NFR 5.1).
"""
from __future__ import annotations

from ai_assistant.llm_service.local_llm_client import generate
from ai_assistant.rag.retriever import retrieve_context

SYSTEM_PROMPT = """You are a template engineering assistant for a healthcare
document generation platform. You write XSL-FO and HTML/CSS templates
that must be pixel-perfect and compliant with CMS layout rules provided
in the CONTEXT section. Only use rules present in CONTEXT — if the
context doesn't cover something, say so instead of guessing."""


def draft_template(instruction: str, template_format: str = "html") -> str:
    """
    instruction: e.g. "Add a QR barcode field to the top-right of the
                        Remittance Advice header, per CMS layout rule 4.2"
    template_format: "html" or "xslfo"
    """
    context = retrieve_context(instruction, k=6)

    prompt = f"""CONTEXT (from the CMS Knowledge Base):
{context}

TASK:
Format: {template_format.upper()}
{instruction}

Respond with only the template code, no commentary."""

    return generate(prompt, system=SYSTEM_PROMPT, max_tokens=2048)


if __name__ == "__main__":
    print(draft_template(
        "Draft the header section of a Remittance Advice letter with "
        "recipient block and a Code128 barcode placeholder.",
        template_format="html",
    ))
