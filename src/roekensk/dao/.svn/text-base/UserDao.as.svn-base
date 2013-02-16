package roekensk.dao 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import roekensk.flex.entities.User;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class UserDao extends EventDispatcher
	{
		private var loader:URLLoader;
		public var user:User;
		
		public function UserDao() 
		{
			loader = new URLLoader();
		}
		
		public function registerUser(user:User):void {
			var variables:URLVariables = new URLVariables();
			variables.password = user.password;
			variables.username = user.username;
			variables.email = user.email;
			
			var request:URLRequest = new URLRequest("http://127.0.0.1/flexTest/register.php");
			request.method = URLRequestMethod.POST;
			request.data = variables;
			
			loader.addEventListener(Event.COMPLETE, onRegisterRequestComplete);
			loader.load(request);
		}
		public function login(username:String, password:String):void {
			var variables:URLVariables = new URLVariables();
			
			variables.username = username;
			variables.password = password;
			
			var request:URLRequest = new URLRequest("http://krob.xtreemhost.com/flex/login.php");
			request.method = URLRequestMethod.POST;
			request.data = variables;
			
			loader.addEventListener(Event.COMPLETE, onLoginRequestComplete);
			loader.load(request);
		}
		public function listUsers():void {
			
		}
		
		
		
		
		/**
		 * 
		 * EVENTS
		 * 
		 */
		private function onLoginRequestComplete(e:Event):void {
			trace("login complete");
			var responseLoader:URLLoader = URLLoader(e.target);
			var resp:XML = XML(responseLoader.data);
			trace(resp.result);
			
			if (resp.feedback.user.attribute("id")!="") {
				user = new User(resp.feedback.user.username);
				user.id = resp.feedback.user.attribute("id");
			
				dispatchEvent(new UserDaoEvent(UserDaoEvent.LOGIN_SUCCESS));
				
			} else {
				dispatchEvent(new UserDaoEvent(UserDaoEvent.LOGIN_FAILED));
				trace("login fail");
				
			}
			loader.removeEventListener(Event.COMPLETE, onLoginRequestComplete);
		}
		
		private function onRegisterRequestComplete(e:Event):void {
			var responseLoader:URLLoader = URLLoader(e.target);
			
			var resp:XML = XML(responseLoader.data);
			trace(resp.result);
			
			if (resp.result == 1) {	
				dispatchEvent(new UserDaoEvent(UserDaoEvent.REGISTER_SUCCESS));
			} else {
				dispatchEvent(new UserDaoEvent(UserDaoEvent.REGISTER_FAILED));
			}
			loader.removeEventListener(Event.COMPLETE, onRegisterRequestComplete);
		}
	}
	
}