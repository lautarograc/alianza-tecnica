En Aliada, se tiene el problema que te presentaremos a continuación. Diseña un sistema que lo resuelva. 
  
Al momento de que los usuarios solicitan un servicio del limpieza, dicho servicio necesita asignarse a una  Aliada (así llamamos a las personas que trabajan en la plataforma). Esta asignación se da considerando multiples variables: 

* Disponibilidad de tiempo. Para manejar los horarios de las Aliadas utilizamos un array con registros de tiempo (en formato ISO 8601 https://en.wikipedia.org/wiki/ISO_8601) que tienen la siguiente forma: 

### Event
(type === Puede ser 'service' o 'travel y siempre dura 1 hora)
```json    
      {
          "type": "service"'
          "service_id": "bd351e0f-f2f8-4687-9008-b4184a855442",
          "start": "2022-05-19T10:00:00.000Z", 
          "end": "2022-05-19T13:00:00.000Z"
        }
```

Para validar que el servicio puede ser asignado a una cierta Aliada, es necesario validar si la hora de inicio y la hora de fin de ese servicio no se empalma con ninguno de los eventos que la Aliada tiene ya asignados esa Alida. Tenemos 2 tipos de eventos. El evento "service" y el evento "travel". 
Ambos representan un un espacio de tiempo de inicio a fin. Que nos permite saber si la Aliada ya tiene  ese espacio de tiempo ocupado y por ende no se puede asignar ese servicio en ese espacio de tiempo para esa Aliada. 

Cuando un servicio es solicitado por un usuario. El servicio igualmente tiene una hora de inicio y una  hora de finalización. El servicio llega con el siguiente formato: 

### Servicio solicitado por un usuario
```json
        {
          "id": "11ab5a01-5bec-4752-a068-1bf87963ec64",
          "date_program": "2022-05-19T10:00:00.000Z",
          "duration": 3
        }
```

Donde el campo "date_program" es la fecha y hora de inicio del servicio. Y "duration" es la duración en horas de dicho servicio.


### aliada-asignacion.json

```json
[
  {
    "name": "Marta Eugenia Pastrana",
    "id": "bea5316b-52b1-4305-bdae-a7fe8e66d2af",
    "schedule": {
      "2023-01-08": [
        {
          "type": "service",
          "service_id": "bd351e0f-f2f8-4687-9008-b4184a855442",
          "start": "2023-01-08T12:00:00.000Z",
          "end": "2023-01-08T15:00:00.000Z"
        },
        {
          "type": "travel",
          "service_id": "bd351e0f-f2f8-4687-9008-b4184a855443",
          "start": "2023-01-08T15:00:00.000Z",
          "end": "2023-01-08T16:00:00.000Z"
        },
        {
          "type": "service",
          "service_id": "bd351e0f-f2f8-4687-9008-b4184a855444",
          "start": "2023-01-08T16:00:00.000Z",
          "end": "2023-01-08T19:00:00.000Z"
        }
      ],
      "2023-01-09": [
        {
          "type": "service",
          "service_id": "bd351e0f-f2f8-4687-9008-b4184a855441",
          "start": "2023-01-09T12:00:00.000Z",
          "end": "2023-01-09T15:00:00.000Z"
        },
        {
          "type": "travel",
          "service_id": "bd351e0f-f2f8-4687-9008-b4184a845442",
          "start": "2023-01-09T15:00:00.000Z",
          "end": "2023-01-09T16:00:00.000Z"
        },
        {
          "type": "service",
          "service_id": "bd351e0f-f2f8-4687-9008-b4184a955442",
          "start": "2023-01-09T16:00:00.000Z",
          "end": "2023-01-09T19:00:00.000Z"
        }
      ]
    }
  },
  {
    "name": "Ana Luisa Martinez",
    "id": "2ffefc24-39dc-4072-b333-d51aea7bb91a",
    "schedule": {
      "2023-01-08": [
        {
          "type": "service",
          "service_id": "88b7da08-160e-4016-8b74-07893a2f29f1",
          "start": "2023-01-08T16:00:00.000Z",
          "end": "2023-01-08T19:00:00.000Z"
        }
      ],
      "2023-01-09": [

      ]
    }
  },
  {
    "name": "Sandra Mancilla Sánchez",
    "id": "66511ab1-4d54-41bd-871b-599200707d21",
    "schedule": {
      "2023-01-08": [
        {
          "type": "service",
          "service_id": "091fb402-889a-46be-96ac-209e141dfee6",
          "start": "2023-01-08T12:00:00.000Z",
          "end": "2023-01-08T15:00:00.000Z"
        },
        {
          "type": "travel",
          "start": "2023-01-08T15:00:00.000Z",
          "end": "2023-01-08T16:00:00.000Z"
        },
        {
          "type": "service",
          "service_id": "21151a08-1880-4b17-b75e-1daeb0347d52",
          "start": "2023-01-08T16:00:00.000Z",
          "end": "2023-01-08T19:00:00.000Z"
        }
      ],
      "2023-01-09": [
        {
          "type": "service",
          "service_id": "44be306c-891c-42ed-beea-d2d0b23c95c5",
          "start": "2023-01-09T12:00:00.000Z",
          "end": "2023-01-09T15:00:00.000Z"
        }
      ]
    }
  },
  {
    "name": "Alejandra Sanchez Cruz",
    "id": "68528aa0-7393-43e9-876a-3823cf34decc",
    "schedule": {
      "2023-01-08": [
        {
          "type": "service",
          "service_id": "920ca46f-0db2-4154-ae0b-5fbea643a8cd",
          "start": "2023-01-08T17:00:00.000Z",
          "end": "2023-01-08T18:00:00.000Z"
        }
      ],
      "2023-01-09": [
        {
          "type": "service",
          "service_id": "569a2c60-1989-4ad1-9e44-12f155d2b299",
          "start": "2023-01-09T10:00:00.000Z",
          "end": "2023-01-09T13:00:00.000Z"
        }
      ]
    }
  }
]
```
