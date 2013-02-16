package com.nicolabortignon.geopic
{
	public class ApplicationCapabilities {
		private static var instance:ApplicationCapabilities;
		private static var allowInstantiation:Boolean;
		
		public  var mainWindowWidth:int;
		public  var mainWindowHeight:int;
		
		
		public static function getInstance():ApplicationCapabilities {
			if (instance == null) {
				allowInstantiation = true;
				instance = new ApplicationCapabilities();
				allowInstantiation = false;
			}
			return instance;
		}
		public function ApplicationCapabilities():void {
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
		}
	}
}