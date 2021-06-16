from django.urls import path
from . import views

urlpatterns = [
	# index della mia app
	path('', views.check_grp),
]
