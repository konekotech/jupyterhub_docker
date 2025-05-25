FROM jupyterhub/jupyterhub:latest

# 環境変数の受け取り
ARG ADMIN_USER
ARG ADMIN_PASS

# インストール処理
RUN apt update && \
    apt upgrade -y && \
    apt install -y curl python3 python3-pip vim git && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt remove -y libnode-dev && \
    apt install -y nodejs && \
    npm install -g configurable-http-proxy && \
    pip3 install --upgrade pip && \
    pip install dotenv jupyterlab jupyter_server

# 管理者ユーザー作成
RUN useradd -m ${ADMIN_USER} && \
    echo "${ADMIN_USER}:${ADMIN_PASS}" | chpasswd
