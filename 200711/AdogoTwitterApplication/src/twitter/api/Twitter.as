/*
Twitter Library 2.0
*/
package twitter.api {
	import flash.net. *;
	import flash.xml.*;
	import flash.events.*;
	import com.dynamicflash.util.Base64;
	import twitter.api.events.TwitterEvent;
	import twitter.api.data.*;
	/**
		* Contains an array of Twitter status objects in the data object
		*/
	[Event(name="onFriendsResult",type="twitter.api.events.TwitterEvent")]
	/**
		* Contains an array of Twitter status objects in the data object
		*/
	[Event(name="onFriendsTimelineResult",type="twitter.api.events.TwitterEvent")]
	/**
		* Contains an array of Twitter status objects in the data object
		*/
	[Event(name="onUserTimelineResult",type="twitter.api.events.TwitterEvent")]
	/**
		* Contains an array of Twitter status objects in the data object
		*/
	[Event(name="onPublicTimelineResult",type="twitter.api.events.TwitterEvent")]
	/**
		* Containins the string "success" in the data object for a successful status update
		*/
	[Event(name="onSetStatus",type="twitter.api.events.TwitterEvent")]
	/**
		* Library provides access to the Twitter API. More information about Twitter at http://twitter.com
		 * 
		*/
		  		
	public class Twitter extends EventDispatcher{
		private var _friendsLoader:URLLoader;
		private var _friendsTimelineLoader:URLLoader;
		private var _publicTimelineLoader:URLLoader;
		private var _userTimelineLoader:URLLoader;
		private var _setStatusLoader:URLLoader;
		private var _username:String;
		private var _password:String;
		
		function Twitter() {
			_friendsLoader = new URLLoader ();
			_friendsLoader.addEventListener (Event.COMPLETE, friendsHandler);
			_friendsLoader.addEventListener (IOErrorEvent.IO_ERROR, errorHandler);
			_friendsLoader.addEventListener (SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			
			_friendsTimelineLoader= new URLLoader();
			_friendsTimelineLoader.addEventListener(Event.COMPLETE, friendsTimelineHandler);
			_friendsTimelineLoader.addEventListener (IOErrorEvent.IO_ERROR, errorHandler);
			_friendsTimelineLoader.addEventListener (SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			_publicTimelineLoader= new URLLoader();
			_publicTimelineLoader.addEventListener(Event.COMPLETE, publicTimelineHandler);
			_publicTimelineLoader.addEventListener (IOErrorEvent.IO_ERROR, errorHandler);
			_publicTimelineLoader.addEventListener (SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			_userTimelineLoader = new URLLoader ();
			_userTimelineLoader.addEventListener (Event.COMPLETE, userTimelineHandler);
			_userTimelineLoader.addEventListener (IOErrorEvent.IO_ERROR, errorHandler);
			_userTimelineLoader.addEventListener (SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			_setStatusLoader = new URLLoader ();
			_setStatusLoader.addEventListener (Event.COMPLETE, setStatusHandler);
			_setStatusLoader.addEventListener (IOErrorEvent.IO_ERROR, errorHandler);
			_setStatusLoader.addEventListener (SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			
		}
		/**
		*  setAuth should be called before any methods that require authentication. PLEASE USE WITH CAUTION, Twitter user information should NOT be hardcoded in applications that are publicly available
		*/
		public function setAuth (username:String, password:String):void
		
		{	
			_username = username;
			_password = password;
		}
		private function twitterRequest (URL : String):URLRequest
		{
			var r:URLRequest = new URLRequest (URL)
			if(_username != null &&  _password!=null){
				var login64 : String = Base64.encode (_username + ":" + _password);
				var rArray : Array = new Array (new URLRequestHeader ("Authorization", "Basic " + login64));
				r.requestHeaders = rArray;
				trace("sent auth: Basic " + login64)
			}
			
			return r;
		}
		/**
		* Loads a list of Twitter friends and their statuses. Authentication required for private users.
		*/
		public function loadFriends(userID:String):void{
			_friendsLoader.load(twitterRequest("http://twitter.com/statuses/friends/"+userID+".xml"));
			}
		/**
		* Loads the timeline of all friends on Twitter. Authentication required for private users.
		*/
		public function loadFriendsTimeline(userID:String):void{
			_friendsTimelineLoader.load(twitterRequest("http://twitter.com/statuses/friends_timeline/"+userID+".xml"));
			}
		/**
		* Loads the timeline of all public users on Twitter.
		*/
		public function loadPublicTimeline():void{
			_publicTimelineLoader.load(twitterRequest("http://twitter.com/statuses/public_timeline.xml"));
			}
		/**
		* Loads the timeline of a specific user on Twitter. Authentication required for private users.
		*/
		public function loadUserTimeline(userID:String):void{
			_userTimelineLoader.load(twitterRequest("http://twitter.com/statuses/user_timeline/"+userID+".xml"));
			}
		/**
		* Sets user's Twitter status. Authentication required.
		*/
		public function setStatus(statusString:String):void
		{
			if (statusString.length <= 140)
			{
				var request : URLRequest = twitterRequest ("http://twitter.com/statuses/update.xml");
				request.method = "POST"
				var variables : URLVariables = new URLVariables ();
				variables.status = statusString;
				request.data = variables;
				try
				{
					_setStatusLoader.load (request);
				} catch (error : Error)
				{
					trace ("Unable to set status");
				}
			} else 
			{
				trace ("STATUS NOT SET: status limited to 140 characters");
			}
		}
		
		private function friendsHandler(e:Event):void {
			var xml:XML = new XML(_friendsLoader.data);
			var statusArray:Array = new Array();
            for each (var tempXML:XML in xml.children()) {
				var twitterStatus:TwitterStatus = new TwitterStatus (tempXML)
                statusArray.push(twitterStatus );
            }
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_FRIENDS_RESULT);
			r.data = statusArray;
			dispatchEvent (r);
		}
			
		private function friendsTimelineHandler(e:Event):void {
			var xml:XML = new XML(_friendsTimelineLoader.data);
			var statusArray:Array = new Array();
            for each (var tempXML:XML in xml.children()) {
				var twitterStatus:TwitterStatus = new TwitterStatus (tempXML)
                statusArray.push(twitterStatus );
            }
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_FRIENDS_TIMELINE_RESULT);
			r.data = statusArray;
			dispatchEvent (r);
		}
		
		private function publicTimelineHandler(e:Event) :void{
			var xml:XML = new XML(_publicTimelineLoader.data);
			var statusArray:Array = new Array();
            for each (var tempXML:XML in xml.children()) {
				var twitterStatus:TwitterStatus = new TwitterStatus (tempXML)
                statusArray.push(twitterStatus );
            }
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_PUBLIC_TIMELINE_RESULT);
			r.data = statusArray;
			dispatchEvent (r);
		}
		
		private function userTimelineHandler(e:Event):void {
			var xml:XML = new XML(_userTimelineLoader.data);
			var statusArray:Array = new Array();
            for each (var tempXML:XML in xml.children()) {
				var twitterStatus:TwitterStatus = new TwitterStatus (tempXML)
                statusArray.push(twitterStatus );
            }
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_USER_TIMELINE_RESULT);
			r.data = statusArray;
			dispatchEvent (r);
		}
		
		
		private function setStatusHandler (e : Event) : void
		{
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_SET_STATUS);
			r.data = "success";
			dispatchEvent (r);
		}
		
		private function errorHandler (errorEvent : IOErrorEvent) : void
		{
			trace (errorEvent.text);
		}
	}
}