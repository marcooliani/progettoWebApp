from django.shortcuts import render
import json
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.authentication import SessionAuthentication, BasicAuthentication

from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser 
from rest_framework import status

from .models import Orders, Customer, Agents
from .serializers import OrdersSerializer, CustomerSerializer, AgentsSerializer, OrdersListSerializer

from django.views.decorators.csrf import csrf_protect

# Mi importo le classi contententi le definizioni delle permissions 
# dal file permissions.py
from .permissions import CanView, CanInsertModifyDeleteOrders, IsAgentOrManager, IsManager
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

"""
GET order_list()

Visualizza la lista degli ordini. Permissions:
- clienti: possono vedere i propri ordini, ma non quelli altri
- agenti: possono visualizzare gli ordini da loro gestiti, ma non
quelli gestiti da altri agenti
- manager: possono vedere l'elenco completo degli ordini
"""
@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanView])
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

		# La differenza tra all() e values() dovrebbe essere che all() ritorna 
		# oggetti contenenti i record, values() direttamente i valori.
		# Nota: avrei voluto aggiungere un .defer() in fondo per escludere
		# il campo cust_code o agent_code a seconda di chi è loggato, ma
		# il serializer non accetta che ci sia un campo in meno (giustamente).
		# Quindi farò il filtro lato client, se mi riesce...
		#
		# Edit: la select(related) permette di fare l'inner join con 
		# Agents e Customer per recuperare poi, nel serializer, i nomi.
		# Devo però, appunto, passare i dati al serializer...
		orders = orders.all().select_related('cust_code', 'agent_code')

		# Leggo il parametro extra per l'ordinamento in base alle colonne.
		# Hint per la chiamata in JQuery: per l'ordinamento discentente è 
		# sufficiente mettere un "-" davanti al campo nell'url!
		# Es: http://127.0.0.1/api/orders/?sort_by=-ord_date
		# Per l'ordinamento ascendente, invece, come al solito
		# ?sort_by=ord_date
		sort_by = request.GET.get('sort_by', '-ord_date');

		orders = orders.order_by(sort_by)

		# Serializzo i dati ottenuti con la query e li restituisco sotto
		# forma di risposta JSON
		#orders_serializer = OrdersSerializer(orders, many=True)
		orders_serializer = OrdersListSerializer(orders, many=True)

		return JsonResponse(orders_serializer.data, safe=False)
		# safe=False serve per la serializzazione


"""
POST order_new()
Inserisce un nuovo ordine all'interno della tabella ordini. Permissions:
- clienti: non possono eseguire questa operazione
- agenti e manager: possono inserire nuovi ordini
"""
@api_view(['POST'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanInsertModifyDeleteOrders])
def order_new(request):

	if(request.method == 'POST'):

		"""
		Ok, il punto è questo: devo bypassare JSONParser() altrimenti
		la mia request.data proveniente dalla chiama Ajax NON 
		ne vuole sapere di funzionare, per quanto il contenuto sia
		esattamente identico a quello inviato tramite Postman
		(provato con gli stessi dati!). Così al serializzatore do
		in pasto direttamente i dati "grezzi" della request.data
		e non i dati "puliti" passati sotto JSONParser().
		Ritengo tutto ciò letteralmente ASSURDO!
		C'è da dire che i dati sono comunque già in formato
		JSON corretto, quindi in questo caso il parser è superfluo
		nel momento in cui la richiesta arriva da Ajax o da Postman,
		coi dati preparati ad hoc. E' anche vero che l'API è fatta
		apposta per accettare i dati solo in JSON e non in 
		form-encoded o altre codifiche da form...
		"""
		#order_data = JSONParser().parse(request)
		#order_serializer = OrdersSerializer(data=order_data)

		order_serializer = OrdersSerializer(data=request.data)

		if(order_serializer.is_valid()):
			order_serializer.save()

			return JsonResponse(order_serializer.data, status=status.HTTP_201_CREATED)

		logger.info('Serializzazione non valida e non so perchè!')
		return JsonResponse(order_serializer.error, status=status.HTTP_400_BAD_REQUEST)

