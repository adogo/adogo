<cfcomponent name="UserFactory" hint="Symulates the Users table and interactions to it.">


	<cffunction name="init" access="public">
		<cfif NOT StructKeyExists(application,"UserFactory")>
			<cfset application.UserFactory = this />
	
			<cfparam name="variables.params" default="#structNew()#" />
			
			<cfset variables.params.users = QueryNew("id,login,pass,first_name,last_name,email,url,sex") />
			
			<!--- Create some sample users --->
			<cfset this.add("legrosb","legros4life","Brian","LeGros","brian@adogo.us","http://www.brianlegros.com/blog") />
			<cfset this.add("porgesm","gorgeoust","Maxim","Porges","max@adogo.us","http://www.maximporges.com") />
			<cfset this.add("roopd","pepsisupporter","Daniel","Roop","dan@adogo.us","http://www.danielroop.com/blog/") />
			<cfset this.add("huntt","tastytreat","Tyler","Hunt","tyler@adogo.us","http://blog.tylerhunt.com/") />
			<cfset this.add("fortunaa","yumlobsters","Adam","Fortuna","adam@adogo.us","http://www.adamfortuna.com") />
		</cfif>
		
		<cfreturn application.UserFactory />
	</cffunction>
	
	<cffunction name="add" returntype="void" access="public">
		<cfargument name="login" required="yes" type="string" />
		<cfargument name="pass" required="yes" type="string" />
		<cfargument name="first_name" required="yes" type="string" />
		<cfargument name="last_name" required="yes" type="string" />
		<cfargument name="email" required="yes" type="string" />
		<cfargument name="url" required="no" type="string" default="" />
		<cfset var addParams = arguments />
		<cfset var qry = "" />

		<cfset addParams.id = 1 />
		<cfquery name="qry" dbtype="query">
			SELECT max(id) maxID FROM variables.params.users
		</cfquery>
		
		<cfif qry.RecordCount GT 0>
			<cfset addParams.id = qry.maxID + 1 />
		</cfif>
		
		<cfset updateQuery(argumentCollection = addParams) />
	</cffunction>
	
	<cffunction name="edit" returntype="void" access="public">
		<cfargument name="id" required="yes" type="numeric" />
		<cfargument name="login" required="yes" type="string" />
		<cfargument name="pass" required="yes" type="string" />
		<cfargument name="first_name" required="yes" type="string" />
		<cfargument name="last_name" required="yes" type="string" />
		<cfargument name="email" required="yes" type="string" />
		<cfargument name="url" required="no" type="string" default="" />
		
		<cfset var editParams = arguments />
		<cfset var CurrentRow = "" />

		<!--- Need to get the row param --->
		<cfloop query="variables.params.users">
			<cfif variables.params.users.id EQ arguments.id>
				<cfset editParams.row = CurrentRow>
			</cfif>
		</cfloop>
		
		<cfset updateQuery(argumentCollection = editParams) />
	</cffunction>
	
	<cffunction name="updateQuery" returntype="void" access="public">
		<cfargument name="id" required="yes" type="numeric" />
		<cfargument name="login" required="yes" type="string" />
		<cfargument name="pass" required="yes" type="string" />
		<cfargument name="first_name" required="yes" type="string" />
		<cfargument name="last_name" required="yes" type="string" />
		<cfargument name="email" required="yes" type="string" />
		<cfargument name="url" required="yes" type="string" />
		<cfargument name="row" required="no" type="numeric" default="#variables.params.users+1#" />
		
		<cfif row NEQ variables.params.users+1>
			<cfset QueryAddRow(variables.params.users) />
		</cfif>

		<cfset QuerySetCell(variables.params.users, "id", arguments.id, arguments.row) />
		<cfset QuerySetCell(variables.params.users, "login", arguments.login, arguments.row) />
		<cfset QuerySetCell(variables.params.users, "pass", arguments.pass, arguments.row) />
		<cfset QuerySetCell(variables.params.users, "first_name", arguments.first_name, arguments.row) />
		<cfset QuerySetCell(variables.params.users, "last_name", arguments.last_name, arguments.row) />
		<cfset QuerySetCell(variables.params.users, "email", arguments.email, arguments.row) />
		<cfset QuerySetCell(variables.params.users, "url", arguments.url, arguments.row) />
	</cffunction>
		
	<cffunction name="find" access="public" returntype="query">
		<cfargument name="id" required="false" default="" />
		<cfargument name="login" required="false" default="" />
		<cfargument name="pass" required="false" default="" />
		<cfargument name="first_name" required="false" default="" />
		<cfargument name="last_name" required="false" default="" />
		<cfargument name="email" required="false" default="" />
		<cfargument name="url" required="false" default="" />
		
		<cfset var qry = "" />

		<cfquery name="qry" dbtype="query">
			SELECT id,login,pass,first_name,last_name,email,url
			FROM variables.params.users
			WHERE 1=1
			<cfif arguments.id NEQ "">
				AND id = '#arguments.id#'
			</cfif>
			<cfif arguments.login NEQ "">
				AND login = '#arguments.login#'
			</cfif>
			<cfif arguments.pass NEQ "">
				AND pass = '#arguments.pass#'
			</cfif>
			<cfif arguments.first_name NEQ "">
				AND first_name = '#arguments.first_name#'
			</cfif>
			<cfif arguments.last_name NEQ "">
				AND last_name = '#arguments.last_name#'
			</cfif>
			<cfif arguments.email NEQ "">
				AND email = '#arguments.email#'
			</cfif>
			<cfif arguments.url NEQ "">
				AND url = '#arguments.url#'
			</cfif>
		</cfquery>
		
		<cfreturn qry />
	</cffunction>
	
	<cffunction name="delete" returntype="void" access="public" hint="Ghettoest query ever">
		<cfargument name="id" required="yes" type="numeric" />
		
		<cfquery name="variables.params.users" dbtype="query">
			SELECT * FROM variables.params.users WHERE id != #arguments.id#
		</cfquery>
	</cffunction>

	
</cfcomponent>