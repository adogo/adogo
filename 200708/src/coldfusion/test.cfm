<!---<cfdump var="#application#" />--->

<!--- Through a service --->
<cfset authorService = application.serviceFactory.getBean("authorServiceFlex") />
<cfset authorService = application.serviceFactory.getBean("authorServiceAjax") />
<!--- <cfdump var="#authorService#">
<cfdump var="#authorService.get(lastName="Fortuna")#"> 

<cfset test = authorService.create(firstName="TestService", lastName="test") />
<cfdump var="#test#">
--->

<!--->
<cfset reactor = application.serviceFactory.getBean("reactorFactory") />
<cfset author = reactor.createRecord("author") />
<cfset authorTo = reactor.createTo("author") />
<cfdump var="#authorTo#">
<cfset authorTo.firstName = "testFirst" />
<cfset authorTo.lastName = "testLast" /> 
<cfset author._setTo(authorTo) />
<cfset author.save() />
<cfdump var="#author#">--->

<!--- 
<cfset author = authorService.getAuthorRecord() />
<cfset author.setFirstName("Brian") />
<cfset author.setLastName("LeGros") />
<cfset author.save() />

<cfset authors = authorService.getAuthorGateway() />
<cfdump var="#authors.getAll()#">
 --->