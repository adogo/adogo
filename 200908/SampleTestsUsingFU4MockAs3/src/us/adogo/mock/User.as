package us.adogo.mock
{
   import mx.events.DynamicEvent;
   import mx.rpc.AsyncToken;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.remoting.RemoteObject;
   
   public class User
   {
      public var id : Number;
      public var username : String;
      public var password : String;
      public var rememberMe : Boolean = false;
      public var account : Account;

      public var service : RemoteObject;

      public function save() : void {
         var token : AsyncToken = this.service.save(this);
         token.addEventListener(ResultEvent.RESULT, function(event : DynamicEvent) : void {
               id = event.id;
            });
      }
   }
}