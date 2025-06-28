@appcontact_createcontact
Feature: create contact to app contact

  Background:
    * url baseUrl
    * header Accept = 'application/json'
Scenario: Login y crear contacto
  # Login
  Given path '/users/login'
  And request { "email": "juan@test.com", "password": "juan123" }
  When method POST
  Then status 200
  * def authToken = response.token

  Feature: Crear contacto con datos aleatorios

Scenario: Generar contacto con email, teléfono y código postal aleatorio

  # Generar email aleatorio, phone aleatorio y postalcode aleatorio
  * def randomEmail = 'user' + java.util.UUID.randomUUID() + '@udea.edu.co'
  * def randomPhone = '' + Math.floor(1000000000 + Math.random() * 9000000000).toFixed(0)
  * def randomPostal = '' + Math.floor(10000 + Math.random() * 90000).toFixed(0)

  # Data con los datos generados
  * def contactoData =
  """
  {
    "firstName": "Andres",
    "lastName": "UDEA",
    "birthdate": "1970-01-01",
    "email": "#(randomEmail)",
    "phone": "#(randomPhone)",
    "street1": "1 Main St.",
    "street2": "Apartment A",
    "city": "Anytown",
    "stateProvince": "KS",
    "postalCode": "#(randomPostal)",
    "country": "USA"
  }
  """

  # Crear contacto y vaidar info
  Given path '/contacts'
  And header Authorization = 'Bearer ' + authToken
  And request contactoData
  When method POST
  Then status 201
  And match response ==
    """
    {
      "_id": "#string",
      "firstName": "#string",
      "lastName": "#string",
      "birthdate": "#string",
      "email": "#string",
      "phone": "#string",
      "street1": "#string",
      "street2": "#string",
      "city": "#string",
      "stateProvince": "#string",
      "postalCode": "#string",
      "country": "#string",
      "owner": "#string",
      "__v": "#number"
    }
    """
