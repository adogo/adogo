var userText = '#chat .username input';
var messageList = '#chat .messages';
var newMessageText = '#chat .newMessage textarea';
var messageButton = '#chat .newMessage button';

//Ideally these global variables could be wrapped in some type of proxy object
var producer = null;
var consumer = null;
var topic = "chat-topic";

//bootstrap FDS bridge (callback fxn called after bridge is loaded)
FDMSLibrary.load("/adogo_ajax_explained/lib/FDMSBridge.swf", configureBridge);

$(document).ready(function() {
   $(messageButton).click(sendMessage);   
});

function configureBridge(){
   var channelSet = new ChannelSet();
   channelSet.addChannel(
      new StreamingAMFChannel("my-streaming-amf", 
            "http://localhost:8400/blazeds/messagebroker/streamingamf")
   );
   
   //set up ability to send chat messages
   producer = new Producer();
   producer.setDestination(topic);
   producer.setChannelSet(channelSet);

   //set up ability to recieve chat message
   consumer = new Consumer();
   consumer.setDestination(topic);
   consumer.addEventListener("message", receiveMessage);
   consumer.setChannelSet(channelSet);
   consumer.subscribe();
}

function sendMessage() {  
   var message = new AsyncMessage();
   
   //build payload
   var body = {
      'user': $(userText).val(),
      'text': $(newMessageText).val(),
      'timestamp': new Date()
   };
   
   message.setBody(body);
   
   //transmit message to BlazeDS
   producer.send(message);
}

function receiveMessage(event) {
   //code to get payload(body) out of message
   var message = event.getMessage().getBody();   
   
   //create an <li> to represent the chat payload
   $(messageList + ' > ul').append(
      $('<li/>').html(
         '<span class="'
         + (message.user == $(userText).val() ? 'me' : 'them') 
         + '">' 
         + '(' + message.timestamp.format("yyyy-mm-dd HH:MM:ss") + ') ' 
         + message.user + ' : ' + '</span>' 
         + message.text
      )
   );
}