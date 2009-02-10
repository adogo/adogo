package
{
	import integration.RestaurantViewerTest;
	
	import net.digitalprimates.fluint.tests.TestSuite;
	
	import unit.RatingsSliderTest;
	
	public class AllTests extends TestSuite
	{
		public function AllTests()
		{
			addUnitTests();
			addIntegrationTests();
		}
		
		private function addUnitTests() : void
		{
		   addTestCase(new RatingsSliderTest());
		}
		
		private function addIntegrationTests() : void
		{
		   addTestCase(new RestaurantViewerTest());
		}
	}
}