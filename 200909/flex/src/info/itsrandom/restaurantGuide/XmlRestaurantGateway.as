package info.itsrandom.restaurantGuide
{
   import mx.collections.ArrayCollection;
   import mx.messaging.messages.HTTPRequestMessage;
   import mx.rpc.AsyncToken;
   import mx.rpc.Responder;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.HTTPService;
   
   public class XmlRestaurantGateway extends RestaurantGateway
   {
      public function XmlRestaurantGateway()
      {
         super();
         
         super.service = new HTTPService();
			super.service.method = HTTPRequestMessage.POST_METHOD;
         super.service.resultFormat = HTTPService.RESULT_FORMAT_E4X;
         super.service.url = Registry.xmlServiceUrl;
      }

      public override function load() : void
		{
			var token: AsyncToken = this.service.send();
			token.addResponder(new Responder(result, fault));
		}

      /**
		 * Result handler for remote service calls to fetch Restaurant data using E4X and XML.
		 */
		private function result(resultEvent : ResultEvent) : void
		{
		   var restaurants : Array = [];
		   
		   //Get a collection of all restaurant nodes
		   var restaurantNodes : XMLList = resultEvent.result.restaurant;
		   
         for each (var restaurantNode : XML in restaurantNodes)
			{
				var restaurant : Restaurant = new Restaurant()
				restaurant.id = restaurantNode.id;
				restaurant.name = restaurantNode.name;
				restaurant.address = restaurantNode.address;
				
				for each(var review : String in restaurantNode.reviews.review)
				{
				   restaurant.reviews.push(review);
				}
				
				restaurant.rating = restaurantNode.rating;
				
				restaurants.push(restaurant);
			}
			
			super.restaurants = new ArrayCollection(restaurants);
		}
   }
}