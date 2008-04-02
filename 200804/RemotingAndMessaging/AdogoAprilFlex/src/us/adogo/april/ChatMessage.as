package us.adogo.april
{
	public class ChatMessage {
		public var sender : User;
		public var timestamp : Date;
		public var body : String;
		
		public function ChatMessage(){
			this.timestamp = new Date();
		}
	}
}