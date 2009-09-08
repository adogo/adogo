package info.itsrandom.restaurantGuide
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="Restaurant")]
	public class Restaurant {
	   [Bindable]
		public var id : Number;
		
		[Bindable]
		public var address : String;
		
		[Bindable]
		public var name : String;
		
		[Bindable]
		public var bindableReviews : ArrayCollection;
		
		[Bindable]
		public var rating : Number;
		
		public function Restaurant() {
			this.id = 0;
			this.address = "";
			this.name = "";
			this.reviews = new Array();
			this.rating = 0;
		}
		
		public function get reviews() : Array
		{
		   return bindableReviews.source;
		}
		
		public function set reviews(reviews : Array) : void
		{
		   this.bindableReviews = new ArrayCollection(reviews);
		}
		
		public function toString():String {
			return "[Restaurant]" + this.name;
		}
	}
}