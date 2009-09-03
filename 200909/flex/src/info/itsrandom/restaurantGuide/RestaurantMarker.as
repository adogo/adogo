package info.itsrandom.restaurantGuide
{
   import com.google.maps.LatLng;
   import com.google.maps.overlays.Marker;
   import com.google.maps.overlays.MarkerOptions;

   public class RestaurantMarker extends Marker
   {
      private var _restaurant : Restaurant;
      
      public function RestaurantMarker(restaurant : Restaurant, point : LatLng, options : MarkerOptions = null) {
         super(point, options);
         _restaurant = restaurant;
      }
      
      public function get restaurant() : Restaurant {
         return _restaurant;
      }
      
   }
}