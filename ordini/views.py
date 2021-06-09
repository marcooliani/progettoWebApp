from django.shortcuts import render, redirect

# Create your views here.
from django.contrib.auth.decorators import login_required
from base64 import b64encode
import requests

"""
Verifico in quale gruppo è l'utente e setto una variabile
di sessione, che mi servirà per definire poi varie cose
all'interno del template.
Fatto questo, redirigo il tutto alla vera index dell'app
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
	return render(request, 'nuovo.html')

@login_required(login_url='/auth/login/')
def modifica(request, ordine):
	return render(request, 'modifica.html')

@login_required(login_url='/auth/login/')
def elimina(request, ordine):
	pass

