## Resuelve Test

El app para resolver el test está expuesta como un API con 2 Endpoints
> POST /api/v1/search

Este recibe un JSON como parámetro alá Rails así:
```json
{
  "search" : {
    "external_id" : "8672e846-9c89-4dbf-a1cc-b85a2da5abe1",
    "start": "2017-01-01",
    "finish": "2017-01-01" 
  }
}
```
El retorno de este end_point es un http_status: Created 201 y json así:
```json
{
  "search_id" : 1
}
```
Este search_id es el que se debe utilizar para consultar el resultado de una búsqueda
> Esta decisión se tomó ya que el llamado puede tardar mucho y no debería hacerse en línea, sino en un worker y después consultar su respuesta

El segundo end_point es: 
> GET /api/v1/search_result/:search_id

El retorno de este end_point es in http_status: OK 200 y un json así:
```json
{
  "result" : "Working ó el número de facturas",
  "num_external_calls": 3,
  "id" : "8672e846-9c89-4dbf-a1cc-b85a2da5abe1",
  "start": "2017-01-01",
  "finish": "2017-01-01",
  "time_spent_in_miliseconds": 1233
}
```
En ambos endpoints si existe un error, se devolverá un http_status Bad Request 400 y mensaje de error así:

```json
{
  "error" : "Descripción del error"
}
```

## APP de prueba
También se creó un app de prueba que puede ser accedida por medio del root de este repositorio

En donde se hace un query por una simple interfaz web. 

Estas 2 apps están live en ambiente de "producción" con deploy en heroku en: https://resuelve-test.herokuapp.com

## Detalles de implementación

Todos los llamados se registran en una db Postgres, esto pensando en un futuro utilizarlo para crear mejores heurísticas con la recolección de los datos que se hacen en cada búsqueda. En el app web, se puede ver el detalle de todos los llamados realizados.

## TODOs
*Se puede mejorar el app creando en el modelo Scrap una forma de hacer la heurística algo en una interfaz ó en una clase qeu se deje heredar para cambiar la heurística utilizada al hacer los llamados.

*Cambiar el servidor web, por ahora está Unicorn

*Se podría cancelar los loggeos a la DB para hacer que el algorítmo sea más rápido.

*Completar tests

*Arreglar dependencies

## TDD

Solo se uso TDD para la creación de los Endpoints, pero tuve problemas al hacerlos exaustos. Se pueden ejecutar con:
> rspec spec/requests/searches_spec.rb
