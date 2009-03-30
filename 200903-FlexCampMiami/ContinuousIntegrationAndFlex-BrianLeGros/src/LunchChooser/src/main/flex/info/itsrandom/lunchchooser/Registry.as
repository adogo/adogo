package info.itsrandom.lunchchooser
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
		public static var serviceUrl : String = "assets/restaurants.xml";

   }
}