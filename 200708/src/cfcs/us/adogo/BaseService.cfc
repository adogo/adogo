<cfcomponent output="false">

	<cffunction name="init" output="false">
		<cfset var key="" />
		<cfparam name="variables.instance" default="#StructNew()#" />
		
		<cfloop collection="#arguments#" item="key">
			<cfset variables.instance[key] = arguments[key] />
		</cfloop>
	</cffunction>
	
</cfcomponent>