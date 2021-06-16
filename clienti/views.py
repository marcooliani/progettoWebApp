from django.shortcuts import render

# Create your views here.
from django.contrib.auth.decorators import login_required
from api.models import Agents, Customer

# Per il debugging
import logging
logger = logging.getLogger('customer_logger')


"""
Lista customers
"""
@login_required(login_url='/auth/login/')
def index(request):
  customer_list = Customer.objects

  if(request.user.groups.all()[0].name == "agents"):
    customer_list = customer_list.filter(agent_code=request.user.username)

  customer_list = customer_list.all().select_related('agent_code').order_by('cust_name')

  context = {
    'customer_list': customer_list,
    'gruppo': request.user.groups.all()[0].name,
  }

  """
  OCCHIO!! Col fatto che implementando il login ho dovuto modificare
  la direttiva TEMPLATES nel settings.py, Django non va più a cercare
  i file html della directory templates/ dell'app corrente e basta, ma
  fa tutto un calderone delel varie directory templates/ sparse in 
  giro per il progetto (quelle in ogni app e quella "generale"),
  considerandola di fatto una directory unica. Se due pagine 
  all'interno della dir templates/ di due app diverse hanno lo stesso
  nome, tipo appunto "index.html", Django fa casino e prende la
  prima creata (o comunque una non corretta, come in questo caso.
  La soluzione, come si può vedere, è annidare ulteriormente i file
  html delle singole app, dato che a quanto pare la ricerca che fa
  Django non è ricorsiva...
  """
  return render(request, 'customers/index.html', context=context)

"""
Customer singolo
"""
@login_required(login_url='/auth/login/')
def dettaglio(request, pk):
  customer = Customer.objects

  if(request.user.groups.all()[0].name == "agents"):
    customer = customer.filter(agent_code=request.user.username)

  customer = customer.select_related('agent_code').get(pk=pk)

  context = {
    'cliente': customer,
  }

  return render(request, 'customers/cliente_singolo.html', context=context)
