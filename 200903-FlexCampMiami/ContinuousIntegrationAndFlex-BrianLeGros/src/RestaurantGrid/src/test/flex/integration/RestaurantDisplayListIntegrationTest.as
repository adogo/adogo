package integration
{
   import flash.events.MouseEvent;
   
   import info.itsrandom.restaurantgrid.RestaurantGateway;
   import info.itsrandom.restaurantgrid.events.RestaurantSelectionEvent;
   import info.itsrandom.restaurantgrid.view.RestaurantDisplayList;
   
   //import mx.automation.delegates.controls.DataGridAutomationImpl;
   //import mx.automation.tabularData.DataGridTabularData;
   import mx.collections.ArrayCollection;
   import mx.events.FlexEvent;
   
   import net.digitalprimates.fluint.sequence.SequenceEventDispatcher;
   import net.digitalprimates.fluint.sequence.SequenceRunner;
   import net.digitalprimates.fluint.sequence.SequenceSetter;
   import net.digitalprimates.fluint.sequence.SequenceWaiter;
   import net.digitalprimates.fluint.stubs.HTTPServiceStub;
   import net.digitalprimates.fluint.tests.TestCase;

   public class RestaurantDisplayListIntegrationTest extends TestCase
   {
      private var _fixture : RestaurantDisplayList;
      
      override protected function setUp() : void
      {
         _fixture = new RestaurantDisplayList();
         var gateway : RestaurantGateway = new RestaurantGateway();
         var stub : HTTPServiceStub = new HTTPServiceStub();
         
         var data : XML = 
            <restaurants>
            	<restaurant id="45">
            		<name>Sample Restaurant</name>
            		<description><![CDATA[test description]]></description>
            		<genre>American</genre>
            		<rating>2</rating>
            	</restaurant>
            </restaurants>;
         
         stub.delay = 100;
         stub.result(null, data);
         gateway.service = stub;
         
         _fixture.gateway = gateway;
         _fixture.serviceUrl = "url_to_actual_xml_file.xml";
         _fixture.addEventListener(FlexEvent.CREATION_COMPLETE, asyncHandler(pendUntilComplete, 2000), false, 0, true);

         addChild(_fixture);
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
            
            //wait until datagrid updated
            sequence.addStep(new SequenceWaiter(_fixture.restaurantGrid, FlexEvent.UPDATE_COMPLETE, 5000));
            //set selectedIndex to 0 to make it easier to deal with MouseEvent.CLICK event
            sequence.addStep(new SequenceSetter(_fixture.restaurantGrid, {selectedIndex: 0}));
            //wait for property to be set
            sequence.addStep(new SequenceWaiter(_fixture.restaurantGrid, FlexEvent.VALUE_COMMIT, 100));
            //emulate mouse click
            sequence.addStep(new SequenceEventDispatcher(_fixture.restaurantGrid, new MouseEvent(MouseEvent.CLICK)));
            //wait for custom event
            sequence.addStep(new SequenceWaiter(_fixture, RestaurantSelectionEvent.RESTAURANT_SELECTED, 100));
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
               assertEquals(1, ArrayCollection(_fixture.restaurantGrid.dataProvider).length);
            };
         
         _fixture.restaurantGrid.addEventListener(FlexEvent.UPDATE_COMPLETE, asyncHandler(result, 500), false, 0, true); 
         _fixture.filterByRating(2);
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
               assertEquals(0, ArrayCollection(_fixture.restaurantGrid.dataProvider).length);
            };
         
         _fixture.restaurantGrid.addEventListener(FlexEvent.UPDATE_COMPLETE, asyncHandler(result, 500), false, 0, true); 
         _fixture.filterByRating(1);
      }
      
      override protected function tearDown() : void
      {
         //dispose of _displayList
         removeChild(_fixture);
         _fixture = null;
      }
   }
}