package us.adogo.simple {
	import org.flexunit.Assert;
	import org.flexunit.assertThat;
	import org.flexunit.assumeThat;
	import org.hamcrest.core.CombinableMatcher;
	import org.hamcrest.core.both;
	import org.hamcrest.core.isA;
	import org.hamcrest.number.greaterThan;
	import org.hamcrest.number.lessThan;
	
	import us.adogo.simple.SimpleMath;
	
	[RunWith("org.flexunit.experimental.theories.Theories")]
	public class TheoryTest {

		private var simpleMath:SimpleMath = new SimpleMath();

		[DataPoints]
		[ArrayElementType("String")]
		public static var stringValues:Array = ["one","two","three","four","five"];
		
		[DataPoint]
		public static var values1:int = 2;
		
		[DataPoint]
		public static var values2:int = 4;
		
		[DataPoints]
		[ArrayElementType("int")]
		public static function provideData() : Array {
			return [-10, 0, 2, 4, 8, 16 ];
		}
		
		[Theory]
		public function testOnlyNegativeValues(value1 : int) : void {
		   assumeThat(value1, lessThan(0));
		   
		   assertThat(value1, both(lessThan(0)).and(isA(Number)) as CombinableMatcher);
		   Assert.assertTrue((value1 * -1) > 0);
		}
		
		[Theory]
		public function testDivideMultiply(value1:int, value2:int):void {
			assumeThat(value2, greaterThan(0));
			
			try {
			   var div:Number = simpleMath.divide(value1, value2);
			   var mul:Number = simpleMath.multiply(div, value2);
			}
			catch(e : Error) {
			   Assert.fail("Dived by zero error should not occur!");
			}
			
			Assert.assertEquals(mul, value1);
		}		
		
		[Theory]
		public function testStringIntCombo(value:int, stringValue:String):void {			
			//call some method which requires an int and a string and make sure it works :)
		}
	}
}