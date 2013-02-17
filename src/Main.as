package
{
	import com.nicolabortignon.geopic.ApplicationCapabilities;
	import com.nicolabortignon.geopic.LoginPanel;
	import com.nicolabortignon.geopic.SettingsManager;
	import com.nicolabortignon.geopic.userPanel;
	
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;

	public class Main extends MovieClip
	{
		public var closeButton:MovieClip;
		public var minimizeButton:MovieClip;
		public var loginPanel:LoginPanel;
		public var userPanelMovieClip:userPanel;
	 
		public function Main()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,  completeDone);
			
			closeButton.addEventListener(MouseEvent.CLICK, closeApp);
			minimizeButton.addEventListener(MouseEvent.CLICK, minimizeApp);
			draggableNativeWindowBar.addEventListener(MouseEvent.MOUSE_DOWN, dragApplication);
			
			SettingsManager.getInstance().loadCredentials();
			
		}
	 
		private function completeDone(e:Event):void{
 	 
			var appIstance:ApplicationCapabilities = ApplicationCapabilities.getInstance();
			appIstance.mainWindowWidth = 1024;
			appIstance.mainWindowHeight = 768;
			
			stage.nativeWindow.x = (Capabilities.screenResolutionX - appIstance.mainWindowWidth) / 2;
			stage.nativeWindow.y = (Capabilities.screenResolutionY - appIstance.mainWindowHeight) / 2;
			
			var credentialAvailable:Boolean = SettingsManager.getInstance().loadCredentials();
			
			if(credentialAvailable){
				 
				loginPanel.automaticLogin();
			}
			loginPanel.show();
		}
		
		private function closeApp(m:MouseEvent):void
		{ 
			NativeApplication.nativeApplication.exit(); 
		}
		
		private function minimizeApp(m:MouseEvent):void
		{
			stage.nativeWindow.minimize();
		}
		
		function dragApplication(evt:MouseEvent):void
		{ 
			this.stage.nativeWindow.startMove();
		}
		
		
	}
}