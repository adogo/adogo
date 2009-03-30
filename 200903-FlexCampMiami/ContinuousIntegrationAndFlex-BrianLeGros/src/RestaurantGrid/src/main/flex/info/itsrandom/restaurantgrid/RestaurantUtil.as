package info.itsrandom.restaurantgrid
{
   public class RestaurantUtil
   {
      /**
      * Used to generate a random integer index within the specified range by using modulus
      **/
      public static function generateRandomIndex(range : Number) : Number
      {
         if(range < 2)
         {
            throw new Error("Cannot generate an idex for a range less than 2.");
         }
         return Number((Math.random() * 1000) % range);
      }

   }
}