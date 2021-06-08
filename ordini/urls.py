from django.urls import path
from . import views

urlpatterns = [
	# index della mia app
	path('', views.check_grp),
	path('index/', views.index, name='index'),
	path('dettaglio/<str:pk>/', views.dettaglio, name='dettagli'),
	path('nuovo/', views.nuovo, name='nuovo'),
	path('modifica/<str:pk>/', views.modifica, name='modifica'),
]
