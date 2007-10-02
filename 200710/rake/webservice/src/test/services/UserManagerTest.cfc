<cfcomponent name="UserManagerTest" displayname="UserManagerTest" extends="cfunit.framework.TestCase">

	<cffunction name="setUp" returntype="void" access="public">
		<cfset variables.userManager = CreateObject("component", "services.UserManager").init() />
	</cffunction>
	
	<cffunction name="testAdd" returntype="void" access="public">
		<cfset var addResponse = "" />
      <cfset var newUser = StructNew() />

      <cfset newUser.login="legrosbb" />
      <cfset newUser.pass="newpass" />
      <cfset newUser.first_name="Brian2" />
      <cfset newUser.last_name="LeGros2" />
      <cfset newUser.email="new@adogo.us" />
      
      <cfset addResponse = UserManager.add(argumentCollection = newUser) />
      <cfset assertEquals(actual=addResponse,
                          expected="You have sucessfully added #newUser.first_name# #newUser.last_name# as a user") />
	</cffunction>
	
	<cffunction name="testEdit" returntype="void" access="public">
      <cfset var editResponse = "" />
      <cfset var newUser = StructNew() />
      
      <cfset newUser.id=1 />
      <cfset newUser.login="legrosbb" />
      <cfset newUser.pass="newpass" />
      <cfset newUser.first_name="Brian2" />
      <cfset newUser.last_name="LeGros2" />
      <cfset newUser.email="new@adogo.us" />
      
      <cfset editResponse = UserManager.edit(argumentCollection = newUser) />
      
      <cfset assertEquals(actual=editResponse,
                          expected="You have sucessfully updated #newUser.first_name# #newUser.last_name#") />
	</cffunction>

	<cffunction name="testRemove" returntype="void" access="public">
		<cfset var removeResponse = UserManager.remove(id=1) />
      <cfset assertEquals(actual=removeResponse,
                          expected="You have successfully deleted Brian LeGros") />
	</cffunction>

	<cffunction name="testGet" returntype="void" access="public">
      <cfset var user = UserManager.get(id=1) />
      <cfset assertEquals(actual=user.first_name,
                          expected="Brian") />
	</cffunction>

	<cffunction name="testSearch" returntype="void" access="public">
      <cfset var users = UserManager.search() />
      <cfset assertTrue(condition=(users.recordCount GT 0)) />
	</cffunction>

</cfcomponent>