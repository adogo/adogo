<cfcomponent extends="MemberService" output="false">
	
	<cffunction name="getAll" output="false" returntype="query">
		<cfargument name="cfgridpage" default="1" />
		<cfargument name="cfgridpageSize" default="5" />
		<cfargument name="cfgridpagesortcolumn" default="firstname" />
		<cfargument name="cfgridpagesortdirection" default="asc" /> 
		<cfset super.getAll(argumentsCollection=arguments) />
	</cffunction>
	
	<cffunction name="update" output="false" returntype="boolean">
		<cfargument name="gridaction" type="string" required="yes">
		<cfargument name="gridrow" type="struct" required="yes">
		<cfargument name="gridchanged" type="struct" required="yes">

		<cfset var args = StructNew() />
		<cfset var ret = ArrayNew(1) />
		
		<cfif arguments.cfgridaction EQ "U">
            <cfset args.id = arguments.cfgridrow.id />
			<cfset args[StructKeyList(arguments.gridchanged)] = arguments.gridchanged[StructKeyList(arguments.gridchanged)] />
			<cfset ret = update(argumentCollection=args) />
		</cfif>
		<cfreturn ret />
	</cffunction>
	
</cfcomponent>