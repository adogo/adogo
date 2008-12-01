package us.adogo.lunchchooser
{
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	import mx.utils.StringUtil;
	
	import us.adogo.lunchchooser.events.RestaurantSelectionEvent;
	
	/**
	 * Gateway wrapping all access to remote services required for working with Restaurant instances.
	 */
	[Event(name="restaurantSelected", type="us.adogo.lunchchooser.events.RestaurantSelectionEvent")]
	public class RestaurantController
	{
		/**
		 * The remote service class to use for remote calls.
		 */
		public var service : HTTPService;

		/**
		 * Typed ArrayCollection publicly available for outside code to bind to and watch. 
		 */
		[Bindable]
		public var restaurants : ArrayCollection;
		
		/**
		 * Constructor accepting the URL to the service endpoint. This parameter is configurable
		 * to facilitate testing as well as use against the real data set.
		 */
		public function RestaurantController()
		{
			super();
		}
		
		[Mediate(event="ratingSliderChanged", properties="rating")]
		public function filterRestaurantsByRating(rating : Number) : void
		{
			//Comparison function used to determine which items in the DataGrid to show
			this.restaurants.filterFunction = 
				function(item : Object) : Boolean {
					return (rating == 0) ? true : (item.rating == rating);
				}
				
			//Has to be called so that the new filterFunction above can be applied
			this.restaurants.refresh();
		}
			
		/**
		 * Called to randomly select a restaurant for lunch
		 **/
		public function findRandomRestaurant() : void
		{
			var index : Number = (Math.random() * 1000) % restaurants.length;
			var restaurant : Restaurant = restaurants.getItemAt(index) as Restaurant;
			
			dispatchEvent(new RestaurantSelectionEvent(restaurant));
		}
		
		/**
		 * Called to load the Restaurants from the remote server. Results from this call
		 * are visible by observing the restaurants. 
		 */
		public function load() : void
		{
			var token: AsyncToken = this.service.send();
			token.addResponder(new Responder(result, fault));
		}
		
		/**
		 * Result handler for remote service calls to fetch Restaurant data.
		 */
		private function result(resultEvent : ResultEvent) : void
		{
			var resultXml : XML = resultEvent.result as XML;
			var restaurantNodes : XMLList = resultXml.restaurant;
			
			//	Rather than calling addItem() over and over again on the public collection, we
			//	will keep track of the new Restaurants and then do one big update all at once.
			//	This is more lighweight since calling addItem() repeatedly broadcasts many
			//	CollectionChange events.
			var restaurantTempArray : Array = new Array();
			
			for each (var restaurantNode : XML in restaurantNodes)
			{
				var restaurant : Restaurant = new Restaurant()
				restaurant.id = restaurantNode.@id;
				restaurant.name = restaurantNode.name;
				restaurant.description = restaurantNode.description;
				restaurant.genre = restaurantNode.genre;
				restaurant.rating = restaurantNode.rating;
				
				restaurantTempArray.push(restaurant);
			}
			
			this.restaurants.source = restaurantTempArray;
		}

		/**
		 * Generic service fault handler for all remote service calls for this object.
		 */
		private function fault(faultEvent : FaultEvent) : void
		{
			var errorMessage : String =
				StringUtil.substitute(	"Error in {0}: {1} - {2}",
											this,
											faultEvent.fault.faultString,
											faultEvent.fault.faultDetail);
			
			throw new Error(errorMessage);
		}
	}
}