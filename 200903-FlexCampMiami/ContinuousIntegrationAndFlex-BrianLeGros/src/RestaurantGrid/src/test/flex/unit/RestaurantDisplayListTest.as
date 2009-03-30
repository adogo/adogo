package unit
{
   import flash.events.MouseEvent;
   
   import info.itsrandom.restaurantgrid.events.RestaurantSelectionEvent;
   import info.itsrandom.restaurantgrid.view.RestaurantDisplayList;
   
   //import mx.automation.delegates.controls.DataGridAutomationImpl;
   //import mx.automation.tabularData.DataGridTabularData;
   import mx.events.FlexEvent;
   import mx.collections.ArrayCollection;
   
   import net.digitalprimates.fluint.sequence.SequenceEventDispatcher;
   import net.digitalprimates.fluint.sequence.SequenceRunner;
   import net.digitalprimates.fluint.sequence.SequenceSetter;
   import net.digitalprimates.fluint.sequence.SequenceWaiter;
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
         
         _displayList.addEventListener(FlexEvent.CREATION_COMPLETE, asyncHandler(pendUntilComplete, 500));         
         addChild(_displayList);
      }
      
      public function testGridDispatchesEventOnClick() : void
      {
         var result : Function = 
            function (event : RestaurantSelectionEvent, passThroughData : Object) : void
            {
               assertTrue(event.restaurant);
               assertEquals(45, event.restaurant.id);
               assertEquals("Sample Restaurant", event.restaurant.name);
               assertEquals("test description", event.restaurant.description);
               assertEquals("American", event.restaurant.genre);
               assertEquals(2, event.restaurant.rating);
            };
         
            var sequence:SequenceRunner = new SequenceRunner(this);
            
            //set selectedIndex to 0 to make it easier to deal with MouseEvent.CLICK event
            sequence.addStep(new SequenceSetter(_displayList.restaurantGrid, {selectedIndex: 0}));
            //wait for property to be set
            sequence.addStep(new SequenceWaiter(_displayList.restaurantGrid, FlexEvent.VALUE_COMMIT, 100));
            //emulate mouse click
            sequence.addStep(new SequenceEventDispatcher(_displayList.restaurantGrid, new MouseEvent(MouseEvent.CLICK)));
            //wait for custom event
            sequence.addStep(new SequenceWaiter(_displayList, RestaurantSelectionEvent.RESTAURANT_SELECTED, 100));
            //verify state of _fixture        
            sequence.addAssertHandler(result, null);
            
            sequence.run(); 
      }
      
      public function testFilterByRatingWithResults() : void
      {
         var result : Function = 
            function (event : FlexEvent, passThroughData : Object) : void
            {
               /*
               Right now the automation APIs dont' have great support in AIR and the Fluint module loader for the AIRTestRunner
               doesn't handle [Mixin] correctly from what I can tell.  If you're using the Flex test runner below is the ideal 
               way to test a DataGrid and should work as expected.  Testing DataGrid again proves to be a huge pain.
               
               var delegate : DataGridAutomationImpl = _fixture.restaurantGrid.automationDelegate as DataGridAutomationImpl;
               var data : DataGridTabularData = delegate.automationTabularData as DataGridTabularData;
               assertEquals(1, data.numRows);
               */
               
               //Leaky way of verifying the visual component was updated, but AIR safe way
               assertEquals(1, ArrayCollection(_displayList.restaurantGrid.dataProvider).length);
            };
         
         _displayList.restaurantGrid.addEventListener(FlexEvent.UPDATE_COMPLETE, asyncHandler(result, 100)); 
         _displayList.filterByRating(2);
      }
      
      public function testFilterByRatingWithoutResults() : void
      {
         var result : Function = 
            function (event : FlexEvent, passThroughData : Object) : void
            {
               /*
               Right now the automation APIs dont' have great support in AIR and the Fluint module loader for the AIRTestRunner
               doesn't handle [Mixin] correctly from what I can tell.  If you're using the Flex test runner below is the ideal 
               way to test a DataGrid and should work as expected.  Testing DataGrid again proves to be a huge pain.
               
               var delegate : DataGridAutomationImpl = _fixture.restaurantGrid.automationDelegate as DataGridAutomationImpl;
               var data : DataGridTabularData = delegate.automationTabularData as DataGridTabularData;
               assertEquals(0, data.numRows);
               */
               
               //Leaky way of verifying the visual component was updated, but AIR safe way
               assertEquals(0, ArrayCollection(_displayList.restaurantGrid.dataProvider).length);
            };
         
         _displayList.restaurantGrid.addEventListener(FlexEvent.UPDATE_COMPLETE, asyncHandler(result, 100)); 
         _displayList.filterByRating(1);
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