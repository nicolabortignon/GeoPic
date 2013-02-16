package
{
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;

	public class Main extends MovieClip
	{
		public var closeButton:MovieClip;
		public var minimizeButton:MovieClip;
		public var draggableBar:MovieClip;
		public function Main()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, completeDone);
			closeButton.addEventListener(MouseEvent.CLICK, closeApp);
			minimizeButton.addEventListener(MouseEvent.CLICK, minimizeApp);
			draggableBar.addEventListener(MouseEvent.MOUSE_DOWN, dragApplication);
		}
		private function exit(e:MouseEvent):void{
			trace("OU");
		}
		private function completeDone(e:Event):void{
			stage.nativeWindow.x = (Capabilities.screenResolutionX - stage.nativeWindow.width) / 2;
			stage.nativeWindow.y = (Capabilities.screenResolutionY - stage.nativeWindow.height) / 2;
			
		}
		
		private function closeApp(m:MouseEvent):void
		{
			trace("EXIT!");
			NativeApplication.nativeApplication.exit(); 
		}
		
		private function minimizeApp(m:MouseEvent):void
		{
			stage.nativeWindow.minimize();
		}
		
		function dragApplication(evt:MouseEvent):void
		{
			trace("OUCH");
			this.stage.nativeWindow.startMove();
		}
		
		
	}
}