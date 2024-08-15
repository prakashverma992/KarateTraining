    @userLists
Feature: Checking reqres users CRUD operations

  Background: 
    Given url userBaseURL
    * def env = TestData
    * def utility = Java.type('examples.utility.UtilHelper')

  Scenario Outline: Register a new multiple user
    * def randomPassword = utility
    * def registerReqPaylaod = read('classpath:examples/demo/' + env + '/registerUser.json')
    * call read('firstKarate.feature@getLists')
    Given path 'api/register'
    And set registerReqPaylaod.email = email
    And set registerReqPaylaod.password = randomPassword.getRandomString(7)
    And request registerReqPaylaod
    When method post
    Then status 200
    And print response
    And match response.id == 7
    And match response.token != null
    Examples: 
      | statusCode | method |
      | 200        | post   |
    
    
    @getLists @ignore
  Scenario: Get list of users
    Given path 'api/users'
    And param page = 2
    When method get
    Then status 200
    And print response
    And print userBaseURL
    And match response.data[0].first_name == 'Michael'
    And def varId = response.data[0].id
    And def firstName = response.data[0].first_name
    And def email = response.data[0].email

    @updateList
  Scenario: Update an existing user
    * def randomString = utility
    * def updateReqPaylaod = read('classpath:examples/demo/' + env + '/updateUser.json')
    * call read('firstKarate.feature@getLists')
    Given path 'api/users',varId
    And set updateReqPaylaod.name = firstName.toLowerCase()
    And set updateReqPaylaod.job = randomString.getRandomString(10)
    And request updateReqPaylaod
    When method put
    Then status 200
    And print response
    And match response.name == 'michael'
    And match response.job != null
    And match response.updatedAt != null

    @registerList
  Scenario: Register a new user
    * def randomPassword = utility
    * def registerReqPaylaod = read('classpath:examples/demo/' + env + '/registerUser.json')
    * call read('firstKarate.feature@getLists')
    Given path 'api/register'
    And set registerReqPaylaod.email = email
    And set registerReqPaylaod.password = randomPassword.getRandomString(7)
    And request registerReqPaylaod
    When method post
    Then status 200
    And print response
    And match response.id == 7
    And match response.token != null

  