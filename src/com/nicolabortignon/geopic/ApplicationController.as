package com.nicolabortignon.geopic
{
	public class ApplicationController {
		private static var instance:ApplicationController;
		private static var allowInstantiation:Boolean;
		
 		
		
		public var loginPanel:LoginPanel;
		public var userPanelMovieClip:UserPanel;
		public var tutorialPanel:TutorialPanel;
		
		
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
			tutorialPanel.show();
			
			
		}
		
		
		public function updateUserInformations(){
			userPanelMovieClip.login(SettingsManager.getInstance().username);
			
		}
		
		public function logoutUser():void{
			userPanelMovieClip.logout();
			SettingsManager.getInstance().deleteSettings();
			loginPanel.show();
			
		}
	}
}