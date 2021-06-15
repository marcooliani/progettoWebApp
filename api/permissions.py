from django.contrib.auth.models import User, Group
from rest_framework import permissions

"""
Questa è più una classe di test, che non viene utilizzata nella
view: verifica se l'utente corrente è in un gruppo (qualsiasi).
Le permissions vere sono quelle successive
"""
class IsInGroup(permissions.BasePermission):
	message = 'User must be in a group to perfmorm this action.'

	# Il metodo has_permission() è obbligatorio ed è
	# quello che viene riconosciuto in automatico
	# dal decoratore nella view
	def has_permission(self, request, view):
		if(request.user.groups.exists()):
			return True

"""
CanView: gli utenti appartenenti ai gruppi indicati possono
visualizzare ordini, agenti o clienti presenti nel database 
(in questo caso tutti gliutenti che utilizzano il sito e che sono 
registrati in un gruppo)
"""
class CanView(permissions.BasePermission):
	message = 'Devi essere customer, agent o manager per eseguire l\'operazione'

	def has_permission(self, request, view):

		for g in request.user.groups.all():
			if(g.name == "customers" or g.name == "agents" or g.name == "managers"):
				return True


"""
CanInsertModifyDeleteOrders: gli utenti appartenenti ai gruppi indicati
possono inserire, modificare o cancellare gli ordini (solo agenti e
dirigenti)
"""
class CanInsertModifyDeleteOrders(permissions.BasePermission):
	message = "Devi essere agente o admin per modificare gli ordini"

	def has_permission(self, request, view):

		for g in request.user.groups.all():
			if(g.name == "agents" or g.name == "managers"):
				return True

"""
IsAgent: verifica se un utente è un agente
"""
class IsAgentOrManager(permissions.BasePermission):
	message = "Devi essere agente per eseguire questa operazione"

	def has_permission(self, request, view):
		
		for g in request.user.groups.all():
			if(g.name == "agents" or g.name == "managers"):
				return True

"""
IsManager: verifica se un utente è un dirigente. Potevo anche usare la
IsAdminUser integrata in DRF, ma così tengo separati i miei manager da
eventuali altri manager
"""
class IsManager(permissions.BasePermission):
	message = "Devi essere un dirigente per eseguire questa operazione"

	def has_permission(self, request, view):

		for g in request.user.groups.all():
			if(g.name == "managers"):
				return True
