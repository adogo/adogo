package events
{
	import flash.events.Event;

	public class AuthenticationEvent extends Event
	{
		public static const PASS : String = "pass";
      public static const FAIL : String = "fail";
		
		public function AuthenticationEvent(type : String)
		{
			super(type, true);
		}
		
		override public function clone():Event
		{
			return new AuthenticationEvent(type);
		}
		
	}
}