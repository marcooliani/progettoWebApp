# progettoWebApp
## Overview





## API

### Orders

#### \# Creating
```http
POST /api/orders/new/
```

Inserisce un nuovo ordine all'interno del database.

**Nota**: l'id dell'ordine nonché chiave primaria, *ord_num*, penso sia da intendere come autoincrementale: in questo caso l'API (o meglio, il relativo serializer) *non* si preoccupa di generare il suddetto id, ma deve essere esplicitamente passato assieme agli altri dati!

##### *Permissions* 
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `CanInsertModifyDeleteOrders`: l'utente deve far parte dei gruppi predefiniti *agents* oppure *managers* per poter effettuare l'operazione di inserimento.

####  \# Reading (orders list)
```http
GET /api/orders/[?sort_by={[-]column}]
```

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

#### \# Reading (single order)
```http
GET /api/orders/{ord_num}/
```

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
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `CanView`: l'utente deve far parte di uno dei tre gruppi predefiniti (*customer*. *agents*, *managers*) per poter effettuare l'operazione di visualizzazione. 

####  \# Updating
```http
PUT /api/orders/update/{ord_num}/
```

Aggiorna un ordine, specificato da `{ord_num}`.

##### *Permissions*
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `CanInsertModifyDeleteOrders`: l'utente deve far parte dei gruppi predefiniti *agents* oppure *managers* per poter effettuare l'operazione di aggiornamento.

#### \# Deleting
```http
DELETE /api/orders/delete/{ord_num}/
```

Elimina un ordine, specificato da `{ord_num}`.

##### *Permissions*
- `IsAuthenticated`: l'utente deve aver effettuato il login per accedere alla risorsa
- `CanInsertModifyDeleteOrders`: l'utente deve far parte dei gruppi predefiniti *agents* oppure *managers* per poter effettuare l'operazione di aggiornamento.



### Customers

#### \# Creating
_Questa operazione non è disponibile._

#### \#Reading (customers list)

```http
GET /api/customers/[?sort_by={[-]column}]
```

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

#### \# Reading (single customer)
```http
GET /api/customers/{cust_code}/
```

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

#### \# Updating
_Questa operazione non è disponibile._

#### \# Deleting
_Questa operazione non è disponibile._



### Agents

#### \# Creating
_Questa operazione non è disponibile._

#### \# Reading (agents list)
```http
GET /api/agents/[?sort_by={[-]column}]
```

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

#### \# Reading (single agent)
```http
GET /api/agents/{agent_code}/
```

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

#### \# Updating
_Questa operazione non è disponibile._

#### \# Deleting
_Questa operazione non è disponibile._



### API Testing
Per il **testing delle AP**I ho utilizzato **Postman**: [https://www.postman.com/downloads/][https://www.postman.com/downloads/] . 

Questo tool si è dimostrato molto potente ed efficiente, nonché facile da utilizzare. Di contro, necessita di un account (gratuito) e non zippato pesa oltre 400 MB 



## WCAG 2.1 AA Testing

Per i **test di accessibilità WCAG 2.1** ho utilizzato `a11y-sitechecker` ([https://github.com/forsti0506/a11y-sitechecker][https://github.com/forsti0506/a11y-sitechecker]). 

Dopo l'installazione, configurare il tool editando `~/node_modules/a11y-sitechecker/lib/utils/setup-config.js`. La configurazione non è esattamente delle più intuitive, ad ogni modo quella usata per testare il progetto è la seguente, all'interno della funzione `setupConfig()` :

```javascript
const config = {
    json: true,
    resultsPath: '/home/marcuzzo/UniVr/WebApp/progetto/WCAG21aa-test/results',
    resultsPathPerUrl: '', 
    axeConfig: {}, 
    threshold: 1000,
    imagesPath: '/home/marcuzzo/UniVr/WebApp/progetto/WCAG21aa-test/results/images',
    timeout: 30000,
    debugMode: false,
    viewports: [
    	{
        	width: 1920,
         	height: 1080,
      	},
   	],
    resultTypes: ['violations', 'incomplete'],
    runOnly: ['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa', 'best-practice', 'ACT'],
    crawl: false,
    name: '', 
    urlsToAnalyze: ['http://3.143.240.119:8000/ordini/', 'http://3.143.240.119:8000/ordini/200123/', 'http://3.143.240.119:8000/clienti/C00022/'],
    login: {
        url: 'http://3.143.240.119:8000/auth/login/',
        steps: [
       		{
           		input: [
                    {
                        selector: '#id_username',
                        value: "C00022"
                    },
                    {
                        selector: '#id_password',
                        value: 'clientecliente'
                    }
                ],
                submit: '#sendlogin'
            }
        ]
      }   
    };
```



Come si nota dalla configurazione, dovendo garantire il **livello AA** per le pagine accessibili ai clienti si sono testate:

-  la **pagina principale** della sezione **ordini**
- la pagina che mostra **i dettagli di un singolo ordine** (appartenente al cliente)
- la pagina che mostra **i dati del cliente stesso**, accessibile dalla navbar in alto a destra

I **test effettuati** sono specificati dalla direttiva `runOnly`, mentre alla direttiva `resultTypes` sono specificati i tipi di risultato che verranno restituiti.

Dato che la webapp richiede l'**accesso dell'utente**, alla direttiva `login` ho impostato le credenziali di uno dei clienti (ne ho preso uno con più di un ordine effettuato, così da avere più elementi visualizzati sulla pagina e quindi un testing più accurato).

Una volta terminata la configurazione, **lanciare il sitechecker** spostandosi in  `~/node_modules/a11y-sitechecker/bin/` e dando il comando `./a11y-sitechecker.js -T=1000`

I risultati verranno salvati in formato JSON all'interno della directory _WCAG21aa-test/results_ per i risultati testuali e _WCAG21aa-test/results/images_ per le immagini (ricordarsi di creare le directory prima, altrimenti i dati non verranno salvati).

Per riguarda il progetto in questione, **tutti i test** relativi alle linee guida _WCAG 2.1_ inerenti al livello _AA_ **sono stati superati**. L'unica _violation_ riguarda una _best practice_, precisamente relativa all'_heading_: tale violazione, però, non inficia sull'accessibilità della webapp sviluppata.



## Recap comandi:

- python3 manage.py inspectdb [--database nome_database > myapp/models.py]

Se ho già una base di dati, il comando la ispeziona e ne ricava un model (che potrebbe essere anche da sistemare, nel caso qualcosa non combaciasse). Il risultato lo salvo nel models.py dell'app voluta

- python3 manager.py shell

Questo torna comodo: apre una shell Python, per dare i comandi "on the fly"

- python3 manage.py runserver

Lancia il webserver interno
