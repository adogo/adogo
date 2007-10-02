<!--- Create an array of our tests --->
<cfset variables.tests = ArrayNew(1) />
<cfset ArrayAppend(variables.tests, "services.UserManagerTest") />

<!--- Create a test suite --->
<cfset variables.testsuite = CreateObject("component", "cfunit.framework.TestSuite").init(variables.tests) />

<!--- Run all test in test suite --->
<cfset CreateObject("component", "cfunit.framework.TestRunner").run(variables.testsuite, "" ) />