from rest_framework import serializers
from rest_framework.validators import UniqueValidator


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

		logger.info("Model usato: " + str(model))
