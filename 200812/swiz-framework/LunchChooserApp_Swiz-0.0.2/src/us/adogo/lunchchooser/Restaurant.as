package us.adogo.lunchchooser
{
	import mx.events.PropertyChangeEvent;
	
	/**
	 * Simple domain class representing Restaurant.
	 */
	[Bindable]
	public class Restaurant
	{
		public var id : String;
		public var name : String;
		public var description : String;
		public var genre : String;
		
		public function Restaurant()
		{
			super();
		}
		
		private var _rating : Number;
		
		public function get rating() : Number
		{
			return _rating;
		}

		public function set rating(rating : Number) : void
		{
			if(rating < 1 || rating > 5)
			{
				throw new Error("Rating must be between 1 and 5 stars.");
			}
			
			var changeEvent : PropertyChangeEvent = PropertyChangeEvent.createUpdateEvent(this, "rating", _rating, rating);
			_rating = rating;
			dispatchEvent(changeEvent);
		}
	}
}