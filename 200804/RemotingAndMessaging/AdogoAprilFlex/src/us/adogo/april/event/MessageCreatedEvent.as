package us.adogo.april.event
{
	import flash.events.Event;

	public class MessageCreatedEvent extends Event
	{
		public static var TYPE : String = "messageCreated";
		
		public var message : String;
		
		public function MessageCreatedEvent(message : String)
		{
			super(MessageCreatedEvent.TYPE, true);
			this.message = message;
		}
		
	}
}