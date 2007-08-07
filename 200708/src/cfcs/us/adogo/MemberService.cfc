<cfcomponent name="MemberService" extends="BaseService" output="false">
	
	<cffunction name="getAll" output="false" returntype="query">
      <!--- This is for the ajax service. --->
      <cfargument name="cfgridpage" default="1" />
		<cfargument name="cfgridpageSize" default="5" />
		<cfargument name="cfgridpagesortcolumn" default="firstname" />
		<cfargument name="cfgridpagesortdirection" default="asc" />
		<cfreturn variables.instance.memberGateway.getAll() />
	</cffunction>

	<cffunction name="getByFields" output="false" returntype="query">
		<cfreturn variables.instance.memberGateway.getByFields(argumentsCollection=arguments) />
	</cffunction>

	<cffunction name="create" output="false" returntype="any">
      <cfargument name="_to" type="struct" required="false" default="#StructNew()#" />
      <cfset var args = arguments._to />
		<cfset var record = variables.instance.reactorFactory.createRecord("member") />
      <cfset var errors = Arraynew(1) />
      <cfif StructIsEmpty(args)>
         <cfset args = arguments />
      </cfif>
      <cfset record.init(argumentCollection=args) />
		<cfset record.validate() />
		<cfif record.hasErrors()>
			<cfset errors = record._getErrorCollection().getTranslatedErrors() />
		<cfelse>
			<cfset record.save() />
		</cfif>
      <cfreturn errors />
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