<cfform>
   <cfgrid name="authors"
	        format="html" 
		     bind="cfc:remote.MemberServiceAjax.getAll({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})">
	   <cfgridcolumn name="id" header="ID" />
	   <cfgridcolumn name="firstname" header="First Name" />
	   <cfgridcolumn name="lastname" header="Last Name" />
	   <cfgridcolumn name="birthdate" header="Birth Date" />
	   <cfgridcolumn name="email" header="Email" />
   </cfgrid>
</cfform>
