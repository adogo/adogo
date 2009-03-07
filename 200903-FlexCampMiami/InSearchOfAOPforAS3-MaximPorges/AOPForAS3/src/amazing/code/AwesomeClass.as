package amazing.code
{
	public class AwesomeClass
	{
		public function AwesomeClass() {  }
		
		public function add(numberOne : Number, numberTwo : Number) : Number
		{
			var startTime : Number = new Date().getTime();
			var result : Number = (numberOne + numberTwo);
			trace("add took " + (new Date().getTime() - startTime) + " ms");
			
			return result;
		}

		public function divide(numerator : Number, denominator : Number) : Number
		{
			var startTime : Number = new Date().getTime();
            var result : Number = (numerator / denominator);
            trace("divide took " + (new Date().getTime() - startTime) + " ms");
			
			return result;
		}

        public function multiply(numberOne : Number, numberTwo : Number) : Number
        {
        	var startTime : Number = new Date().getTime();
            var result : Number = (numberOne * numberTwo);
            trace("multiply took " + (new Date().getTime() - startTime) + " ms");
        	
            return result;
        }
	}
}