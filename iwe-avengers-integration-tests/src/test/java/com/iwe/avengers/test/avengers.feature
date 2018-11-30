Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://4r0rh8hgzd.execute-api.us-east-1.amazonaws.com/dev'


Scenario: Should return invalid access
Given path 'avengers', 'any-id'
When method get
Then status 401


Scenario: Get by Id should return not found Avenger 
Given path 'avengers', 'not-found-id'
When method get
Then status 404


Scenario: Delete should return not found Avenger 
Given path 'avengers', 'not-found-id'
When method delete
Then status 404


Scenario: Create Avenger
Given path 'avengers'
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
When method get
Then status 200
And match response == savedAvenger


Scenario: Must return 400 for invalid creation payload
Given path 'avengers'
And request {secretIdentity: 'Tony Stark'}
When method post
Then status 400


Scenario: Update Avenger
Given path 'avengers'
And request {name: 'Iron', secretIdentity: 'Tony'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron', secretIdentity: 'Tony'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method put
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

* def updatedAvenger = response

Given path 'avengers', updatedAvenger.id
When method get
Then status 200
And match response == updatedAvenger


Scenario: Must return 400 for invalid update payload
Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
And request {secretIdentity: 'Tony Stark'}
When method put
Then status 400


Scenario: Update should return not found avenger
Given path 'avengers', 'not-found-id'
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method put
Then status 404


Scenario: Delete Avenger by Id
Given path 'avengers'
And request {name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
When method delete
Then status 204

Given path 'avengers', savedAvenger.id
When method get
Then status 404
