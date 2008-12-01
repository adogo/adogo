package us.adogo.lunchchooser.events
{
	import flash.events.Event;
	
	import us.adogo.lunchchooser.Restaurant;

	/**
	 * Custom event class for broadcasting Restaurant selections. This event can be used by more than
	 * one component, both for broadcasting and for being listened to. However, at the time of writing,
	 * it is only produced by the RestaurantDisplayList.
	 */  
	public class RestaurantSelectionEvent extends Event
	{
		/**
		 * <p>
		 * Every event must have a type. Types are exposed as static constant Strings so that they can be
		 * referenced in outside observer code, such as the following:
		 * </p>
		 * 
		 * <code>
		 * myObserver.addEventListener(RestaurantSelectionEvent.RESTAURANT_SELECTED, myRestaurantSelectionEventHandlerFunction);
		 * </code>
		 */
		public static const RESTAURANT_SELECTED : String = "restaurantSelected";
		
		/**
		 * Private reference to the Restaurant given to this object's constructor when it was created. This
		 * variable is private since it is read-only and should not be able to be changed by outside code
		 * once this event has been created.
		 */
		private var _restaurant : Restaurant;
		
		/**
		 * Constructor, accepting a specific Restaurant instance which must be passed in as this object is 
		 * created. Optional values include the "bubbles" and "cancelable" properties, which control
		 * how far this event can be propogated within the Flash Player event hierarchy.
		 */  
		public function RestaurantSelectionEvent(restaurant : Restaurant, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(RESTAURANT_SELECTED, bubbles, cancelable);
			
			_restaurant = restaurant;
		}
		
		/**
		 * Public accessor for getting to the Restaurant reference stored in this event. This is the item
		 * that most observers are going to be interested in looking at.
		 */
		public function get restaurant() : Restaurant
		{
			return _restaurant;
		}
		
		/**
		 * The clone() method is required to be overriden for custom events, and promotes the event
		 * propogation mechanism within Flex. All this method needs to do is create an identical
		 * copy of itself, with any private member variable references passed along. "bubbles" and
		 * "cancelable" come from the super class (flash.events.Event) 
		 */
		override public function clone() : Event
		{
			return new RestaurantSelectionEvent(_restaurant, bubbles, cancelable);
		}
	}
}