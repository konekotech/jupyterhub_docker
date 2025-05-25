import dotenv

admin_user = dotenv.get_key('/app/.env', 'ADMIN_USER')

c.Spawner.default_url = '/lab'
c.Spawner.notebook_dir = '/app/notebooks'
c.Authenticator.admin_users = {admin_user}
c.Authenticator.allowed_users = {admin_user}

