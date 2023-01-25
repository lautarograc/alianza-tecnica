# Prueba técnica

## Importante: Esta repo se encuentra protegida bajo la licencia [CC-BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/2.0/). El uso comercial o privado del código agregado es un delito de IP.

### Sobre el proyecto:

Se crean 2 modelos: Aliada y Event. El modelo Aliada tiene solo un atributo de nombre y una relación has_many con Event. Event tiene de atributos *type_is*, *starts*, *ends* y *service_id* (service_id **no actúa como PK**).

Al crearse un Event (mediante un POST), se toma como default el tipo "service" y adicional se crea un par de tipo "travel" que comienza una hora antes y termina un minuto antes que el service. Luego, se llama a un worker de sidekiq para realizar la asignación a una Aliada. Las aliadas se consideran según un array de names:[] enviados en el POST: Si no se envía ningún array de names, se va a considerar a todas las Aliadas. En caso de que ninguna Aliada tenga espacio para ambos eventos, no se asignará a nadie (idea: un schedule podría resolver ese problema, corriendo un worker para cada evento no-asignado cada determinado tiempo).

Tambien se puede asignar manualmente mediante un post al endpoint /events/:service_id/assign_event.

Los endpoints habilitados son:
## GET

`INDEX /aliadas?include_calendar=true ` ` curl --location --request GET 'http://localhost:3000/aliadas?include_calendar=true' \
--header 'Content-Type: application/json' \
--data-raw ''`

`SHOW /aliadas/:id?include_calendar=true ` ` curl --location --request GET 'http://localhost:3000/aliadas/1?include_calendar=true' \
--header 'Content-Type: application/json' \
--data-raw ''`

## POST

`POST /aliadas` `curl --location --request POST 'http://localhost:3000/aliadas?include_calendar=true' \
--header 'Content-Type: application/json' \
--data-raw '{"aliada":{"name":"Lautaro Graciani"}}'`

`POST /events ` `curl --location --request POST 'http://localhost:3000/events' \
--header 'Content-Type: application/json' \
--data-raw '{"event":{  "id": "11ab5a01-5bec-4752-068-1b7963e64",
    "date_program": "2022-05-19T15:00:00.000Z",
    "duration": 3,
    "names":["Lionel Messi", "Lautaro Martín"]
}}'`

`POST /events/:service_id/assign_event` `curl --location --request POST 'http://localhost:3000/events/11ab5a01-5bec-4752-068-1b7963e64/assign_event' \
--header 'Content-Type: application/json' \
--data-raw ''`

`POST /events/:service_id/unassign_event` `curl --location --request POST 'http://localhost:3000/events/11ab5a01-5bec-4752-068-1b7963e64/unassign_event' \
--header 'Content-Type: application/json' \
--data-raw ''`

Nota: El último endpoint /unassign_event no fue testeado pero debería funcionar.

## Importante:

Como yo no trabajo gratis y ya le dediqué demasiado tiempo a este entregable, debo notar que quedaron varios pendientes: hice cero error handling, falta documentación, faltan tests, no llegué a resolver performance ni readability y varias cosas quedaron muy clumsy. Si se desea solucionar eso, podemos generar algún contacto para arreglar los rates de mi tiempo, en otro caso, no planeo tocar código aquí.
