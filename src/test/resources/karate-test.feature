@marvel @milmoral
Feature: Marvel Characters API

  Background:
    * configure ssl = true

  Scenario: Obtener todos los personajes OK
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    When method get
    Then status 200
    
  Scenario: Obtener personaje por ID (exitoso)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/616'
    When method get
    Then status 200
    
  Scenario: Obtener personaje por ID (no existe)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/999'
    When method get
    Then status 404
    
  Scenario: Crear personaje (exitoso)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And header Content-Type = 'application/json'
    And request { name: 'milmoral12', alterego: 'Tony Stark', description: 'Genius billionaire', powers: ['Armor', 'Flight'] }
    When method post
    Then status 201
    
  Scenario: Crear personaje (nombre duplicado)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And header Content-Type = 'application/json'
    And request { name: 'Iron Man', alterego: 'Otro', description: 'Otro', powers: ['Armor'] }
    When method post
    Then status 400
    
  Scenario: Crear personaje (faltan campos requeridos)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And header Content-Type = 'application/json'
    And request { name: '', alterego: '', description: '', powers: [] }
    When method post
    Then status 400
    
  Scenario: Actualizar personaje (exitoso)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/579'
    And header Content-Type = 'application/json'
    And request { name: 'milmoral9', alterego: 'Tony Stark', description: 'Updated description', powers: ['Armor', 'Flight'] }
    When method put
    Then status 200
    
  Scenario: Actualizar personaje (no existe)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/999'
    And header Content-Type = 'application/json'
    And request { name: 'Iron Man', alterego: 'Tony Stark', description: 'Updated description', powers: ['Armor', 'Flight'] }
    When method put
    Then status 404
    
  Scenario: Eliminar personaje (exitoso)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/2435'
    When method delete
    Then status 204
    
  Scenario: Eliminar personaje (no existe)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/999'
    When method delete
    Then status 404
