package info.itsrandom.lunchchooser.events
{
	import flash.events.Event;

	/**
	 * Custom event class for broadcasting rating changes. This event can be used by more than
	 * one component, both for broadcasting and for being listened to.
	 */ 
	public class RatingSliderChangeEvent extends Event
	{
		/**
		 * <p>
		 * Every event must have a type. Types are exposed as static constant Strings so that they can be
		 * referenced in outside observer code, such as the following:
		 * </p>
		 * 
		 * <code>
		 * myObserver.addEventListener(RatingSliderChangeEvent.SLIDER_CHANGED, myRestaurantSelectionEventHandlerFunction);
		 * </code>
		 */
		public static const SLIDER_CHANGED : String = "ratingSliderChanged";
		
		/**
		 * Private copy of the rating value given to this object's constructor when it was created. This
		 * variable is private since it is read-only and should not be able to be changed by outside code
		 * once this event has been created.
		 */
		private var _rating : Number;
		
		/**
		 * Constructor, accepting a specific rating value which must be passed in as this object is 
		 * created. Optional values include the "bubbles" and "cancelable" properties, which control
		 * how far this event can be propogated within the Flash Player event hierarchy.
		 */  
		public function RatingSliderChangeEvent(rating:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(SLIDER_CHANGED, bubbles, cancelable);
			this._rating = rating;
		}
		
		/**
		 * Public accessor for getting to the rating reference stored in this event. This is the item
		 * that most observers are going to be interested in looking at.
		 */
		public function get rating() : Number
		{
			return this._rating;
		}
		
		/**
		 * The clone() method is required to be overriden for custom events, and promotes the event
		 * propogation mechanism within Flex. All this method needs to do is create an identical
		 * copy of itself, with any private member variable references passed along. "bubbles" and
		 * "cancelable" come from the super class (flash.events.Event) 
		 */
		override public function clone() : Event
		{
			return new RatingSliderChangeEvent(this._rating, bubbles, cancelable);
		}
	}
}