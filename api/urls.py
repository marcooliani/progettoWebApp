from django.urls import path, include
from . import views
urlpatterns = [
	path('orders/', views.order_list), # GET
	path('orders/new/', views.order_new), # POST
	path('orders/<str:pk>/', views.order_detail), # GET
	path('orders/update/<str:pk>/', views.order_update), # PUT
	path('orders/delete/<str:pk>/', views.order_delete), # DELETE
]


"""
urlpatterns = [
	path('orders/', views.order_list),
	path('orders/<str:pk>/', views.order_detail),
]
"""
