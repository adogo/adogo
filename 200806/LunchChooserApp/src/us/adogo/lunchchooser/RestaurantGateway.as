package us.adogo.lunchchooser
{
	import mx.collections.ArrayCollection;
	
	public class RestaurantGateway
	{
		[Bindable]
		public var restaurants : ArrayCollection;
		
		public function RestaurantGateway()
		{
			this.restaurants = new ArrayCollection();
			
			var r1 = new Restaurant();
			r1.name = "Place 1";
			r1.description = "Lorem1 ipsum dolor sit amet, consectetuer adipiscing elit. Fusce egestas. Donec pretium lacus eget lectus. Nulla a augue. Morbi sodales sodales eros. Nullam tincidunt nisi ac elit. Donec eget nibh in mi dictum aliquam. Curabitur non nisi. Quisque a neque a enim vehicula scelerisque. Fusce accumsan suscipit velit. Nulla facilisi. Integer sit amet pede. Aliquam nec nisl. Donec nisl elit, viverra et, aliquam sit amet, sodales in, mi. Nulla vel metus. Nullam sagittis tincidunt lacus. Integer auctor eleifend ante. In elementum fermentum risus. Fusce non tellus vitae mauris lacinia tincidunt. Cras ligula mi, vestibulum vitae, volutpat vel, lobortis ut, augue. Nam vel magna non orci ultricies venenatis. Praesent nec diam. Sed semper.";
			r1.genre = "Greek";
			r1.rating = 4;
			this.restaurants.addItem(r1);
			
			var r2 = new Restaurant();
			r2.name = "Place 2";
			r2.description = "Lorem2 ipsum dolor sit amet, consectetuer adipiscing elit. Fusce egestas. Donec pretium lacus eget lectus. Nulla a augue. Morbi sodales sodales eros. Nullam tincidunt nisi ac elit. Donec eget nibh in mi dictum aliquam. Curabitur non nisi. Quisque a neque a enim vehicula scelerisque. Fusce accumsan suscipit velit. Nulla facilisi. Integer sit amet pede. Aliquam nec nisl. Donec nisl elit, viverra et, aliquam sit amet, sodales in, mi. Nulla vel metus. Nullam sagittis tincidunt lacus. Integer auctor eleifend ante. In elementum fermentum risus. Fusce non tellus vitae mauris lacinia tincidunt. Cras ligula mi, vestibulum vitae, volutpat vel, lobortis ut, augue. Nam vel magna non orci ultricies venenatis. Praesent nec diam. Sed semper.";
			r2.genre = "Japanese";
			r2.rating = 5;
			this.restaurants.addItem(r2);
			
			var r3 = new Restaurant();
			r3.name = "Place 3";
			r3.description = "Lorem3 ipsum dolor sit amet, consectetuer adipiscing elit. Fusce egestas. Donec pretium lacus eget lectus. Nulla a augue. Morbi sodales sodales eros. Nullam tincidunt nisi ac elit. Donec eget nibh in mi dictum aliquam. Curabitur non nisi. Quisque a neque a enim vehicula scelerisque. Fusce accumsan suscipit velit. Nulla facilisi. Integer sit amet pede. Aliquam nec nisl. Donec nisl elit, viverra et, aliquam sit amet, sodales in, mi. Nulla vel metus. Nullam sagittis tincidunt lacus. Integer auctor eleifend ante. In elementum fermentum risus. Fusce non tellus vitae mauris lacinia tincidunt. Cras ligula mi, vestibulum vitae, volutpat vel, lobortis ut, augue. Nam vel magna non orci ultricies venenatis. Praesent nec diam. Sed semper.";
			r3.genre = "Italian";
			r3.rating = 2;
			this.restaurants.addItem(r3);
			
			var r4 = new Restaurant();
			r4.name = "Place 4";
			r4.description = "Lorem4 ipsum dolor sit amet, consectetuer adipiscing elit. Fusce egestas. Donec pretium lacus eget lectus. Nulla a augue. Morbi sodales sodales eros. Nullam tincidunt nisi ac elit. Donec eget nibh in mi dictum aliquam. Curabitur non nisi. Quisque a neque a enim vehicula scelerisque. Fusce accumsan suscipit velit. Nulla facilisi. Integer sit amet pede. Aliquam nec nisl. Donec nisl elit, viverra et, aliquam sit amet, sodales in, mi. Nulla vel metus. Nullam sagittis tincidunt lacus. Integer auctor eleifend ante. In elementum fermentum risus. Fusce non tellus vitae mauris lacinia tincidunt. Cras ligula mi, vestibulum vitae, volutpat vel, lobortis ut, augue. Nam vel magna non orci ultricies venenatis. Praesent nec diam. Sed semper.";
			r4.genre = "American";
			r4.rating = 1;
			this.restaurants.addItem(r4);
		}

	}
}