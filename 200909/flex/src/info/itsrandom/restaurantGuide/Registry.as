package info.itsrandom.restaurantGuide
{
	/**
	 * Simple implementation of the Registry pattern, used for storing global configuration
	 * settings and other objects that are useful across the application.
	 */ 
	public class Registry
	{	
		/**
		 * Returns the URL for the service that will provide any data that is needed by the application.
		 */
      //public static var jsonServiceUrl : String = "data/restaurants.json";
      //public static var xmlServiceUrl : String = "data/restaurants.xml";
      public static var jsonServiceUrl : String = "http://restaurant.jacobswanner.com/restaurants.json";
      public static var xmlServiceUrl : String = "http://restaurant.jacobswanner.com/restaurants";
      public static var amfServiceUrl : String = "http://restaurant.jacobswanner.com/rubyamf_gateway";
		
		public static const GOOGLE_MAP_KEY:String = "ABQIAAAAGdkfqV19r29eEf0gUZnTDRTBHCBmi-PM8I15FRkH50JSCbFXVBScNtva7YHCDBXEBKlbRQ4DgSe9YA";
		public static const MAP_START_LAT_LONG : Object = {lattitude: 28.497812, longitude: -81.399937};
	}
}