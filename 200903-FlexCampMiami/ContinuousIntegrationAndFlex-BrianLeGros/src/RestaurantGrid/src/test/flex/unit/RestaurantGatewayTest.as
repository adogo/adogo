package unit
{
   import info.itsrandom.restaurantgrid.Restaurant;
   import info.itsrandom.restaurantgrid.RestaurantGateway;
   
   import mx.events.CollectionEvent;
   
   import net.digitalprimates.fluint.stubs.HTTPServiceStub;
   import net.digitalprimates.fluint.tests.TestCase;
   
   public class RestaurantGatewayTest extends TestCase
   {
      private var _gateway : RestaurantGateway;
      private var _stub : HTTPServiceStub;
      
      override protected function setUp() : void
      {
         _stub = new HTTPServiceStub();
         _gateway = new RestaurantGateway();
         _gateway.service = _stub;
      }
      
      public function testLoadWithValidUrl() : void
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
         
         _stub.result(null, data); 
         
         var resultHandler : Function = 
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
         
         _gateway.restaurants.addEventListener(CollectionEvent.COLLECTION_CHANGE, resultHandler, false, 0, true);
         _gateway.load("assets/restaurants.xml");
      }
      
      public function testLoadWithInvalidUrl() : void
      {
         _stub.fault(null, null, null, null);
         
         var failureHandler : Function = 
            function (event : CollectionEvent) : void
            {
               fail("Collection should not have changed");
            };
            
         var resultHandler : Function = 
            function (passThroughData : Object) : void
            {
               //no change to collection occurred, test passed
            }
         
         _gateway.load("fail.xml");
         _gateway.restaurants.addEventListener(CollectionEvent.COLLECTION_CHANGE, asyncHandler(failureHandler, 1000, null, resultHandler), false, 0, true);
      }
      
   }
}