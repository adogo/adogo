<cfcomponent displayname="UserManager">

   <cffunction name="init" access="public" returntype="UserManager">
      <cfset var userFactory = createObject("component","UserFactory").init() />
      <cfset userFactory.reset() />
      <cfreturn this />
   </cffunction>

	<!--- ADD A NEW USER FUNCTION --->
	<cffunction name="add" access="remote" returntype="string">
		<cfargument name="login" required="yes" type="string" />
		<cfargument name="pass" required="yes" type="string" />
		<cfargument name="first_name" required="yes" type="string" />
		<cfargument name="last_name" required="yes" type="string" />
		<cfargument name="email" required="yes" type="string" />
		<cfargument name="url" required="no" type="string" />
		<cfset var userFactory = createObject("component","UserFactory").init() />

		<cfset userFactory.add(argumentCollection = arguments) />
		
		<cfreturn "You have sucessfully added #arguments.first_name# #arguments.last_name# as a user" />
	</cffunction>
	
	<!--- UPDATE A USER FUNCTION  --->
	<cffunction name="edit" access="remote" returntype="string">
		<cfargument name="id" required="yes" type="numeric" />
		<cfargument name="login" required="yes" type="string" />
		<cfargument name="pass" required="yes" type="string" />
		<cfargument name="first_name" required="yes" type="string" />
		<cfargument name="last_name" required="yes" type="string" />
		<cfargument name="email" required="yes" type="string" />
		<cfargument name="url" required="no" type="string" />
		
		<cfset var userFactory = createObject("component","UserFactory").init() />
		<cfset userFactory.edit(argumentCollection = arguments) />

		<cfreturn "You have sucessfully updated #arguments.first_name# #arguments.last_name#" />
	</cffunction>
		
	<!--- DELETE A USER FUNCTION --->
	<cffunction name="remove" access="remote" returntype="string" >
		<cfargument name="id" required="yes" type="numeric" />

		<cfset var userFactory = createObject("component","UserFactory").init() />
		<cfset var deletedUser = userFactory.search(argumentCollection = arguments) />
		<cfset userFactory.delete(argumentCollection = arguments) />

		<cfreturn "You have successfully deleted #deletedUser.first_name# #deletedUser.last_name#" />
	</cffunction>
	
	<!--- DISPLAY USER INFO ON EDIT SCREEN --->
	<cffunction name="get" access="remote" returntype="struct" >
		<cfargument name="id" required="yes" type="numeric" />
		<cfset var userFactory = createObject("component","UserFactory").init() />
		<cfset var foundUser = userFactory.search(argumentCollection = arguments) />
		<cfset var column = "" />
		<cfset var returnUser =  StructNew() />
		
		<!--- Convert the query to a struct --->
		<cfset fields = foundUser.columnList />
		<cfloop list="#foundUser.columnList#" index="column">
			<cfset returnUser[column] = foundUser[column] />
		</cfloop>

		<cfreturn returnUser />
	</cffunction>
	
	<!--- USER SEARCH --->
	<cffunction name="search" access="remote" returntype="query" >
		<cfargument name="id" required="false" default="" />
		<cfargument name="login" required="false" default="" />
		<cfargument name="pass" required="false" default="" />
		<cfargument name="first_name" required="false" default="" />
		<cfargument name="last_name" required="false" default="" />
		<cfargument name="email" required="false" default="" />
		<cfargument name="url" required="false" default="" />
		
		<cfset var userFactory = createObject("component","UserFactory").init() />
		<cfset var foundUsers = userFactory.search(argumentCollection = arguments) />
		
		<cfreturn foundUsers/>
	</cffunction>
</cfcomponent>