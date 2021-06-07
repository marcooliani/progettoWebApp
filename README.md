# progettoWebApp

#### Sviluppo RESTful API
Ricordarsi di installare Django Rest Framework, se non lo si ha già installato!
pip3 install djangorestframework

### API Test
Utilizzare Postman: https://www.postman.com/downloads/

###Vademecum al volo sui comandi:

- python3 manager.py inspectdb [--database nome_database > myapp/models.py]

Se ho già una base di dati, il comando la ispeziona e ne ricava un model (che potrebbe essere anche da sistemare, nel caso qualcosa non combaciasse). Il risultato lo salvo nel models.py dell'app voluta

- python3 manager.py shell

Questo torna comodo: apre una shell Python, per dare i comandi "on the fly"

- python3 manager.py runserver

Lancia il webserver interno
