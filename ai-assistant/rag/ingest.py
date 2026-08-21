"""
FR-05: Local KB Ingestion.

Reads regulatory PDFs, CMS guidelines, and XSD schemas from
`kb_source/` (you'll upload these) and embeds them into the self-hosted
vector DB (Milvus), entirely on-prem — no external embedding APIs.

Run: python ingest.py
"""
from __future__ import annotations

from pathlib import Path

from langchain_community.document_loaders import PyPDFLoader, UnstructuredXMLLoader
from langchain_community.vectorstores import Milvus
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_text_splitters import RecursiveCharacterTextSplitter

KB_SOURCE_DIR = Path(__file__).parent / "kb_source"   # <-- drop uploaded KB files here
COLLECTION_NAME = "cms_knowledge_base"
EMBEDDING_MODEL = "BAAI/bge-large-en"                  # local HuggingFace model, no API key
MILVUS_URI = "http://localhost:19530"


def load_documents() -> list:
    docs = []
    if not KB_SOURCE_DIR.exists():
        print(f"No KB source found at {KB_SOURCE_DIR} — nothing to ingest yet.")
        return docs

    for path in KB_SOURCE_DIR.rglob("*"):
        if path.suffix.lower() == ".pdf":
            docs.extend(PyPDFLoader(str(path)).load())
        elif path.suffix.lower() in (".xsd", ".xml"):
            docs.extend(UnstructuredXMLLoader(str(path)).load())
        # TODO: add loaders for other formats as the real KB arrives
    return docs


def ingest() -> None:
    documents = load_documents()
    if not documents:
        return

    splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=150)
    chunks = splitter.split_documents(documents)

    embeddings = HuggingFaceEmbeddings(model_name=EMBEDDING_MODEL)

    Milvus.from_documents(
        chunks,
        embeddings,
        collection_name=COLLECTION_NAME,
        connection_args={"uri": MILVUS_URI},
    )
    print(f"Ingested {len(chunks)} chunks from {len(documents)} documents into '{COLLECTION_NAME}'.")


if __name__ == "__main__":
    ingest()
