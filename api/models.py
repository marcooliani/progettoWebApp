# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models

class Agents(models.Model):
	agent_code = models.CharField(primary_key=True, max_length=6)
	agent_name = models.CharField(max_length=40, blank=True, null=True)
	working_area = models.CharField(max_length=35, blank=True, null=True)
	commission = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
	phone_no = models.CharField(max_length=15, blank=True, null=True)
	country = models.CharField(max_length=25, blank=True, null=True)

	class Meta:
		managed = False
		db_table = 'agents'

	def __str__(self):
		return str(self.agent_code)

class Customer(models.Model):
	cust_code = models.CharField(primary_key=True, max_length=6)
	cust_name = models.CharField(max_length=40)
	cust_city = models.CharField(max_length=35, blank=True, null=True)
	working_area = models.CharField(max_length=35)
	cust_country = models.CharField(max_length=20)
	grade = models.DecimalField(max_digits=1, decimal_places=0, blank=True, null=True)
	opening_amt = models.DecimalField(max_digits=12, decimal_places=2)
	receive_amt = models.DecimalField(max_digits=12, decimal_places=2)
	payment_amt = models.DecimalField(max_digits=12, decimal_places=2)
	outstanding_amt = models.DecimalField(max_digits=12, decimal_places=2)
	phone_no = models.CharField(max_length=17)
	agent_code = models.ForeignKey(Agents, models.DO_NOTHING, db_column='agent_code')

	class Meta:
		managed = False
		db_table = 'customer'

	def __str__(self):
		return str(self.cust_code)

class Orders(models.Model):
	ord_num = models.DecimalField(primary_key=True, max_digits=6, decimal_places=0)
	ord_amount = models.DecimalField(max_digits=12, decimal_places=2)
	advance_amount = models.DecimalField(max_digits=12, decimal_places=2)
	ord_date = models.DateField()
	cust_code = models.ForeignKey(Customer, models.DO_NOTHING, db_column='cust_code')
	agent_code = models.ForeignKey(Agents, models.DO_NOTHING, db_column='agent_code')
	ord_description = models.CharField(max_length=60)

	class Meta:
		managed = False
		db_table = 'orders'

	def __str__(self):
		return str(self.ord_num)

