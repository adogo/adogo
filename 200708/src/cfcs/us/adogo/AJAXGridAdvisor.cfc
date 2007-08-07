<cfcomponent name="AJAXGridAdvisor" output="false" extends="coldspring.aop.MethodInterceptor"
            hint="I transform any data to work with ColdFusion 8's Ajax Grids.">


	<!--- Need to run QueryConvertForGrid() to return result --->
	<cffunction name="invokeMethod" access="public" returntype="any"
         hint="This method will run whenever a matching method is executed">
		<cfargument name="mi" type="coldspring.aop.MethodInvocation" required="true" />
		<cfset var args = arguments.mi.getArguments() />
		<cfset var result = arguments.mi.proceed() />
		<cfset var methodName = arguments.mi.getMethod().getMethodName() />
		<cfset var res = "" />
      
      <cfif Left(methodName,"3") EQ "get">
         <!--- If this is an ajax query, they might have sorted by a column, 
               and the direction could be "ASC" or "DESC". --->
			<cfquery name="res" dbtype="query">
				SELECT * FROM result
				<cfif args['cfgridpagesortcolumn'] NEQ "">
					ORDER BY #args['cfgridpagesortcolumn']# #args['cfgridpagesortdirection']# 
				</cfif>
			</cfquery>
         <!--- New CF8 function, QueryConvertForGrid() takes in a query, 
               the current page number and the number of records on a page.
               
               ex: If there are 1000 records, and you're on the 4th page with 20 items per page
                   QueryConvertForGrid() will only return records 61-80.
         --->
			<cfset result = QueryConvertForGrid(res,args['cfgridpage'],args['cfgridpageSize']) />
      </cfif>
      <cfreturn result />
   </cffunction>

</cfcomponent>