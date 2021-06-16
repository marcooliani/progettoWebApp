from django.urls import path
from . import views

urlpatterns = [
	path('', views.index, name='index'),
	path('<str:pk>/', views.dettaglio),

	#path('nuovo/', views.nuovo),
	#path('modifica/<str:pk>/', views.modifica),
	#path('<str:pk>/', views.elimina),
]
