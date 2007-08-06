<cfcomponent name="MemberService" extends="BaseService" output="false">
	
	<cffunction name="getAll" output="false" returntype="query">
		<cfreturn variables.instance.memberGateway.getAll(argumentsCollection=arguments) />
	</cffunction>

	<cffunction name="getByFields" output="false" returntype="query">
		<cfreturn variables.instance.memberGateway.getByFields(argumentsCollection=arguments) />
	</cffunction>

	<cffunction name="create" output="false" returntype="any">
		<cfset var record = variables.instance.reactorFactory.createRecord("member").init(argumentCollection=arguments) />
		<cfset record.validate() />
		<cfif record.hasErrors()>
			<cfreturn record._getErrorCollection().getTranslatedErrors() />
		<cfelse>
			<cfset record.save() />
			<cfreturn record.getID() />
		</cfif>
	</cffunction>

	<cffunction name="update" output="false" returntype="array">
		<cfset var record = variables.instance.reactorFactory.createRecord("member").load(arguments.id) />
		<cfset var key = "" />
		<cfset var errorCollection = ArrayNew(1) />
		<cfloop collection="arguments" item="key">
			<cfif key NEQ "id" AND isDefined("record.set#key#")>
				<cfinvoke component="#record#" method="set#key#">
					<cfinvokeargument name="#key#" value="arguments[key]" />
				</cfinvoke>
			</cfif>
		</cfloop>

		<cfset record.validate() />
		<cfif record.hasErrors()>
			<cfset errorCollection = record._getErrorCollection().getTranslatedErrors() />
		<cfelse>
			<cfset record.save() />
		</cfif>
		<cfreturn errorCollection />
	</cffunction>	
	
	<cffunction name="delete" output="false" returntype="array">
		<cfset var record = variables.instance.reactorFactory.createRecord("member").init(argumentCollection=arguments) />
		<cfset var errorCollection = ArrayNew(1) />
		<cfset record.delete() />
		<cfif NOT record.isDeleted()>
			<cfset errorCollection = record._getErrorCollection().getTranslatedErrors() />
		</cfif>
		<cfreturn errorCollection />
	</cffunction>
	
</cfcomponent>