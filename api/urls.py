from django.urls import path, include
from . import views

urlpatterns = [
  # Orders APIs
  path('orders/', views.order_list), # GET
  path('orders/new/', views.order_new), # POST
  path('orders/<str:pk>/', views.order_detail), # GET (singolo)
  path('orders/update/<str:pk>/', views.order_update), # PUT
  path('orders/delete/<str:pk>/', views.order_delete), # DELETE

  # Agents APIs
  path('agents/', views.agent_list), # GET
  path('agents/new/', views.agent_new), # POST
  path('agents/<str:pk>/', views.agent_detail), # GET (singolo)
  path('agents/update/<str:pk>/', views.agent_update), # PUT
  path('agents/delete/<str:pk>/', views.agent_delete), # DELETE

  # Customers APIs
  path('customers/', views.customer_list), # GET
  path('customers/new/', views.customer_new), # POST
  path('customers/<str:pk>/', views.customer_detail), # GET (singolo)
  path('customers/update/<str:pk>/', views.customer_update), # PUT
  path('customers/delete/<str:pk>/', views.customer_delete), # DELETE
]

