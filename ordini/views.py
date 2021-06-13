from django.shortcuts import render, redirect

# Create your views here.
from django.contrib.auth.decorators import login_required
from api.models import Orders, Agents, Customer

# Per il debugging
import logging
logger = logging.getLogger('ordini_logger')

"""
Verifico in quale gruppo è l'utente e setto una variabile
di sessione, che mi servirà per definire poi varie cose
all'interno del template.
Fatto questo, redirigo il tutto alla vera index dell'app.

Il decoratore @login_required() specifica che per eseguire
questa operazione è necessario che l'utente sia loggato: se
non lo è, viene rediretto alla pagina di login
"""
@login_required(login_url='/auth/login/')
def check_grp(request):
	# Un po' grezza, ma col for come nelle API non me lo dava...
	request.session['gruppo'] = request.user.groups.all()[0].name
	request.session['utente'] = request.user.username

	return redirect(index)

"""
Banalmente, i metodi che si occupano delle rispettive
funzionalità della sezione ordini:
- index: visualizza l'indice (in questo caso la lista
degli ordini)
- dettaglio: visualizza il dettaglio di un ordine
- nuovo: inserisci un nuovo ordine
- modifica: modifica un ordine esistente

Manca il metodo "elimina": devo capire meglio come
sfruttare l'api in modo che ritorni all'index...
"""
@login_required(login_url='/auth/login/')
def index(request):
	order_list = Orders.objects

	if(request.user.groups.all()[0].name == "customers"):
		order_list = order_list.filter(cust_code=request.user.username)
	elif(request.user.groups.all()[0].name == "agents"):
		order_list = order_list.filter(agent_code=request.user.username)

	order_list = order_list.all().select_related('cust_code', 'agent_code').order_by('-ord_date')

	#logger.info(str(order_list.query))

	context = {
		'order_list': order_list,
	}

	return render(request, 'index.html', context=context)

@login_required(login_url='/auth/login/')
def dettaglio(request, ordine):
	return render(request, 'dettaglio.html')

@login_required(login_url='/auth/login/')
def nuovo(request):

	# Genero il nuovo ID per l'ordine. In realtà questo modo di 
	# fare, in un caso reale, non sarebbe corretto, perchè porterebbe
	# a problemi di concorrenza (duplicate key). A livello si API la
	# cosa si potrebbe risolvere a livello di serializers, creandone
	# uno ex novo che gestisca le richieste POST o modificando quello
	# esistente in base alla richiesta ricevuta e sovrascrivendo il
	# campo ord_num. Ma dato che si tratta un mero progettino universitario
	# va bene anche così, credo..
	last_ord_num = Orders.objects.values_list('ord_num', flat=True).order_by('ord_num').last()
	next_ord_num = last_ord_num + 1

	# Recupero l'elenco dei customer gestiti dall'agent per passarli 
	# al template.
	# In realtà potevo fare la stessa cosa anche sfruttando la API
	# con una chiamata AJAX da JQuery, ma non cambia nulla (anzi,
	# visto che qui non è necessario AJAX è l'opzione più comoda).
	# Dipende da come si vuole fare la cosa, insomma...
	customer_list = Customer.objects.filter(agent_code=request.user.username).values('cust_code', 'cust_name').order_by('cust_name')

	context = {
    'ord_num' : next_ord_num,
		'cust_list': customer_list,
  }

	return render(request, 'nuovo.html', context=context)

@login_required(login_url='/auth/login/')
def modifica(request, pk):
	# Recupero il singolo ordine, più o meno come nel codice delle API
	order = Orders.objects

	if(request.user.groups.all()[0].name == "customers"):
		order = order.filter(cust_code=request.user.username)
	elif(request.user.groups.all()[0].name == "agents"):
		order = order.filter(agent_code=request.user.username)

	order = order.get(pk=pk)

	customer_list = Customer.objects.filter(agent_code=request.user.username).values('cust_code', 'cust_name').order_by('cust_name')

	context = {
		'ordine' : order,
		'cust_list': customer_list,
	}
	
	return render(request, 'modifica.html', context = context)

@login_required(login_url='/auth/login/')
def elimina(request, ordine):
	pass

