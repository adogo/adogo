package nvc
{
   import events.AuthenticationEvent;
   
   import model.User;
   
   [Event(name="pass",type="events.AuthenticationEvent")]
   [Event(name="fail",type="events.AuthenticationEvent")]
	public class AuthenticationNvc
	{
		[Bindable]
		public var authenticated : Boolean;
		
		[Bindable]
		public var failedAuthentication : Boolean;
		
		[Bindable]
		public var user : User;
		
		public function AuthenticationNvc()
		{
		   authenticated = false;
		   failedAuthentication = false;
		}
		
		public function authenticate(username : String, password : String) : void {
		   authenticated = (username == "daniel") && (password == "password");
		   failedAuthentication = !authenticated;
		   
		   if (authenticated) {
		      user = new User();
		      user.firstName = "Daniel";
		      user.lastName = "Roop";
		      user.username = "daniel";
		   }
		   
         dispatchEvent(new AuthenticationEvent(authenticated ? AuthenticationEvent.PASS : AuthenticationEvent.FAIL));
		}
	}
}