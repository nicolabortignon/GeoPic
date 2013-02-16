package roekensk.display 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import roekensk.display.objects.Button;
	import roekensk.display.objects.events.ButtonEvent;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class PopUpScreen extends Sprite
	{
		private var btnClose:Button;
		private var dit:DisplayObject;
		
		public function PopUpScreen()
		{
			dit = this;
			draw();
			
		}
		
		private function draw():void {
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0xCCCCCC, 0.80);
			bg.graphics.drawRect(0, 0, 600, 300);
			bg.graphics.endFill();
			
			btnClose = new Button("Close", 100, 20, 0xFFFFFF);
			btnClose.x = 250;
			btnClose.y = 270;
			btnClose.addEventListener(ButtonEvent.ON_RELEASE, onClose);
			
			addChild(bg);
			addChild(btnClose);
		}
		
		private function onClose(e:ButtonEvent):void {
			var bla:DisplayObject = e.target as DisplayObject;
			this.parent.parent.removeChild(bla);
			
		}
		
	}
	
}