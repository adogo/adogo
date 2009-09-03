package info.itsrandom.restaurantGuide
{
	import com.adobe.serialization.json.JSON;
	
	import mx.collections.ArrayCollection;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.StringUtil;
	
	/**
	 * Gateway wrapping all access to remote services required for working with Restaurant instances.
	 */
	public class RestaurantGateway
	{
		/**
		 * Internal handle to the actual remote service class.
		 */
		protected var service : *;

		/**
		 * Typed ArrayCollection publicly available for outside code to bind to and watch. 
		 */
		[Bindable]
		public var restaurants : ArrayCollection;
		
		/**
		 * Constructor accepting the URL to the service endpoint. This parameter is configurable
		 * to facilitate testing as well as use against the real data set.
		 */
		public function RestaurantGateway() : void
		{
			this.restaurants = new ArrayCollection();
		}
		
		/**
		 * Called to load the Restaurants from the remote server. Results from this call
		 * are visible by observing the restaurants. 
		 */
		public function load() : void
		{
		}
		
		/**
		 * Generic service fault handler for all remote service calls for this object.
		 */
		protected function fault(faultEvent : FaultEvent) : void
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