from django.contrib.auth.models import User, Group
from rest_framework import permissions

class IsInGroup(permissions.BasePermission):
	message = 'User must be in a group to perfmorm this action.'

	# Il metodo has_permission() è obbligatorio ed è
	# quello che viene riconosciuto in automatico
	# dal decoratore nella view
	def has_permission(self, request, view):
		if(request.user.groups.exists()):
			return True

class CanViewOrders(permissions.BasePermission):
	message = 'Sei un customer, non puoi visualizzare.'

	def has_permission(self, request, view):

		for g in request.user.groups.all():
			if(g.name == "customers" or g.name == "agents" or g.name == "managers"):
				return True


class CanInsertModifyDeleteOrders(permissions.BasePermission):
	message = "Devi essere agente o admin per modificare gli ordini"

	def has_permission(self, request, view):

		for g in request.user.groups.all():
			if(g.name == "agents" or g.name == "managers"):
				return True

