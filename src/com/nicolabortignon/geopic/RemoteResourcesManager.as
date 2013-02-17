package com.nicolabortignon.geopic
{
	import com.adobe.crypto.MD5;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class RemoteResourcesManager {
		private static var instance:RemoteResourcesManager;
		private static var allowInstantiation:Boolean;
		
	
		public static const loginURL:String = "http://www.stopsharing.me/geopic/login.php";
		
		
		public var loginCallbackFunction:Function;
		
		public static function getInstance():RemoteResourcesManager {
			if (instance == null) {
				allowInstantiation = true;
				instance = new RemoteResourcesManager();
				allowInstantiation = false;
			}
			return instance;
		}
		public function RemoteResourcesManager():void {
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
		}
		
		
		public function tryLoginRegister(username:String,password:String,callback:Function):void{
			if(ApplicationCapabilities.getInstance().debugMode) trace("CALL REMOTE LOGIN SYSTEM =========");
			if(ApplicationCapabilities.getInstance().debugMode) trace("username: "+username+" password (MD5): "+password);
			loginCallbackFunction = callback;
			
			var loader : URLLoader = new URLLoader();  
			var request : URLRequest = new URLRequest(loginURL);  
			
			request.method = URLRequestMethod.POST;  
			var variables : URLVariables = new URLVariables();  
			variables.email = username;  
			variables.password = password;  
			request.data = variables;  
			
			//  Handlers  
			loader.addEventListener(Event.COMPLETE, onCompleteLoginRegister);  
			loader.load(request);  
		 
			
		}
		private function onCompleteLoginRegister(e : Event):void{ 
		 
			var s:String = e.target.data;
			loginCallbackFunction(s);
		}
	}
}