package integration
{
   import info.itsrandom.restaurantgrid.Restaurant;
   import info.itsrandom.restaurantgrid.RestaurantGateway;
   
   import mx.events.CollectionEvent;
   
   import net.digitalprimates.fluint.tests.TestCase;
   
   public class RestaurantGatewayTest extends TestCase
   {
      private var _gateway : RestaurantGateway;
      
      override protected function setUp() : void
      {
         _gateway = new RestaurantGateway();
      }
      
      public function testLoadWithValidUrl() : void
      {
         var result : Function = 
            function (event : CollectionEvent) : void
            {
               assertEquals(1, _gateway.restaurants.length);
                
               var item : Object = _gateway.restaurants[0];
               assertTrue(item is Restaurant);
                
               var restaurant : Restaurant = Restaurant(item);
               assertEquals(45, restaurant.id);
               assertEquals("Sample Restaurant", restaurant.name);
               assertEquals("test description", restaurant.description);
               assertEquals("American", restaurant.genre);
               assertEquals(2, restaurant.rating); 
            };
         
         _gateway.service = new HttpServiceStub();
         _gateway.restaurants.addEventListener(CollectionEvent.COLLECTION_CHANGE, result, false, 0, true);
         _gateway.load("http://localhost/~blegros/LunchChooser/assets/restaurants.xml");
      }
      
      public function testLoadWithInvalidUrl() : void
      {
         var failure : Function = 
            function (event : CollectionEvent) : void
            {
               fail("Collection should not have changed");
            };
            
         var result : Function = 
            function (passThroughData : Object) : void
            {
               //no change to collection occurred, test passed
            }
         
         _gateway.load("fail.xml");
         _gateway.restaurants.addEventListener(CollectionEvent.COLLECTION_CHANGE, asyncHandler(failure, 1000, null, result), false, 0, true);
      }
      
   }
}

import mx.rpc.http.HTTPService;
import com.anywebcam.mock.Mock;
import mx.rpc.AsyncToken;
import flash.utils.Timer;
import flash.events.TimerEvent;
import mx.rpc.IResponder;
import mx.rpc.events.ResultEvent;
import mx.rpc.events.FaultEvent;
import mx.rpc.Fault;
   

internal class HttpServiceStub extends HTTPService
{
   public function HttpServiceStub()
   {
      super(null, null);
   }
   
   override public function send(parameters : Object = null) : AsyncToken
   {
      var data : XML = 
         <restaurants>
         	<restaurant id="45">
         		<name>Sample Restaurant</name>
         		<description><![CDATA[test description]]></description>
         		<genre>American</genre>
         		<rating>2</rating>
         	</restaurant>
         </restaurants>;
      
      var token : AsyncToken = new AsyncToken(null);
      
      //use a time to give time for the caller to map responders to the asyncToken
      var timer : Timer = new Timer(1000, 1);
      
	   timer.addEventListener(
	      TimerEvent.TIMER_COMPLETE, 
	      function(event : TimerEvent) : void 
   	   {
   	      //loop over all responders to emulate a successful call being made
   	      for each(var responder : IResponder in token.responders)
         	{
   		      responder.result(new ResultEvent(ResultEvent.RESULT, false, true, data));
            }
   	   }, 
   	   false, 
   	   0, 
   	   true
   	);
	   
	   timer.start();
	   
	   return token;
   }
}