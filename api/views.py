from django.shortcuts import render

from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.authentication import SessionAuthentication, BasicAuthentication

from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser 
from rest_framework import status

from .models import Orders, Customer, Agents
from .serializers import OrdersSerializer, CustomerSerializer, AgentsSerializer

# Mi importo le classi contententi le definizioni delle permissions 
# dal file permissions.py
from .permissions import CanViewOrders, CanInsertModifyDeleteOrders
from rest_framework.permissions import IsAuthenticated

# Per il debugging
import logging
logger = logging.getLogger('api_logger')

"""
--------------
ORDERS APIs
--------------
Gestione degli ordini. Regole:
- un customer può solo visualizzare i proprio ordini (lista o singoli)
- un agent può visualizzare, modificare o cancellare gli ordini da 
lui gestiti (ma non quelli altrui)
- un manager può vedere, modificare o cancellare tutti gli ordini

NOTA: l'uso dei decoratori e della view function based invece di quella
class based è una scelta puramente personale: in questo modo ho una
visione più immediata di quello che la mia view va a fare e ho meno
difficoltà anche nella configurazione di api/urls.py
"""
@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanViewOrders])
def order_list(request):

	if(request.method == 'GET'):
		orders = Orders.objects

		# Controllo in che gruppo è l'utente: in base a quello decido il filtro
		# sulla query (se è "customers" visualizzo tutti gli ordini del cliente,
		# se "agents" visualizzo tutti gli ordini dei clienti destiti dall'agente
		for g in request.user.groups.all():
			if(g.name == "customers"):
				orders = orders.filter(cust_code=str(request.user))
			elif(g.name == "agents"):
				orders = orders.filter(agent_code=str(request.user))

		# .all() non sarebbe nemmeno necessario, in verità
		orders = orders.all().order_by('ord_num')

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
		order = Orders.objects

		for g in request.user.groups.all():
			if(g.name == "customers"):
				order = order.filter(cust_code=str(request.user))
			elif(g.name == "agents"):
				order = order.filter(agent_code=str(request.user))

		order = order.get(pk=pk)

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
		order = Orders.objects

		for g in request.user.groups.all():
			if(g.name == "agents"):
				order = order.filter(agent_code=str(request.user))

		order = order.get(pk=pk)

		logger.info("Ho trovato l'ordine")

	except Orders.DoesNotExist:
		return JsonResponse({'message': 'Order does not exist'}, status=status.HTTP_404_NOT_FOUND)

	if(request.method == 'PUT'):
		order_data = JSONParser().parse(request)
		logger.info("PUT: Sono dopo il parser")
		order_serializer = OrdersSerializer(order, data=order_data)
		logger.info("PUT: Sono dopo il serializer")

		if(order_serializer.is_valid()):
			logger.info("PUT: Serializer valido")
			order_serializer.save()

			return JsonResponse(order_serializer.data)

		return JsonResponse(order_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanInsertModifyDeleteOrders])
def order_delete(request, pk):
	try:
		order = Orders.objects

		for g in request.user.groups.all():
			if(g.name == "agents"):
				order = order.filter(agent_code=str(request.user))

		order = order.get(pk=pk)

	except Orders.DoesNotExist:
		return JsonResponse({'message': 'Order does not exist'}, status=status.HTTP_404_NOT_FOUND)

	if(request.method == 'DELETE'):
		order.delete()

		return JsonResponse({'message': 'Order successfully deleted'}, status=status.HTTP_204_NO_CONTENT)


"""
---------------
AGENTS APIs
---------------
Gestione degli agenti. Regole:
- un customer può visualizzare gli agenti che hanno gestito i suoi ordini
- un agente puù visualizzare la lista degli agenti e modificare i suoi
stessi dati (tranne l'id, mi sa)
- un manager può visualizzare, modificare e cancellare qualsiasi agente
"""
@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def agent_list(request):
	if(request.method == 'GET'):
		agents = Agents.objects.all().order_by('agent_code')
		agents_serializer = AgentsSerializer(agents, many=True)

		return JsonResponse(agents_serializer.data, safe=False)

@api_view(['POST'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def agent_new(request):
	pass

@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def agent_detail(request, pk):
	try:
		agent = Agents.objects.get(pk=pk)

	except Agents.DoesNotExists:
		return JsonResponse({'message': 'Agent does not exist'}, status=status.HTTP_404_NOT_FOUND)

	if(request.method == 'GET'):
		agent_serializer = AgentsSerializer(agent)

		return JsonResponse(agent_serializer.data)	

@api_view(['PUT'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def agent_update(request, pk):
	pass

@api_view(['DELETE'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def agent_delete(request, pk):
  pass


"""
------------------
CUSTOMER APIs
------------------
Gestione dei clienti. Regole:
- un customer può vedere e modificare solo se stesso
- un agent può visualizzare, modificare o aggiungere 
un customer
- un manager può fare tutto ciò che fa l'agent, più
la cancellazione dei customer
"""
@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def customer_list(request):
	if(request.method == 'GET'):
		customers = Customer.objects.all().order_by('cust_code')
		customers_serializer = CustomerSerializer(customers, many=True)

		return JsonResponse(customers_serializer.data, safe=False)

@api_view(['POST'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def customer_new(request):
	pass

@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def customer_detail(request, pk):
	try:
		customer = Customer.objects.get(pk=pk)

	except Customer.DoesNotExists:
		return JsonResponse({'message': 'Customer does not exist'}, status=status.HTTP_404_NOT_FOUND)

	if(request.method == 'GET'):
		customer_serializer = CustomerSerializer(customer)

		return JsonResponse(customer_serializer.data)	

@api_view(['PUT'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def customer_update(request, pk):
	pass

@api_view(['DELETE'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def customer_delete(request, pk):
  pass

