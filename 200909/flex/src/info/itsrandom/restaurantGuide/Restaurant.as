package info.itsrandom.restaurantGuide
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass("Restaurant")]
	[Bindable]
	public class Restaurant {
		public var id : Number;
		
		public var address : String;
		
		public var name : String;
		
		public var reviews : ArrayCollection;
		
		public var rating : Number;
		
		public function Restaurant() {
			this.id = 0;
			this.address = "";
			this.name = "";
			this.reviews = new ArrayCollection();
			this.rating = 0;
		}
		
		public function toString():String {
			return "[Restaurant]" + this.name;
		}
	}
}