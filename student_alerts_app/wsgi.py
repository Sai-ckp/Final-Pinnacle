"""
WSGI config for student_alerts_app project.

This module contains the WSGI application used by Django's development server
and any production WSGI deployments. It should expose a module-level variable
named ``application``. Django's ``runserver`` and ``runfcgi`` commands discover
this application via the ``WSGI_APPLICATION`` setting.

Usually you will have the standard Django WSGI application here, but it also
might make sense to replace the whole Django WSGI application with a custom one
that later delegates to the Django one. For example, you could introduce WSGI
middleware here, or combine a Django application with an application of another
framework.

For more information, visit
https://docs.djangoproject.com/en/2.1/howto/deployment/wsgi/
"""


import os
from django.core.wsgi import get_wsgi_application

# Explicitly pick the correct settings file based on Azure env vars
if os.getenv("WEBSITE_HOSTNAME"):  # This is always set in Azure App Service
    settings_module = "student_alerts_app.deployment"
else:
    settings_module = "student_alerts_app.settings"

os.environ.setdefault("DJANGO_SETTINGS_MODULE", settings_module)

application = get_wsgi_application()


