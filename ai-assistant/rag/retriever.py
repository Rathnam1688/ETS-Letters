"""
Retrieval layer used by the code assistant (FR-06) to ground responses
in the ingested CMS Knowledge Base and prevent hallucinated layout rules.
"""
from __future__ import annotations

from langchain_community.vectorstores import Milvus
from langchain_huggingface import HuggingFaceEmbeddings

from ai_assistant.rag.ingest import COLLECTION_NAME, EMBEDDING_MODEL, MILVUS_URI


def get_retriever(k: int = 5):
    embeddings = HuggingFaceEmbeddings(model_name=EMBEDDING_MODEL)
    store = Milvus(
        embedding_function=embeddings,
        collection_name=COLLECTION_NAME,
        connection_args={"uri": MILVUS_URI},
    )
    return store.as_retriever(search_kwargs={"k": k})


def retrieve_context(query: str, k: int = 5) -> str:
    """Return concatenated top-k chunks relevant to `query`, for prompt grounding."""
    retriever = get_retriever(k=k)
    results = retriever.invoke(query)
    return "\n\n---\n\n".join(doc.page_content for doc in results)
