package com.maximporges.store
{
	import mx.rpc.IResponder;
	
	/**
	 * Domain object representing a Product. Doesn't do anything terribly exciting
	 * in its present form.
	 */
	[Bindable]
	public class Product 
	{
		public var id : Number;
		public var name : String;
		public var description : String;
		public var price : Number; 
		public var image : String;
		public var thumbnail : String;

		public function get identifier() : String
		{
			return id as String;
		}
	}
}