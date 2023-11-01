import environ
env = environ.Env()
import os



if os.environ.get('ENV') == 'LOCAL':
    from django_azure.setting.locals_settings import *
else:
    from django_azure.setting.prod_settings import *
