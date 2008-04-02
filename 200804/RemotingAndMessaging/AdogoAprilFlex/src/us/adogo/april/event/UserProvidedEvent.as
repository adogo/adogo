package us.adogo.april.event
{
	import flash.events.Event;
	
	import us.adogo.april.User;

	public class UserProvidedEvent extends Event
	{
		public static var TYPE : String = "userProvided";
		
		public var user : User;
		
		public function UserProvidedEvent(user : User)
		{
			super(UserProvidedEvent.TYPE, true);
			this.user = user;
		}
		
	}
}