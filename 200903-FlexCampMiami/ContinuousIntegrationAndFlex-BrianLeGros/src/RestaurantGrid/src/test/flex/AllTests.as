package
{
	import integration.RestaurantDisplayListIntegrationTest;
	
	import net.digitalprimates.fluint.tests.TestSuite;
	
	import unit.RestaurantDisplayListTest;
	import unit.RestaurantTest;
	import unit.RestaurantUtilTest;
	
	public class AllTests extends TestSuite
	{
		public function AllTests()
		{
		   addUnitTests();
		   addIntegrationTests();
		}
		
		private function addUnitTests() : void
		{
		   addTestCase(new RestaurantTest());
		   addTestCase(new RestaurantUtilTest());
		   addTestCase(new RestaurantDisplayListTest());
		}
		
		private function addIntegrationTests() : void
		{
		   addTestCase(new RestaurantDisplayListIntegrationTest());
		}
	}
}