# Rendering worker — headless Chromium (Playwright) + Apache FOP.
# Built with internet access, runs air-gapped (NFR 5.1).
FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        openjdk-17-jre-headless \
        wget \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Apache FOP
ENV FOP_VERSION=2.9
RUN wget -q https://downloads.apache.org/xmlgraphics/fop/binaries/fop-${FOP_VERSION}-bin.tar.gz \
    && tar -xzf fop-${FOP_VERSION}-bin.tar.gz -C /opt \
    && mv /opt/fop-${FOP_VERSION} /opt/fop \
    && ln -s /opt/fop/fop /usr/local/bin/fop \
    && rm fop-${FOP_VERSION}-bin.tar.gz

WORKDIR /app
COPY middleware/requirements.txt middleware-requirements.txt
COPY rendering/requirements.txt rendering-requirements.txt
RUN pip install --no-cache-dir -r middleware-requirements.txt -r rendering-requirements.txt \
    && playwright install --with-deps chromium

COPY middleware/ ./middleware/
COPY queue/ ./queue/
COPY rendering/ ./rendering/

CMD ["python", "-m", "queue.consumer"]
