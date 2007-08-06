<cfcomponent name="Application">

	<cfscript>
	this.name = '#hash(getBaseTemplatePath())#';
	this.applicationTimeout = createTimeSpan( 2, 0, 0, 0 );
	this.clientManagement = false;
	this.clientStorage = '';
	this.loginStorage = 'session';
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan( 0, 0, 30, 0 );
	this.setClientCookies = true;
	this.setDomainCookies = true;
	this.scriptProtect = true;
	</cfscript>

	<cffunction name="onApplicationStart" hint="" access="public" returntype="boolean">
		<!--- 
		<cffile output="#now()#: onApplicationStart" action="write" file="#getDirectoryFromPath( getCurrentTemplatePath() )#log.txt" addnewline="true" />
		--->
		<cfset serviceDefinitionLocation = expandPath('/coldfusion/config/coldSpring.xml.cfm') />
		<cfset application.serviceFactory = createObject('component', 'coldspring.beans.DefaultXmlBeanFactory').init() />
		<cfset application.serviceFactory.loadBeansFromXmlFile(serviceDefinitionLocation) />
		<cfset authorService = application.serviceFactory.getBean("memberServiceFlex") />
		<cfset authorService = application.serviceFactory.getBean("memberServiceAjax") />
		<cfreturn true />
	</cffunction>
	
	<cffunction name="onSessionStart" hint="" access="public" returntype="void">
		<!--- 
		<cffile output="#now()#: onSessionStart" action="append" file="#getDirectoryFromPath( getCurrentTemplatePath() )#log.txt" addnewline="true" />
		--->
	</cffunction>

	<cffunction name="onRequestStart" hint="" access="public" returntype="boolean">
		<cfargument name="theTargetPage" type="String" required="true"/>
		<cfset onApplicationStart() />
		<cfreturn true />
	</cffunction>
	<!--- 
	<cffunction name="onRequest" hint="" access="public" returntype="void">
		<cfargument name="theTargetPage" type="String" required="true"/>
		<cffile output="#now()#: onRequest for #arguments.theTargetPage#" action="append" file="#getDirectoryFromPath( getCurrentTemplatePath() )#log.txt" addnewline="true" />
		<cfinclude template="#arguments.theTargetPage#">
	</cffunction>
	 --->
	<cffunction name="onRequestEnd" hint="" access="public" returntype="void">
		<cfargument name="theTargetPage" type="String" required="true"/>
		<!--- 
		<cffile output="#now()#: onRequestEnd for #arguments.theTargetPage#" action="append" file="#getDirectoryFromPath( getCurrentTemplatePath() )#log.txt" addnewline="true" />	
		--->
	</cffunction>	
	
	<cffunction name="onSessionEnd" hint="" access="public" returntype="void">
		<cfargument name="sessionScope" required="true" />
		<cfargument name="applicationScope" required="false" />
		<!---
		<cffile output="#now()#: onSessionEnd (#structKeyList( arguments.sessionScope )#)" action="append" file="#getDirectoryFromPath( getCurrentTemplatePath() )#log.txt" addnewline="true" />	
		--->
	</cffunction>
	
	<cffunction name="onApplicationEnd" hint="" access="public" returntype="void">
		<!--- 
		<cffile output="#now()#: onApplicationEnd" action="append" file="#getDirectoryFromPath( getCurrentTemplatePath() )#log.txt" addnewline="true" />
		--->
	</cffunction>
	
	<cffunction name="onError" hint="" access="public" returntype="void">
		<cfargument name="theException" required="true" />
   		<cfargument name="theEventName" type="String" required="true" />
		<!--- 
		<cffile output="#now()#: onError" action="append" file="#getDirectoryFromPath( getCurrentTemplatePath() )#log.txt" addnewline="true" />	
		--->
		<cfdump var="#arguments.theException#" label="onError Exception Dump">
		<cfdump var="#arguments.theEventName#" label="onError Event Name">
		<cfabort>   	
	</cffunction>
		
</cfcomponent>