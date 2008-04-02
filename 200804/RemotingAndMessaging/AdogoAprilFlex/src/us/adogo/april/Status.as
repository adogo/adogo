package us.adogo.april
{
	[RemoteClass(alias="us.adogo.april.rpc.Status")]
	public class Status {
		public var name : String;
		public var message : String;
		public var code : Number;
		
		public function toString() : String {
			return this.name;
		}
	}
}