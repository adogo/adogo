package unit
{
   import flash.events.MouseEvent;
   
   import info.itsrandom.restaurantgrid.events.RestaurantSelectionEvent;
   import info.itsrandom.restaurantgrid.view.RestaurantDisplayList;
   
   import mx.events.FlexEvent;
   
   import net.digitalprimates.fluint.tests.TestCase;

   public class RestaurantDisplayListTest extends TestCase
   {
      private var _gateway : MockGateway;
      private var _displayList : RestaurantDisplayList;
      
      override protected function setUp() : void
      {
         _gateway = new MockGateway();
         
         _displayList = new RestaurantDisplayList();
         _displayList.gateway = _gateway;
         _displayList.serviceUrl = "success.xml";
         
         addChild(_displayList);
      }
      
      public function testGridDispatchesEventOnClick() : void
      {
         var result : Function = 
            function (event : RestaurantSelectionEvent) : void
            {
               assertTrue(event.restaurant);
               assertEquals(45, event.restaurant.id);
               assertEquals("Sample Restaurant", event.restaurant.name);
               assertEquals("test description", event.restaurant.description);
               assertEquals("American", event.restaurant.genre);
               assertEquals(2, event.restaurant.rating);
            }
         
         _displayList.addEventListener(RestaurantSelectionEvent.RESTAURANT_SELECTED, result, false, 0, true);
         _displayList.restaurantGrid.selectedIndex = 0;
         _displayList.restaurantGrid.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function testFilterByRatingWithResults() : void
      {
         _displayList.filterByRating(2);
         assertTrue(_gateway.restaurants.length > 0);
      }
      
      public function testFilterByRatingWithoutResults() : void
      {
         _displayList.filterByRating(1);
         assertTrue(_gateway.restaurants.length == 0);
      }
      
      override protected function tearDown() : void
      {
         //verify all expectations were satisfied
         _gateway.mock.verify();
         
         //dispose of _displayList
         removeChild(_displayList);
         _displayList = null;
      }
   }
}


import info.itsrandom.restaurantgrid.RestaurantGateway;
import info.itsrandom.restaurantgrid.Restaurant;
import mx.collections.ArrayCollection;
import com.anywebcam.mock.Mock;
   

internal class MockGateway extends RestaurantGateway
{
   public var mock : Mock = new Mock();
   
   public function MockGateway() : void
   {
      super();
      
      mock.method("load").withArgs("success.xml");
   }
   
   override public function load(url : String) : void
   {
      mock.load(url);
      
      var restaurant : Restaurant = new Restaurant();
      restaurant.id = "45";
      restaurant.name = "Sample Restaurant";
      restaurant.description = "test description";
      restaurant.genre = "American";
      restaurant.rating = 2;
      
      super.restaurants = new ArrayCollection([restaurant]);
   }
}