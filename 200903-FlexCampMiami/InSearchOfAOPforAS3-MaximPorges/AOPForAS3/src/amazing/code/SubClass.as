package amazing.code
{
	import flash.utils.Dictionary;
	
	public class SubClass extends BaseClass
	{
		public var closures : Dictionary;
		
		public function SubClass()
		{
			super();
			closures = new Dictionary();
		}

        override public function doSomething() : void
        {
        	if (closures["doSomething"])
        	{
        		closures["doSomething"].apply(this, arguments);
        	}
        	
        	super.doSomething();
        }		
	}
}