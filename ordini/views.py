from django.shortcuts import render, redirect

# Create your views here.
from django.contrib.auth.decorators import login_required
from api.models import Orders, Agents, Customer

# Per il debugging
import logging
logger = logging.getLogger('ordini_logger')

"""
Banalmente, i metodi che si occupano delle rispettive
funzionalità della sezione ordini:
- index: visualizza l'indice (in questo caso la lista
degli ordini)
- dettaglio: visualizza il dettaglio di un ordine
- nuovo: inserisci un nuovo ordine
- modifica: modifica un ordine esistente

Manca il metodo "elimina": per quello sfrutto 
direttamente una chiamata all'API da AJAX nella
pagina degli ordini
"""

"""
Lista ordini
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
    'gruppo': request.user.groups.all()[0].name,
  }

  return render(request, 'orders/index.html', context=context)

"""
Dettaglio ordine
ATTENZIONE: alla fine non l'ho implementata perchè pare
non servire a nulla!
"""
@login_required(login_url='/auth/login/')
def dettaglio(request, pk):
  order = Orders.objects

  if(request.user.groups.all()[0].name == "customers"):
    order = order.filter(cust_code=request.user.username)
  elif(request.user.groups.all()[0].name == "agents"):
    order = order.filter(agent_code=request.user.username)

  order = order.select_related('cust_code', 'agent_code').get(pk=pk)

  context = {
    'ordine': order,
  }

  return render(request, 'orders/ordine_singolo.html', context=context)

"""
Nuovo ordine
"""
@login_required(login_url='/auth/login/')
def nuovo(request):
  if(request.user.groups.all()[0].name == "customers"):
    return render(request, '404.html')
    #return redirect('/error/')

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
  # al template (o tutti, se è loggato un manager).
  # In realtà potevo fare la stessa cosa anche sfruttando la API
  # con una chiamata AJAX da JQuery, ma non cambia nulla (anzi,
  # visto che qui non è necessario AJAX è l'opzione più comoda).
  # Dipende da come si vuole fare la cosa, insomma...
  if(request.user.groups.all()[0].name == "agents"):
    customer_list = Customer.objects.filter(agent_code=request.user.username).values('cust_code', 'cust_name').order_by('cust_name')
  elif(request.user.groups.all()[0].name == "managers"):
    customer_list = Customer.objects.values('cust_code', 'cust_name').order_by('cust_name')

  # In realtà non servirebbe nemmeno, anzi, non si dovrebbe per nulla 
  # fare così: la cosa più sensata sarebbe fare una onchange() sulla
  # select del customer lato template e da lì mandare una richiesta
  # AJAX (la GET sul singolo agent su cust_code) per ricavare codice e nome
  # agente, e popolare poi la select di conseguenza. Così invece
  # rischio l'errore se mi va bene, se non l'inconsistenza nel 
  # caso peggiore... 
  if(request.user.groups.all()[0].name == "managers"):
    agent_list = Agents.objects.values('agent_code', 'agent_name').order_by('agent_name')
  else:
    agent_list = ''

  context = {
    'ord_num' : next_ord_num,
    'cust_list': customer_list,
    'agent_list': agent_list,
  }

  return render(request, 'orders/nuovo.html', context=context)

"""
Modifica ordine
"""
@login_required(login_url='/auth/login/')
def modifica(request, pk):
  # Un customer non può accedere a questa pagina. E' vero
  # che se anche lo facesse poi sarebbe bloccato dall'API,
  # però meglio evitare del tutto che ci arrivi...
  if(request.user.groups.all()[0].name == "customers"):
    return render(request, '404.html')
    #return redirect('/error/')

  # Recupero il singolo ordine, più o meno come nel codice delle API,
  # e passo i dati al template
  order = Orders.objects

  #if(request.user.groups.all()[0].name == "customers"):
  # order = order.filter(cust_code=request.user.username)
  if(request.user.groups.all()[0].name == "agents"):
    order = order.filter(agent_code=request.user.username)

  order = order.get(pk=pk)

  if(request.user.groups.all()[0].name == "agents"):
    customer_list = Customer.objects.filter(agent_code=request.user.username).values('cust_code', 'cust_name').order_by('cust_name')
  elif(request.user.groups.all()[0].name == "managers"):
    customer_list = Customer.objects.filter(agent_code=order.agent_code).values('cust_code', 'cust_name').order_by('cust_name')

  # Stesso discorso fatto per l'insert: servirebbe, meglio,
  # una onchange() lato template sulla select del customer
  # facendo una richiesta AJAX e popolando la select dell'agent
  # coi dati corretti...
  if(request.user.groups.all()[0].name == "managers"):
    agent_list = Agents.objects.values('agent_code', 'agent_name').order_by('agent_name')
  else:
    agent_list = ""

  context = {
    'ordine' : order,
    'cust_list': customer_list,
    'agent_list': agent_list,
  }
  
  return render(request, 'orders/modifica.html', context = context)

"""
Come detto sopra, la funzione è definita, ma non implementata
visto che l'eliminazione dell'ordine viene fatta tramite
chiamata diretta all'API
"""
@login_required(login_url='/auth/login/')
def elimina(request, ordine):
  if(request.user.groups.all()[0].name == "customers"):
    return render(request, '404.html')
    #return redirect('/error/')

  pass