"""
GET order_detail()

Visualizza il singolo ordine. Permissions:
- clienti: possono visualizzare il singolo ordine se effettuato da loro.
NON possono visualizzare gli ordini effettuati da altri clienti!
- agenti: possono visualizzare il singolo ordine se gestito da loro.
NON possono visualizzare gli ordini gestiti da altri agenti!
- manager: possono visualizzare qualsiasi ordine singolo
"""
@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanView])
def order_detail(request, pk):
	
	# Verifico che l'ordine esista. Se esiste, controllo a chi appartiene
	# ed eseguo la query
	try:
		order = Orders.objects

		for g in request.user.groups.all():
			if(g.name == "customers"):
				order = order.filter(cust_code=str(request.user))
			elif(g.name == "agents"):
				order = order.filter(agent_code=str(request.user))

		#order = order.get(pk=pk)
		order = order.select_related('cust_code', 'agent_code').get(pk=pk)

	# Se l'ordine non viene trovato, restituisco un errore 404
	except Orders.DoesNotExist:
		return JsonResponse({'message': 'Order does not exist'}, status=status.HTTP_404_NOT_FOUND)

	# Serializzo i dati e li restituisco in forma di risposta JSON
	if(request.method == 'GET'):
		#order_serializer = OrdersSerializer(order)
		order_serializer = OrdersListSerializer(order)

		return JsonResponse(order_serializer.data)

"""
PUT order_update()

Modifica un ordine esistente. Permissions:
- clienti: non possono aggiornare i loro ordini
- agenti: possono modificare solo gli ordini da loro gestiti
- manager: possono modificare tutti gli ordini
"""
@api_view(['PUT'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanInsertModifyDeleteOrders])
def order_update(request, pk):

	# Come per il metodo precedente 
	try:
		order = Orders.objects

		for g in request.user.groups.all():
			if(g.name == "agents"):
				order = order.filter(agent_code=str(request.user))

		order = order.get(pk=pk)

	except Orders.DoesNotExist:
		return JsonResponse({'message': 'Order does not exist'}, status=status.HTTP_404_NOT_FOUND)

	# Faccio il parsing dei dati ricevuti, dopo di che serializzo i dati.
	# se la serializzazione effettuata è valida, scrivo i dati nel 
	# database e aggiorno l'ordine
	if(request.method == 'PUT'):
		"""
		Vale lo stesso discorso fatto per il metodo POST: JSONParser() deve
		essere bypassato anche qui, dato che pure in questo caso i dati
		provengono da AJAX...
		"""
		#order_data = JSONParser().parse(request)
		#order_serializer = OrdersSerializer(order, data=order_data)
		order_serializer = OrdersSerializer(order, data=request.data)

		if(order_serializer.is_valid()):
			order_serializer.save()

			# Si poterbbe restituire anche un semplice messaggio
			return JsonResponse(order_serializer.data)

		# Se la serializzazione non è valida, viene ritornata una bad request
		return JsonResponse(order_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

"""
DELETE order_delete()

Cancella un ordine dal database. Permissions:
- clienti: non possono cancellare ordini
- agenti: possono cancellare un ordine, se gestito da loro. NON possono
cancellare ordini gestiti da altri agenti
- manager: possono cancellare qualsiasi ordine
"""
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
@permission_classes([IsAuthenticated, IsManager])
def agent_list(request):
	if(request.method == 'GET'):
		agents = Agents.objects.all().order_by('agent_code')
		agents_serializer = AgentsSerializer(agents, many=True)

		return JsonResponse(agents_serializer.data, safe=False)

@api_view(['POST'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, IsManager])
def agent_new(request):
	pass

@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, CanView])
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
@permission_classes([IsAuthenticated, IsAgentOrManager])
def agent_update(request, pk):
	pass

@api_view(['DELETE'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, IsManager])
def agent_delete(request, pk):
  pass


"""
------------------
CUSTOMER APIs
------------------
Gestione dei clienti. Regole:
- un customer può vedere e modificare solo se stesso
- un agent può visualizzare, modificare o aggiungere un customer
- un manager può fare tutto ciò che fa l'agent, più la cancellazione 
dei customer
"""
@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, IsAgentOrManager])
def customer_list(request):
	if(request.method == 'GET'):
		customers = Customer.objects

		for g in request.user.groups.all():
			if(g.name == "agents"):
				customers = customers.filter(agent_code=str(request.user))

		customers = customers.all().select_related('agent_code')
		sort_by = request.GET.get('sort_by', 'cust_name');
		customers = customers.order_by(sort_by)

		customers_serializer = CustomerSerializer(customers, many=True)

		return JsonResponse(customers_serializer.data, safe=False)

@api_view(['POST'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, IsAgentOrManager])
def customer_new(request):
	pass

@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, IsAgentOrManager])
def customer_detail(request, pk):
	try:
		customer = Customer.objects.select_related('agent_code').get(pk=pk)

	except Customer.DoesNotExists:
		return JsonResponse({'message': 'Customer does not exist'}, status=status.HTTP_404_NOT_FOUND)

	if(request.method == 'GET'):
		customer_serializer = CustomerSerializer(customer)

		return JsonResponse(customer_serializer.data)	

@api_view(['PUT'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, IsAgentOrManager])
def customer_update(request, pk):
	pass

@api_view(['DELETE'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated, IsManager])
def customer_delete(request, pk):
  pass

