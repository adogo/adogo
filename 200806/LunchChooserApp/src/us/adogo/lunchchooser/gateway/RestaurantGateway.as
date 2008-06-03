package us.adogo.lunchchooser.gateway
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.StringUtil;
	
	import us.adogo.lunchchooser.Registry;
	import us.adogo.lunchchooser.Restaurant;
	
	/**
	 * Gateway wrapping all access to remote services required for working with Restaurant instances.
	 */
	public class RestaurantGateway
	{
		/**
		 * Internal handle to the actual remote service class.
		 */
		private var service : HTTPService;

		/**
		 * Typed ArrayCollection publicly available for outside code to bind to and watch. 
		 */
		[Bindable]
		[ArrayElementType("Restaurant")]
		public var restaurants : ArrayCollection;
		
		/**
		 * Constructor accepting the URL to the service endpoint. This parameter is configurable
		 * to facilitate testing as well as use against the real data set.
		 */
		public function RestaurantGateway()
		{
			this.restaurants = new ArrayCollection();
			
			this.service = new HTTPService();
			this.service.method = HTTPRequestMessage.POST_METHOD;
			this.service.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			this.service.url = Registry.serviceUrl;
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
				
				restaurantTempArray[restaurantTempArray.length] = restaurant;
			}
			
			this.restaurants = new ArrayCollection(restaurantTempArray);
		}

		/**
		 * Generic service fault handler for all remote service calls for this object.
		 */
		public function fault(faultEvent : FaultEvent) : void
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