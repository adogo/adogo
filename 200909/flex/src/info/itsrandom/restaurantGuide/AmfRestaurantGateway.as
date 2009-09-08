package info.itsrandom.restaurantGuide
{
   import mx.collections.ArrayCollection;
   import mx.rpc.AsyncToken;
   import mx.rpc.Responder;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.remoting.RemoteObject;
   
   public class AmfRestaurantGateway extends RestaurantGateway
   {
      public function AmfRestaurantGateway()
      {
         super();
         super.service = new RemoteObject("rubyamf");
         super.service.endpoint = Registry.amfServiceUrl;
         super.service.source = "RestaurantsController";
         
      }

      public override function load() : void
		{
			var token: AsyncToken = this.service.index();
			token.addResponder(new Responder(result, fault));
		}
		
		/**
		 * Result handler for remote service call to fetch Restaurant data using AMF
		 */ 
		private function result(event : ResultEvent) : void
		{
		   super.restaurants = new ArrayCollection(event.result as Array);
		}
   }
}