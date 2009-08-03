package us.adogo.simple {
	import org.flexunit.Assert;
	import org.flexunit.assertThat;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.number.greaterThan;
	
	import us.adogo.simple.SimpleMath;
	
	public class BasicMathTest {
	   public static var multiplier : Number = 0;
	   
		private var simpleMath:SimpleMath;
		private var simpleMath1:SimpleMath;

		[BeforeClass]
		public static function runBeforeClass():void {   
		     BasicMathTest.multiplier = 13; 
		}   
		  
		[AfterClass]  
		public static function runAfterClass():void {   
		    BasicMathTest.multiplier = -1;   
		}   

		[Before(order=1)]
		public function runBeforeEveryTest():void {   
		    simpleMath = new SimpleMath();   
		}   
		
		[Before(order=2)]
		public function alsoRunBeforeEveryTest():void {   
		    simpleMath1 = new SimpleMath();   
		}   
		  
		[After]  
		public function runAfterEveryTest():void {   
		    simpleMath = null;   
		    simpleMath1 = null;   
		} 

		[Test]  
		public function addition():void {   
		    Assert.assertEquals(12, simpleMath.add(7, 5));   
		}

		[Test]  
		public function subtraction():void {   
		    Assert.assertEquals(9, simpleMath.subtract(12, 3));   
		}

		[Test(expects="TypeError")]  
		public function divisionWithException():void {   
		    simpleMath.divide( 11, 0 );
		} 

		[Ignore("Not Ready to Run")]   
		[Test]  
		public function multiplication():void {   
		    Assert.assertEquals(15, simpleMath.multiply(3, 5));   
		}

		[Test]
		public function testGreaterThan():void {  
			assertThat( 11, greaterThan(3) );
		}
		
		[Test]
		public function isItInHere():void {  
			var someArray:Array = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
			assertThat( someArray, hasItems("b", "c") );
		}
		
	}
}