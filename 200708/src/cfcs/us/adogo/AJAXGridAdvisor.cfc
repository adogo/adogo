<cfcomponent name="AJAXGridAdvisor" output="false" extends="coldspring.aop.MethodInterceptor">


	<!--- Need to run QueryConvertForGrid() to return result --->
	<cffunction name="invokeMethod" access="public" returntype="any">
		<cfargument name="mi" type="coldspring.aop.MethodInvocation" required="true" />
		<cfset var args = arguments.mi.getArguments() />
		<cfset var result = arguments.mi.proceed() />
		<cfset var methodName = arguments.mi.getMethod().getMethodName() />
		<cfset var qry = "" />

		<cfquery name="qry" dbtype="query">
			SELECT * FROM result
			<cfif args['cfgridpagesortcolumn'] NEQ "">
				ORDER BY #args['cfgridpagesortcolumn']# #args['cfgridpagesortdirection']# 
			</cfif>
		</cfquery>
			
		<cfreturn QueryConvertForGrid(qry,args['cfgridpage'],args['cfgridpageSize']) />
  </cffunction>


</cfcomponent>