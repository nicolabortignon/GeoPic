package com.nicolabortignon.geopic
{
	public class ApplicationController {
		private static var instance:ApplicationCapabilities;
		private static var allowInstantiation:Boolean;
		
 		
		
		public loginPanel:LoginPanel;
		
		
		public static function getInstance():ApplicationController {
			if (instance == null) {
				allowInstantiation = true;
				instance = new ApplicationController();
				allowInstantiation = false;
			}
			return instance;
		}
		public function ApplicationController():void {
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
		}
		
		
		public function beginTutorial(){
			
			
			
		}
		
		
		public function updateUserInformations(){
			
			
		}
	}
}