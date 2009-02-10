package unit
{
   import info.itsrandom.restaurantgrid.RestaurantUtil;
   
   import net.digitalprimates.fluint.tests.TestCase;

   public class RestaurantUtilTest extends TestCase
   {
      public function testGenerateRandomIndexWithValidRange() : void
      {
         var actual : Number = RestaurantUtil.generateRandomIndex(6);
         assertTrue(actual >= 0 && actual < 6);
      }
      
      public function testGenerateRandomIndexWithInvalidRange() : void
      {
         var actual : Number;
         
         try{
            actual = RestaurantUtil.generateRandomIndex(-1);
            fail("Range should not be able to be less than 2.");
         }
         catch(e : Error)
         {
            //pass
         }
      }
   }
}