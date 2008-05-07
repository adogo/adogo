package events
{
	import flash.events.Event;

	/**
	 * Simple event announcing that the customer wishes to check out.
	 * 
	 * This event does so little it's almost not worth creating it. Some people
	 * might prefer to use the regular old Event class instead and simply
	 * pass in a static constant String as its type. I decided to make this
	 * event object since it's generally a best practice to do so - you might
	 * want to add custom properties to this Class later.
	 */
	public class CheckOutEvent extends Event
	{
		public static const CHECK_OUT : String = "checkOut";
		
		public function CheckOutEvent()
		{
			super(CHECK_OUT, true, true);
		}
		
		override public function clone() : Event
		{
			return new CheckOutEvent();
		}
	}
}