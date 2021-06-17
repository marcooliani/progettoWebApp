"""progetto URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include, re_path
from django.views.generic import RedirectView
from django.conf import settings
from django.conf.urls.static import static

"""
"Riabilita" la direttiva {% load static %} quando DEBUG=False
in settings.py. A quanto pare la gestione automatica degli
statics non è una pratica corretta in produzione, ma si può
fare un'eccezione ad esempio se l'app ha poco traffico o cose
del genere (cercare meglio in Rete!). La configurazione qui
sotto può essere usata anche su webserver di produzione (non 
solo quello di test integrato), però con tutte le cautele 
del caso...
"""
from django.contrib.staticfiles.views import serve as serve_static

def _static_butler(request, path, **kwargs):
  return serve_static(request, path, insecure=True, **kwargs)

urlpatterns = [
  path('admin/', admin.site.urls), # Admin
  path('api/', include('api.urls')), # API
  path('auth/', include('django.contrib.auth.urls')), # Login
  path('ordini/', include('ordini.urls')), # Ordini
  path('clienti/', include('clienti.urls')), # Clienti
  path('agenti/', include('agenti.urls')), # Clienti
  path('checklogin/', include('checklogin.urls')), # Controllo post login
  path('error/', include('error.urls')), # Gestione errori
  path('', RedirectView.as_view(url='/checklogin/')), # Home
  re_path(r'static/(.+)', _static_butler) # Gestione file statici con DEBUG=False
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
