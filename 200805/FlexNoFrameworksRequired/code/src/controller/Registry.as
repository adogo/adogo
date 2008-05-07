package controller
{
	import com.maximporges.store.ShoppingCart;

	/**
	 * Simple Registry implementation. See http://www.martinfowler.com/eaaCatalog/registry.html
	 * 
	 * By the way, the Patterns of Enterprise Appliction Architecture book by Martin Fowler 
	 * (where the Registry pattern is documented) is highly recommended. It is an easy read
	 * and contains loads of useful patterns. 
	 */
	public class Registry
	{
		private var _cartController : CartController;

		private static var registryInstance : Registry;

		/**
		 * This is called a "static initializer". This is code that runs only once
		 * when this Class is loaded by the Flash player. We use this to initialize
		 * any and all objects used by this Registry. Currently, we only have one
		 * object in here since this is a simple app.
		 */
		{
			registryInstance = new Registry();
			registryInstance._cartController = new CartController();
		}
		
		/**
		 * Public static accessor method so that client code can look up the 
		 * CartController by calling Registry.cartController.
		 */
		public static function get cartController() : CartController
		{
			return registryInstance._cartController;
		}
	}
}