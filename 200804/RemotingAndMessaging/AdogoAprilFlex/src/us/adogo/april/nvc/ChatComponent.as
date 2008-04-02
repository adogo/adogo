package us.adogo.april.nvc
{
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	import mx.messaging.Consumer;
	import mx.messaging.Producer;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AsyncMessage;
	import mx.utils.ObjectUtil;
	
	import us.adogo.april.ChatMessage;
	import us.adogo.april.User;
	
	public class ChatComponent
	{	
		[Bindable]
		public var user : User;
			
		[Bindable]
		public var messages : String = "";
		
		private const DESTINATION_ID : String = "chat-topic";
		
		private var producer : Producer;
		private var consumer : Consumer;
		
		public function ChatComponent() {
			this.producer = new Producer();
			this.producer.destination = DESTINATION_ID;
			this.producer.addEventListener(MessageFaultEvent.FAULT, onProducerFault);
			
			this.consumer = new Consumer();
			this.consumer.destination = DESTINATION_ID;
			this.consumer.addEventListener(MessageEvent.MESSAGE, onConsumerMessage);
			this.consumer.subscribe();
		}
		
		public function sendMessage(message : ChatMessage) : void {		
			var asyncMessage : AsyncMessage = new AsyncMessage();
			asyncMessage.headers = new Array(2);
			asyncMessage.headers["sender"] = message.sender.name;
			asyncMessage.headers["timestamp"] = message.timestamp;
			asyncMessage.body = message.body;
			
			this.producer.send(asyncMessage); 
		}
				
		private function onProducerFault(event : MessageFaultEvent) : void {
			Alert.show("Unable to send message.");
		}
				
		private function onConsumerMessage(event : MessageEvent) : void {
			var message : ChatMessage = new ChatMessage();

			var user : User = new User();		
			user.name = event.message.headers["sender"];			

			message.sender = user;
			message.timestamp = event.message.headers["timestamp"];
			message.body = event.message.body as String;
			
			this.appendMessage(message);
		}
		
		//This method reduces cohesion because the NVC is not only a proxy for the queue, 
		//but it is also rendering the content from the queue for the chat window
		private function appendMessage(message : ChatMessage) : void {
			var formatter : DateFormatter = new DateFormatter();
			formatter.formatString = "LL:NN:SS A";
			
			var formattedMessage : String = "(" + formatter.format(message.timestamp) + ") " + message.sender.name + ": " + message.body;
			
			if(this.messages != "") {
				formattedMessage = "\n" + formattedMessage; 
			}
			
			//Flex's inability to render inline CSS rocks!  <font> tags forever!
			if(ObjectUtil.compare(message.sender, this.user) == 0) {
				formattedMessage = "<font color='#FF0000'>" + formattedMessage + "</font>";
			}
			else {
				formattedMessage = "<font color='#0000FF'>" + formattedMessage + "</font>";
			}
			
			this.messages += formattedMessage;
		}
	}
}