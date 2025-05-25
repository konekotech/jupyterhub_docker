#!/bin/bash

# .env ファイルの読み込み
if [ -f /app/.env ]; then
    source /app/.env
fi

# --- JupyterHub の起動 ---
exec jupyterhub -f /srv/jupyterhub/jupyterhub_config.py

