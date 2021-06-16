from django.shortcuts import render

# Create your views here.
from django.contrib.auth.decorators import login_required
from api.models import Agents

# Per il debugging
import logging
logger = logging.getLogger('agents_logger')


"""
Lista agents
"""
@login_required(login_url='/auth/login/')
def index(request):
  agent_list = Agents.objects.all().order_by('agent_name')

  context = {
    'agent_list': agent_list,
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
  return render(request, 'agents/index.html', context=context)

"""
Agent singolo
"""
@login_required(login_url='/auth/login/')
def dettaglio(request, pk):
  agent = Agents.objects.get(pk=pk)

  context = {
    'agente': agent,
  }

  return render(request, 'agents/agente_singolo.html', context=context)
