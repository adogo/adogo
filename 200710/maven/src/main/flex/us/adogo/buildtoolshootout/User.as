package us.adogo.buildtoolshootout
{
	public class User
	{
		public var id : Number = 0;
		public var login : String = "";
		public var pass : String = "";
		public var first_name : String = "";
		public var last_name : String = "";
		public var email : String = "";
		public var url : String = "";

		public function getName() : String
		{
			return this.first_name + ' ' + this.last_name;
		}
	}
}