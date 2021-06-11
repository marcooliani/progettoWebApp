from django.shortcuts import render, redirect

# Create your views here.
from django.contrib.auth.decorators import login_required
from base64 import b64encode
from api.models import Orders, Agents, Customer
import requests

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

	return render(request, 'index.html')

@login_required(login_url='/auth/login/')
def dettaglio(request, ordine):
	return render(request, 'dettaglio.html')

@login_required(login_url='/auth/login/')
def nuovo(request):

	# Genero il nuovo ID per l'ordine. Farlo direttamente sul 
	# serializer delle API avrebbe comportato parecchie
	# complicazioni inutili, a mio avviso...
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
def modifica(request, ordine):
	return render(request, 'modifica.html')

@login_required(login_url='/auth/login/')
def elimina(request, ordine):
	pass

