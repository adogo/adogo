package nvc
{
   import events.AuthenticationEvent;
   
   import model.User;
   
   [Event(name="pass",type="events.AuthenticationEvent")]
   [Event(name="fail",type="events.AuthenticationEvent")]
	public class StubAuthenticationNvc extends AuthenticationNvc
	{
      public var authenticateCalled : Boolean = false;
		
		override public function authenticate(username : String, password : String) : void {
		   authenticateCalled = true;
		}
	}
}