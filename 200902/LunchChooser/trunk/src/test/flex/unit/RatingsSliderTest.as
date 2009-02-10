package unit
{
   import info.itsrandom.lunchchooser.events.RatingSliderChangeEvent;
   import info.itsrandom.lunchchooser.view.RatingsSlider;
   
   import mx.events.FlexEvent;
   import mx.events.SliderEvent;
   
   import net.digitalprimates.fluint.tests.TestCase;

   public class RatingsSliderTest extends TestCase
   {
      private var _slider : RatingsSlider;
      
      override protected function setUp() : void
      {
         _slider = new RatingsSlider();
         addChild(_slider);
      }
      
      public function testSliderDispatchesRatingSliderChangeEvent() : void
      {
         var result : Function = 
            function (event : RatingSliderChangeEvent) : void
            {
               assertEquals(2, event.rating);
            }
         
         _slider.addEventListener(RatingSliderChangeEvent.SLIDER_CHANGED, result, false, 0, true);  
         _slider.ratingSlider.dispatchEvent(new SliderEvent(SliderEvent.CHANGE, false, false, 2, 2));
      }
      
      override protected function tearDown() : void
      {
         removeChild(_slider);
         _slider = null;
      }
      
   }
}