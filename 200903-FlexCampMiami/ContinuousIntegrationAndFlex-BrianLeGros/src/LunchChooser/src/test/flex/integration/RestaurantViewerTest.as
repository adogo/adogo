package integration
{
   import info.itsrandom.lunchchooser.view.RestaurantViewer;
   import info.itsrandom.restaurantgrid.events.RestaurantSelectionEvent;
   
   import mx.events.FlexEvent;
   
   import net.digitalprimates.fluint.tests.TestCase;

   public class RestaurantViewerTest extends TestCase
   {
      private var _displayListStub : DisplayListStub;
      private var _viewer : RestaurantViewer;
      
      override protected function setUp() : void
      {
         _viewer = new RestaurantViewer();
         
         _displayListStub = new DisplayListStub();
         _viewer.restaurantList = _displayListStub;
         _viewer.restaurantList.addEventListener(RestaurantSelectionEvent.RESTAURANT_SELECTED, _viewer.showDescription);
         
         addChild(_viewer);
      }
      
      public function testShowDescription() : void
      {
         var result : Function = 
            function (event : FlexEvent) : void
            {
               assertEquals("test description", _viewer.descriptionLabel.text);
            };
         
         _viewer.descriptionLabel.addEventListener(FlexEvent.VALUE_COMMIT, result); 
         _displayListStub.emulateRestaurantSelectionEvent();
      }
      
      override protected function tearDown() : void
      {
         removeChild(_viewer);
         _viewer = null;
      }
   }
}

import info.itsrandom.restaurantgrid.view.RestaurantDisplayList;
import info.itsrandom.restaurantgrid.Restaurant;
import info.itsrandom.restaurantgrid.events.RestaurantSelectionEvent;

internal class DisplayListStub extends RestaurantDisplayList
{
   private var _restaurant : Restaurant;
   
   public function DisplayListStub() : void
   {
      super();
      
      _restaurant = new Restaurant();
      _restaurant.id = "45";
      _restaurant.name = "Sample Restaurant";
      _restaurant.description = "test description";
      _restaurant.genre = "American";
      _restaurant.rating = 2;
   }
   
   override public function set serviceUrl(value : String) : void
   {
      //override so nothing is done automagically since I can only create stub via extension
   }
   
   public function emulateRestaurantSelectionEvent() : void
   {
      this.dispatchEvent(new RestaurantSelectionEvent(_restaurant));
   }
}