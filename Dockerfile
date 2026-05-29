# Dockerfile for running Codex CLI in an isolated container
# ----------------------------------------------------------
# ベースイメージは軽量な Debian 系の Python イメージを使用します。
FROM python:3.12-slim

# 必要なシステムパッケージをインストール（例: git, curl）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl && \
    rm -rf /var/lib/apt/lists/*

# Codex CLI のバージョンを指定し、公式配布 URL からバイナリを取得します。
ARG CODEX_VERSION=1.0.0
RUN curl -L -o /usr/local/bin/codex "https://example.com/codex-${CODEX_VERSION}-linux-amd64" && \
    chmod +x /usr/local/bin/codex

# 作業ディレクトリを /app に設定（ホスト側のプロジェクトフォルダをここにマウントします）
WORKDIR /app

# デフォルトは対話シェル。必要に応じてエントリポイントを変更してください。
ENTRYPOINT ["/bin/bash"]
