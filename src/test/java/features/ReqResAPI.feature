Feature: Check API Details 

Background:
	* url appUrl
	* header Accept-Encoding = 'gzip,deflate'
	* header Connection = 'Keep-Alive'
@reqres			
Scenario Outline: Check API Status code
	Given path "<paths>"
	Then method get
	Then status <statuscode>
Examples:
|paths              |statuscode|	
|/api/users/2       |200       |
|/api/unknown       |200       |

@reqres	
Scenario: Check Single User Response contains User First Name as Janet
	Given path '/api/users/2'
	And def expectedFirstName = 'Janet'
	Then method get
	Then status 200
	And def userRespose = response
	Then def actualFirstName = userRespose.data.first_name
	Then assert expectedFirstName == actualFirstName

@reqres	
Scenario: Check Json Array contains name fuchsia rose
	Given path '/api/unknown'
	Then method get
	Then status 200
	Then match $.data[*].name contains ["fuchsia rose"]	

@reqres
Scenario: Check User Created using POST Call
	Given path '/api/users'
	And request { "name": "morpheus" , "job": "leader" }
	Then method post
	Then status 201
	Then match $.name contains 'morpheus'
	Then def createdAt = $.createdAt 
	Then def id = $.id
	Then print 'Request Created at:', createdAt
	Then print 'ID is :', id

@reqres	
Scenario: Check User Resistraction Unsuccessful due to insufficient request
    Given path '/api/register'
    And request { "email": "sydney@fife" }
    And method post 
    Then status 400
    And match $.error == '#present'
    Then def errorString = $.error
    And print 'Error is: ', errorString	

@reqres   
Scenario: Check Successful User registraction
	Given path '/api/login'
	And request { "email": "eve.holt@reqres.in" , "password": "cityslicka" }
	And method post
	Then status 200
	And match $.token == '#present'
	Then def tokenNum = $.token
	And print 'Token Number is:', tokenNum     
	