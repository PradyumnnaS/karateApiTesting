Feature: GoRestGo API Validation

Background: 
	* url appUrl
	* header Accept-Encoding = 'gzip,deflate'
	* header Authorization = 'Bearer AvCnP2_vbd3WQAvFOVL887LUw6d7WFCOTVaD'
@Gorestgo	
Scenario: Create a User in GoRestGo 
	
	Given path '/public-api/users'
	And request { 'first_name' : 'Pradyumnna', 'last_name' : 'Satapathy', 'gender' : 'male', 'dob' : '1993-07-19', 'email' : 'prad.sat@gmail.com', 'phone' : '0101010101', 'address' : 'examples address', 'website' : 'https://exampels.com', 'status' : 'active' } 
	And method post
	Then status 200
	Then match $._meta !contains { 'success': false }
@Gorestgo	
Scenario: Check User Present or not Named Pradyumnna
	Given path '/public-api/users'
	And param first_name = 'Pradyumnna'	
	And method get
	Then status 200
	Then match $.result[*].first_name contains ['Pradyumnna']
	