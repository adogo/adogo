package unit
{
   import info.itsrandom.restaurantgrid.Restaurant;
   
   import net.digitalprimates.fluint.tests.TestCase;

   public class RestaurantTest extends TestCase
   {
      private var _restaurant : Restaurant;
      
      override protected function setUp() : void
      {
         _restaurant = new Restaurant();
      }
      
      public function testRatingSetterWithValidRating() : void
      {
         _restaurant.rating = 3;
         assertEquals(3, _restaurant.rating);
      }
      
      public function testRatingSetterWithRatingLessThan1() : void
      {
         try
         {
            _restaurant.rating = 0;
         }
         catch(e : Error)
         {
            //pass
         }
      }
      
      public function testRatingSetterWithRatingGreaterThan5() : void
      {
         try
         {
            _restaurant.rating = 6;
         }
         catch(e : Error)
         {
            //pass
         }
      }
   }
}