package info.itsrandom.restaurantGuide
{
   import com.adobe.serialization.json.JSON;
   
   import mx.collections.ArrayCollection;
   import mx.messaging.messages.HTTPRequestMessage;
   import mx.rpc.AsyncToken;
   import mx.rpc.Responder;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.HTTPService;
   
   public class JsonRestaurantGateway extends RestaurantGateway
   {
      public function JsonRestaurantGateway()
      {
         super();
         
         super.service = new HTTPService();
			super.service.method = HTTPRequestMessage.POST_METHOD;
         super.service.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
         super.service.url = Registry.jsonServiceUrl;
      }
      
      public override function load() : void
		{
			var token: AsyncToken = this.service.send();
			token.addResponder(new Responder(result, fault));
		}
      
      /**
		 * Result handler for remote service calls to fetch Restaurant data using JSON.
		 */
      private function result(resultEvent : ResultEvent) : void
      {
         //get the raw JSON data and cast to String
			var rawData:String = String(resultEvent.result);

			//decode the data to ActionScript using the JSON API
			//in this case, the JSON data is a serialize Array of Objects.
			var arrRestaurant:Array	 = (JSON.decode(rawData) as Array);

			//populate the restaurant objects
			var parseRestaurant : Function = function(item:Object, index:int, arr:Array) : Restaurant
			   {
			      var restaurant : Restaurant = new Restaurant();
      			restaurant.id = index+1;	
      			restaurant.name = item.name;	
      			restaurant.address = item.address;
      			restaurant.reviews.source = item.reviews;
      			restaurant.reviews.refresh();	
      			restaurant.rating = item.rating;
      			
      			return restaurant;
			   };

			//create a new ArrayCollection passing the de-serialized Array of Restaurants
			//ArrayCollections work better as DataProviders, as they can
			//be watched for changes.
			super.restaurants = new ArrayCollection(arrRestaurant.map(parseRestaurant));
      }
      
   }
}