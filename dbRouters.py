import django
from api.models import Orders, Customer, Agents

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

