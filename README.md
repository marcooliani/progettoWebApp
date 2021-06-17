# progettoWebApp
## Overview

## API

### Orders

#### - Creating
`POST /api/orders/new/`

Inserisce un nuovo ordine all'interno del database.

**Nota**: l'id dell'ordine nonché chiave primaria, *ord_num*, penso sia da intendere come autoincrementale: in questo caso l'API (o meglio, il relativo serializer) *non* si preoccupa di generare il suddetto id, ma deve essere esplicitamente passato assieme agli altri dati!

##### *Permissions* 
- `IsLogged`: l'utente deve aver effettuato il login per accedere alla risorsa
- `CanInsertModifyDeleteOrders`: l'utente deve far parte dei gruppi predefiniti *agents* oppure *managers* per poter effettuare l'operazione di inserimento.

####  - Reading (orders list)
`GET /api/orders/[?sort_by={[-]column}]`

Ritorna la lista degli ordini. L'output differisce in base all'utente loggato sul sistema:

- se l'utente è di tipo **customer**, viene ritornato l'elenco di tutti gli ordini da lui effettuati, con l'indicazione dell'agent che ha gestito l'ordine;
- se l'utente è di tipo **agent**, viene ritornato l'elenco di tutti gli ordini dei customer da lui gestiti, con l'indicazione dei clienti relativa a ogni ordine;
- se l'utente è di tipo **manager**, viene ritornato l'intero elenco degli ordini presenti, con indicazione di agent e customer per ogni ordine.

##### *Query String Parameters*
`{[-]columm}`: indica la colonna per la quale si desidera l'ordinamento  dei dati. In accordo con la sintassi di Django, il segno `-` davanti al nome della colonna indica un **ordinamento discendente**, mentre il semplice nome indica un **ordinamento ascendente**.

#####  *Returnable Fields*
Per ogni ordine, l'API ritorna i seguenti campi:

