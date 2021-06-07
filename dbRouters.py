import django
from api.models import Orders, Customer, Agents

"""
Classe di routing per decidere su quale database andare
a leggere/scrivere in base al model utilizzato. Inutile se
si lavora su una sola base di dati, fondamentale se si 
utilizzano due o più database contemporaneamente, evita
molti problemi e permette di scrivere un codice molto più
pulito e lineare!

Nota: per rendere effettivo il routing, impostare la 
direttiva DATABASE_ROUTERS in miaapp/settings.py in
questo modo:

DATABASE_ROUTERS = ['nomefile.nomeclasse', 'nomefile.nomeclasse2', ...]
"""
class dbRouters(object):
	def db_for_read(self, model, **hints):
		if(model == Orders or model == Agents or model == Customer):
			return 'dati'
		else:
			return 'default'

	def db_for_write(self, model, **hints):
		if(model == Orders or model == Agents or model == Customer):
			return 'dati'
		else:
			return 'default'

