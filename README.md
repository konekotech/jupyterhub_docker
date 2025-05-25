# JupyterHub Docker


## How to use

### 1. Copy .env.sample to .env

```bash
cp .env.sample .env
```

### 2. Edit .env

```.env
ADMIN_USER=your_admin_username
ADMIN_PASS=your_admin_password
```

### 3. Build the Docker image

```bash
docker compose up -d 
```

### 4. Access JupyterHub

Open your web browser and go to:

```
http://localhost:8001
```

### 5. If you want to add more users

You can add users by editing the `users` section in the `.env` file. For example:

```.env
NEW_USER_1=username1
NEW_USER_1_PASS=password1
```

Then, add the environment variables to the `compose.yml` file:

```yaml
environment:
  - NEW_USER_1=${NEW_USER_1}
  - NEW_USER_1_PASS=${NEW_USER_1_PASS}
```

Then, add the user to `Dockerfile`:

```dockerfile
# add this next to the existing ARG lines in the Dockerfile
ARG NEW_USER_1
ARG NEW_USER_1_PASS

...
# add this line to the last section of the Dockerfile
RUN adduser -m ${NEW_USER_1} && \
    echo "${NEW_USER_1}:${NEW_USER_1_PASS}" | chpasswd
```

Then, add the user to the `jupyterhub_config.py` file:

```python
# add this next to the existing user
new_user_1 = dotenv.get_key('/app/.env', 'NEW_USER_1')

...
# add this line to the end of the jupyterhub_config.py file
c.Authenticator.allowed_users.append(new_user_1)
```

Then, rebuild the Docker image:

```bash
docker compose up --build -d
```
