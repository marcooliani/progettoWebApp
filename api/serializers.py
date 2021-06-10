from rest_framework import serializers
from .models import Orders, Customer, Agents

import logging
logger = logging.getLogger('serializer_logger')

"""
Serializer per gli agenti
"""
class AgentsSerializer(serializers.ModelSerializer):

	class Meta:
		model = Agents
		fields = '__all__'

"""
Serializer per i customer
"""
class CustomerSerializer(serializers.ModelSerializer):

	class Meta:
		model = Customer
		fields = '__all__'

"""
OrdersSerializer()
---
Serializer metodi POST/PUT/DELETE per gli ordini
"""
class OrdersSerializer(serializers.ModelSerializer):
	
	class Meta:
		model = Orders
		fields = '__all__'

"""
OrdersListSerializer()
---
Serializer metodi GET. A differenza del serializer precedente,
questo aggiunge i campi "cust_name" e "agent_name", necessari
per poter visualizzare nella tabella i nomi di agenti e clienti.

NON va bene per la serializzazione in scrittura, in quanto 
passando i dati in POST/PUT/DELETE avrei meno campi da 
serializzare rispetto a quanti ne vuole il serializer, generando
così un errore
"""
class OrdersListSerializer(serializers.ModelSerializer):
	# Recupero i nomi di clienti e agenti utilizzando il metodo
	# di serializzazione SerializerMethodField(): questo metodo cerca
	# all'interno del serializer i metodi get_nomecampo e ne legge
	# il valore di ritorno.
	# Questo è l'unico metodo che ha funzionato, perchè il metodo
	# StringRelatedField(), per quanto io l'abbia richiamato
	# correttamente, ha fallito miseramente...
	cust_name = serializers.SerializerMethodField('get_cust_name')
	agent_name = serializers.SerializerMethodField('get_agent_name')

	class Meta:
		model = Orders
		fields = [
			'ord_num',
			'ord_amount',
			'advance_amount',
			'ord_date',
			'ord_description',
			'cust_code',
			'agent_code',
			'cust_name',
			'agent_name',
		]

	def get_cust_name(self, obj):
		# Questa è bastarda: l'equivalente in SQL è (copio dal log)
		# SELECT "customer"."cust_name" FROM "customer" WHERE "customer"."cust_code" = C00006
		# SELECT "customer"."cust_name" FROM "customer" WHERE "customer"."cust_code" = C00008
		# ... eccetera
		#
		# Lo [0] in fondo alla query serve per estrarre il valore del campo che mi serve: soluzione
		# MOLTO poco elegante, ma funziona e pazienza all'eleganza...
		cname = Customer.objects.filter(cust_code=obj.cust_code_id).values_list('cust_name', flat=True)[0]

		return cname.strip()

	def get_agent_name(self, obj):
		aname = Agents.objects.filter(agent_code=obj.agent_code_id).values_list('agent_name', flat=True)[0]

		# strip() fa il trim della stringa. Sono stato costretto a metterla perchè i dati originali
		# sono proprio scritti male di loro, con una marea di spazi bianchi alla fine del nome
		# (verificare con una query diretta dal prompt di Postgres, se non ci si crede!)
		return aname.strip()

