<script type="text/javascript">
function errorhandler(id,message) {
alert("Error while updating\n Error code: "+id+"\n Message: "+message);
}
</script>

<cfform>
<cfgrid name="authors"
		delete="yes"
		format="html" 
		selectmode="edit"
		bind="cfc:coldfusion.remote.AjaxAuthorService.getAll({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})"
		onchange="cfc:coldfusion.remote.AjaxAuthorService.updateGrid({cfgridaction},{cfgridrow},{cfgridchanged})"
		>
	<cfgridcolumn name="id" header="ID" />
	<cfgridcolumn name="firstname" header="First Name" />
	<cfgridcolumn name="lastname" header="Last Name" />
	<cfgridcolumn name="birthdate" header="Birth Date" />
</cfgrid>

<cfinput name="selected" type="text" bind="{authors.columnName}" bindonload="true" />

</cfform>