- `ord_num` (id dell'ordine) 
- `ord_amount`
- `advance_amount`
- `ord_date`
- `cust_code` (codice del customer che ha effettuato l'ordine)
- `agent_code` (codice dell'agent che gestisce l'ordine)
- `cust_name` (nome del cliente)
- `agent_name` (nome dell'agente)
- `ord_description`

##### *Permissions* 
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `CanView`: l'utente deve far parte di uno dei tre gruppi predefiniti (*customers*, *agents*, *managers*) per poter effettuare l'operazione di visualizzazione.

#### - Reading (single order)
 `GET /api/orders/{ord_num}/`

Ritorna il singolo ordine, indicato per numero d'ordine. 
*`TODO`: migliorare la query affinché un customer non possa visualizzare altri ordini oltre ai propri* 

#####  *Returnable Fields*

- `ord_num` (id dell'ordine) 
- `ord_amount`
- `advance_amount`
- `ord_date`
- `cust_code` (codice del customer che ha effettuato l'ordine)
- `agent_code` (codice dell'agent che gestisce l'ordine)
- `cust_name` (nome del cliente)
- `agent_name` (nome dell'agente)
- `ord_description`

##### *Permissions*
- `IsLogged`: l'utente deve aver effettuato il login per accedere alla risorsa
- `CanView`: l'utente deve far parte di uno dei tre gruppi predefiniti (*customer*. *agents*, *managers*) per poter effettuare l'operazione di visualizzazione. 

####  - Updating
- `PUT /api/orders/update/{ord_num}/`
Aggiorna un ordine, specificato da `{ord_num}`.

##### *Permissions*
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `CanInsertModifyDeleteOrders`: l'utente deve far parte dei gruppi predefiniti *agents* oppure *managers* per poter effettuare l'operazione di aggiornamento.

#### - Deleting
`DELETE /api/orders/delete/{ord_num}/`

Elimina un ordine, specificato da `{ord_num}`.

##### *Permissions*
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `CanInsertModifyDeleteOrders`: l'utente deve far parte dei gruppi predefiniti *agents* oppure *managers* per poter effettuare l'operazione di aggiornamento.

### Customers

#### - Creating
Questa operazione non è disponibile.

#### - Reading (customers list)

`GET /api/customers/[?sort_by={[-]column}]`

Ritorna la lista degli ordini. L'output differisce in base all'utente loggato sul sistema:

- se l'utente è di tipo **customer**, non può visualizzare l'elenco dei clienti
- se l'utente è di tipo **agent**, viene ritornato l'elenco di tutti i customer da lui gestiti
-- se l'utente è di tipo **manager**, viene ritornato l'intero elenco dei customer, con indicazione dell'agent associato

##### *Query String Parameters*
`{[-]columm}`: indica la colonna per la quale si desidera l'ordinamento  dei dati. In accordo con la sintassi di Django, il segno `-` davanti al nome della colonna indica un **ordinamento discendente**, mentre il semplice nome indica un **ordinamento ascendente**.

#####  *Returnable Fields*
Per ogni customer, l'API ritorna i seguenti campi:

- `cust_code` (id del customer) 
- `cust_name`
- `cust_city`
- `working_area`
- `cust_country` 
- `grade` 
- `opening_amt` 
- `receive_amt` 
- `payment_amt`
- `outstanding_amt`
- `phone_no`
- `agent_code`
- `agent_name` (nome dell'agent associato al customer)

##### *Permissions* 
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `IsAgentOrManager`: l'utente deve far parte del gruppo predefinito *agents* oppure *managers* per poter effettuare l'operazione di visualizzazione.

#### - Reading (single customer)
`GET /api/customers/{cust_code}/`

Ritorna il singolo customer, indicato per codice.

#####  *Returnable Fields*
- `cust_code` (id del customer) 
- `cust_name`
- `cust_city`
- `working_area`
- `cust_country` 
- `grade` 
- `opening_amt` 
- `receive_amt` 
- `payment_amt`
- `outstanding_amt`
- `phone_no`
- `agent_code`
- `agent_name` (nome dell'agent associato al customer)

##### *Permissions* 
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `IsAgentOrManager`: l'utente deve far parte del gruppo predefinito *agents* oppure *managers* per poter effettuare l'operazione di visualizzazione.

#### - Updating
Questa operazione non è disponibile.

#### - Deleting
Questa operazione non è disponibile.

### Agents

#### - Creating
Questa operazione non è disponibile.

#### - Reading (agents list)
`GET /api/agents/[?sort_by={[-]column}]`

Ritorna la lista degli agenti. Solo gli utenti di tipo **managers** possono visualizzare la lista completa degli agenti

##### *Query String Parameters*
`{[-]columm}`: indica la colonna per la quale si desidera l'ordinamento  dei dati. In accordo con la sintassi di Django, il segno `-` davanti al nome della colonna indica un **ordinamento discendente**, mentre il semplice nome indica un **ordinamento ascendente**.

#####  *Returnable Fields*
Per ogni agent, l'API ritorna i seguenti campi:

- `agent_code` (id dell'agent)
- `agent_name`
- `working_area`
- `commission`
- `phone_no`
- `country`

##### *Permissions* 
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `IsManager`: l'utente deve far parte del gruppo predefinito *managers* per poter effettuare l'operazione di visualizzazione.
 
#### - Reading (single agent)
`GET /api/agents/{agent_code}/`

Ritorna il singolo customer, indicato per codice.

#####  *Returnable Fields*
Per ogni agent, l'API ritorna i seguenti campi:

- `agent_code` (id dell'agent)
- `agent_name`
- `working_area`
- `commission`
- `phone_no`
- `country`

##### *Permissions* 
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `CanView`: l'utente deve far parte di uno dei tre gruppi predefiniti (*customer*. *agents*, *managers*) per poter effettuare l'operazione di visualizzazione. 
 
#### - Updating
Questa operazione non è disponibile.

#### - Deleting
Questa operazione non è disponibile.



### Sviluppo RESTful API
Ricordarsi di installare Django Rest Framework, se non lo si ha già installato!
pip3 install djangorestframework

### API Test
Utilizzare Postman: https://www.postman.com/downloads/

### Vademecum al volo sui comandi:

- python3 manage.py inspectdb [--database nome_database > myapp/models.py]

Se ho già una base di dati, il comando la ispeziona e ne ricava un model (che potrebbe essere anche da sistemare, nel caso qualcosa non combaciasse). Il risultato lo salvo nel models.py dell'app voluta

- python3 manager.py shell

Questo torna comodo: apre una shell Python, per dare i comandi "on the fly"

- python3 manage.py runserver

Lancia il webserver interno
