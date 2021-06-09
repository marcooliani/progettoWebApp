from rest_framework import serializers
from .models import Orders, Customer, Agents

import logging
logger = logging.getLogger('serializer_logger')

class AgentsSerializer(serializers.ModelSerializer):

	class Meta:
		model = Agents
		fields = '__all__'

class CustomerSerializer(serializers.ModelSerializer):

	class Meta:
		model = Customer
		fields = '__all__'

class OrdersSerializer(serializers.ModelSerializer):
	
	class Meta:
		model = Orders
		fields = '__all__'

class OrdersListSerializer(serializers.ModelSerializer):
	cust_name = serializers.SerializerMethodField('get_cust_name')

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
		]

	def get_cust_name(self, obj):
		# Questa è bastarda: l'equivalente in SQL è
		# SELECT "customer"."cust_name" FROM "customer" WHERE "customer"."cust_code" = C00006
		# SELECT "customer"."cust_name" FROM "customer" WHERE "customer"."cust_code" = C00008
		# ... eccetera

		cname = Customer.objects.filter(cust_code=obj.cust_code_id).values('cust_name')
		logger.info(cname.query)
		#return serializer.data


