
<!--- <cfset userFactory = createObject("component","UserFactory").init() />
<cfset application.userfactory = userFactory /> --->

<cfset UserManager = CreateObject("component","UserManager") />

<h2>Get all</h2>
<cfset users = UserManager.search() />
<cfdump var="#users#">

<h2>Add</h2>
<cfset add = UserManager.add(login="afortuna",first_name="Adam",last_name="test2",email="test@adogo.us",url="http://test",pass="no") />
<cfset users = UserManager.search() />
<cfdump var="#add#">
<cfdump var="#users#">

<h2>Get</h2>
<cfset first = UserManager.get(id=1) />
<cfdump var="#first#">

<h2>Edit</h2>
<cfset UserManager.edit(id=1,login="afortuna",first_name="Adam",last_name="test2",email="test@adogo.us",url="http://test",pass="no") />
<cfset first = UserManager.get(id=1) />
<cfdump var="#first#">

<h2>Delete</h2>
<cfset first = UserManager.remove(first.id) />
<cfdump var="#first#">
<cfset users = UserManager.search() />
<cfdump var="#users#">



