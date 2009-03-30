package info.itsrandom.restaurantgrid
{
	/**
	 * Simple domain class representing Restaurant.
	 */
	public class Restaurant
	{
		public var id : String;
		public var name : String;
		public var description : String;
		public var genre : String;
		
		private var _rating : Number;
		
		public function Restaurant()
		{
		}
		
		public function set rating(rating : Number) : void
		{
			if(rating < 1 || rating > 5)
			{
				throw new Error("Rating must be between 1 and 5 stars.");
			}
			
			_rating = rating;			
		}
		
		public function get rating() : Number
		{
			return _rating;
		}

	}
}