from django.urls import path
from . import views

urlpatterns = [
	# index della mia app
	path('', views.index, name='index'),

	# A quanto pare conta l'ordine: se metto prima
	# l'endpoint del dettaglio dell'ordine rispetto
	# a quello del nuovo, mi dà errore...
	path('nuovo/', views.nuovo, name='nuovo'),
	path('<str:pk>/', views.dettaglio, name='dettagli'),
	path('modifica/<str:pk>/', views.modifica, name='modifica'),
]
