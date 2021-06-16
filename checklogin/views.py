from django.shortcuts import render, redirect

# Create your views here.
from django.contrib.auth.decorators import login_required
from api.models import Orders, Agents, Customer

# Per il debugging
import logging
logger = logging.getLogger('login_logger')

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

  # Recupero il nome vero dell'utente
  if(request.user.groups.all()[0].name == "customers"):
    nome = Customer.objects.filter(cust_code=request.user.username).values_list('cust_name', flat=True)

  elif(request.user.groups.all()[0].name == "agents"):
    nome = Agents.objects.filter(agent_code=request.user.username).values_list('agent_name', flat=True)

  elif(request.user.groups.all()[0].name == "managers"):
    nome = request.user.username

  # Non capisco perchè nella query per l'ultimo ordine nel
  # db il valore mi venga ritornato direttamente, mentre qui
  # devo accedere con l'indice dell'array. Probabilmente la
  # differenza la fa .last() nell'altra query ( .count()
  # infatti funziona in maniera simile, dà un valore
  # diretto
  request.session['nome'] = nome[0]
  return redirect('/ordini/')
