package
{
	import com.nicolabortignon.geopic.ApplicationCapabilities;
	import com.nicolabortignon.geopic.LoginPanel;
	
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
	 
		public function Main()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,  completeDone);
			
			closeButton.addEventListener(MouseEvent.CLICK, closeApp);
			minimizeButton.addEventListener(MouseEvent.CLICK, minimizeApp);
			draggableNativeWindowBar.addEventListener(MouseEvent.MOUSE_DOWN, dragApplication);
			
			
		}
	 
		private function completeDone(e:Event):void{
 			trace("ADDED TO STAGE");
			var appIstance:ApplicationCapabilities = ApplicationCapabilities.getInstance();
			appIstance.mainWindowWidth = 1024;
			appIstance.mainWindowHeight = 768;
			
			stage.nativeWindow.x = (Capabilities.screenResolutionX - appIstance.mainWindowWidth) / 2;
			stage.nativeWindow.y = (Capabilities.screenResolutionY - appIstance.mainWindowHeight) / 2;
			
			
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