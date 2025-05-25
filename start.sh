#!/bin/bash

# .env ファイルの読み込み
if [ -f /app/.env ]; then
    source /app/.env
fi

# --- jupyterhub_config.py を生成（上書き） ---
cat <<EOF > /srv/jupyterhub/jupyterhub_config.py
c.Spawner.default_url = '/lab'
c.Spawner.notebook_dir = '/app/notebooks'
c.Authenticator.admin_users = {'$ADMIN_USER'}
c.Authenticator.allowed_users = {'$ADMIN_USER'}
EOF

# --- JupyterHub の起動（設定ファイルはデフォルト位置を使用） ---
exec jupyterhub -f /srv/jupyterhub/jupyterhub_config.py

