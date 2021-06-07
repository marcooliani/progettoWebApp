from django.shortcuts import render

from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser 
from rest_framework import status
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.permissions import IsAuthenticated

from .models import Orders, Customer, Agents
from .serializers import OrdersSerializer, CustomerSerializer, AgentsSerializer
from rest_framework.decorators import api_view, authentication_classes, permission_classes

# Mi importo le classi contententi le definizioni delle permissions 
# dal file permissions.py
from .permissions import CanViewOrders, CanInsertModifyDeleteOrders

import logging

logger = logging.getLogger('api_logger')

"""
L'uso dei decoratori e della view function based invece di quella
class based è una scelta puramente personale: in questo modo ho una
visione più immediata di quello che la mia view va a fare e ho meno
difficoltà anche nella configurazione di api/urls.py
"""
@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanViewOrders])
def order_list(request):

	if(request.method == 'GET'):
		# orders = Orders.objects.using('dati').filter(cust_code=str(request.user)).order_by('ord_num')
		#orders = Orders.objects.using('dati')
		orders = Orders.objects

		# Controllo in che gruppo è l'utente: in base a quello decido il filtro
		# sulla query (se è "customers" visualizzo tutti gli ordini del cliente,
		# se "agents" visualizzo tutti gli ordini dei clienti destiti dall'agente
		for g in request.user.groups.all():
			if(g.name == "customers"):
				orders = orders.filter(cust_code=str(request.user)).order_by('ord_num')
			elif(g.name == "agents"):
				orders = orders.filter(agent_code=str(request.user)).order_by('ord_num')

		orders_serializer = OrdersSerializer(orders, many=True)
		logger.info("Serializer GET: " + str(orders_serializer))

		return JsonResponse(orders_serializer.data, safe=False)
		# safe=False for objects serialization


@api_view(['POST'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanInsertModifyDeleteOrders])
def order_new(request):

	if(request.method == 'POST'):

		order_data = JSONParser().parse(request)
		logger.info('order_data POST: ' + str(order_data))
		order_serializer = OrdersSerializer(data=order_data)
		logger.info('order_serializer POST: ' + str(order_serializer))

		logger.info('Prima di is_valid')
		if(order_serializer.is_valid()):
			logger.info(order_serializer.is_valid())
			logger.info('Valida!')
			order_serializer.save()

			return JsonResponse(order_serializer.data, status=status.HTTP_201_CREATED)

		logger.info('Serializzazione non valida e non so perchè!')
		return JsonResponse(order_serializer.error, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanViewOrders])
def order_detail(request, pk):
	try:
		#order = Orders.objects.using('dati').get(pk=pk)
		order = Orders.objects.get(pk=pk)

	except Orders.DoesNotExist:
		return JsonResponse({'message': 'Order does not exist'}, status=status.HTTP_404_NOT_FOUND)

	if(request.method == 'GET'):
		order_serializer = OrdersSerializer(order)

		return JsonResponse(order_serializer.data)


@api_view(['PUT'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanInsertModifyDeleteOrders])
def order_update(request, pk):
	try:
		#order = Orders.objects.using('dati').get(pk=pk)
		order = Orders.objects.get(pk=pk)
		logger.info("Ho trovato l'ordine")

	except Orders.DoesNotExist:
		return JsonResponse({'message': 'Order does not exist'}, status=status.HTTP_404_NOT_FOUND)

	if(request.method == 'PUT'):
		order_data = JSONParser().parse(request)
		logger.info("Sono dopo il parser")
		order_serializer = OrdersSerializer(order, data=order_data)
		logger.info("Sono dopo il serializer")

		if(order_serializer.is_valid()):
			logger.info("HAHAHA")
			order_serializer.save()

			return JsonResponse(order_serializer.data)

		return JsonResponse(order_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanInsertModifyDeleteOrders])
def order_delete(request, pk):
	try:
		#order = Orders.objects.using('dati').get(pk=pk)
		order = Orders.objects.get(pk=pk)

	except Orders.DoesNotExist:
		return JsonResponse({'message': 'Order does not exist'}, status=status.HTTP_404_NOT_FOUND)

	if(request.method == 'DELETE'):
		order.delete()

		return JsonResponse({'message': 'Order successfully deleted'}, status=status.HTTP_204_NO_CONTENT)

