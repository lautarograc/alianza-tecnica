# Prueba técnica

## Reto

En Aliada, se tiene (hipotéticamente) el problema que te presentaremos a continuación. Diseña un sistema que lo resuelva. 
  
En el momento en que los usuarios de la plataforma solicitan un servicio de limpieza nuestro equipo de operaciones revisa la disponibilidad de nuestras Aliadas (así llamamos a las personas que trabajan en la plataforma) y realiza la asignación manual del servicio para cumplir al cliente. Sin embargo, debido al alto flujo de solicitudes y la cantidad de Aliadas disponibles, la asignación se ha convertido en un problema operacional que toma horas, y en muchos casos genera reprocesos e incumplimientos. 

Por lo anterior, se quiere montar un sistema de asignación automática que permita liberar tiempo al equipo de operaciones y preocuparse por otras tareas igual de importantes.

El resultado principal es tener un par de endpoints. El primero que reciba un servicio y que se encargue de todo el proceso de asignación, y el segundo, que permita consultar el calendario de una o varias Aliadas.

## Contexto

Los horarios de las Aliadas se manejan a través de un array de eventos con registros de tiempo (en formato ISO 8601 https://en.wikipedia.org/wiki/ISO_8601) que contienen la siguiente información:

#### Evento
```json 
  {
    "type": "service",
    "service_id": "bd351e0f-f2f8-4687-9008-b4184a855442",
    "start": "2022-05-19T10:00:00.000Z", 
    "end": "2022-05-19T13:00:00.000Z"
  }
```

El tipo del evento puede ser: 'service' o 'travel'. Para mayor facilidad asume que los tiempos de viaje siempre son de una (1) hora.

Para validar que el servicio puede ser asignado a una Aliada, es necesario validar si la hora de inicio y la hora de fin de ese servicio no se empalma con ninguno de los eventos que la Aliada tiene ya asignados. Tenemos 2 tipos de eventos: el evento "service" y el evento "travel". 
Ambos representan un espacio de tiempo de inicio a fin. Que nos permite saber si la Aliada ya tiene  ese espacio de tiempo ocupado y por ende no se puede asignar ese servicio en ese espacio de tiempo para esa Aliada. 

---

Cuando un servicio es solicitado por un usuario el servicio igualmente tiene una hora de inicio y una hora de finalización. El servicio llega con el siguiente formato: 

#### Servicio solicitado por un usuario
```json
        {
          "id": "11ab5a01-5bec-4752-a068-1bf87963ec64",
          "date_program": "2022-05-19T10:00:00.000Z",
          "duration": 3
        }
```

Donde el campo "date_program" es la fecha y hora de inicio del servicio. Y "duration" es la duración en horas de dicho servicio.

---

El calendario de todas las Aliadas de la plataforma tiene el siguiente formato:

#### aliada-timetable.json

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

## Entregables

Un repositorio privado con la solución planteada, que utilice el repositorio actual como base de la solución. Es importante que tengas en cuenta que es una aplicación en Docker, con una versión de Ruby y Rails predefinida.

Adicionalmente, debes entregar un documento que incluya toda la información necesaria para entender el proyecto.

## Nota adicional

El tiempo de entrega es definido por el ingeniero que toma la prueba pero es inamovible. 

El documento debe presentarse al menos con 24h de antelación a la socialización de la solución.