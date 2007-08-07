<!--- Ask ColdSpring for the MemberService --->
<cfset MemberService = application.serviceFactory.getBean("memberService") />

<!--- Get all members --->
<cfset members = MemberService.getAll() />
<cfdump var="#members#" label="All Members" />

<!--- Create a new Member, with an error --->
<cfset newMember = StructNew() />
<cfset newMember.firstName = "Brian" />
<cfset errors = MemberService.create(newMember) />
<cfdump var="#errors#" label="First insert errors" />
<hr>

<!--- Fix the problem and try again --->
<cfset newMember.lastName = "LeGros" />
<cfset errors = MemberService.create(newMember) />
<cfdump var="#errors#" label="Second isert attempt" />
<cfdump var="#newMember#" label="Member inserted" />
<hr>


<!--- Alternate way of creating a new Member when a reference isn't required --->
<cfset errors = MemberService.create(firstName="Some", lastName="One") />

<!--- Finally, check out the latest members --->
<h2>Make sure our members were added successfully</h2>
<cfdump var="#MemberService.getAll()#" label="Final members" />

<!--- Load up a member and make some changes on it 
<cfset brian = MemberService.get(argumentCollection=newMember)>
--->