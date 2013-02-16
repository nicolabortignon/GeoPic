package roekensk.views 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import roekensk.display.objects.Button;
	import roekensk.display.objects.events.ButtonEvent;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Screen extends Sprite
	{
		private var dragBar:Sprite;
		private var btnClose:Button;
		
		private var dragging:Boolean = false;
		
		private var itemToView:Sprite;
		
		private var title:String;
		
		public function Screen(item:Sprite,title:String="een niet zo willekeurig scherm") 
		{
			trace("width: " + item.width);

			this.title = title;
			itemToView = item;
			drawComp();
			
			addItem();
		}
		private function addItem():void {
			itemToView.x = 5;
			itemToView.y = 45;
			
			addChild(itemToView);
		}
		
		private function drawComp():void {
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0xDDDDDD, 0.90);
			bg.graphics.drawRect(0, 20, itemToView.width+10, itemToView.height+30);
			bg.graphics.endFill();
			addChild(bg);
			
			dragBar = new Sprite();
			dragBar.graphics.beginFill(0xBBBBDD, 0.90);
			dragBar.graphics.drawRect(0, 20, itemToView.width+10, 20);
			addChild(dragBar);
			
			btnClose = new Button("x", 15, 15);
			btnClose.x = itemToView.width - 30;
			btnClose.y = 25;
			btnClose.addEventListener(ButtonEvent.ON_RELEASE, onClose);
			addChild(btnClose);
			
			var txtTitle:TextField = new TextField();
			txtTitle.text = title;
			txtTitle.x = 5;
			txtTitle.y = 20;
			txtTitle.width = this.width - 40;
			txtTitle.selectable = false;
			dragBar.addChild(txtTitle);
			
			addListeners();
		}
		
		private function addListeners():void {
			dragBar.addEventListener(MouseEvent.MOUSE_DOWN, startDraggingScreen);
			dragBar.addEventListener(MouseEvent.MOUSE_UP, stopDraggingScreen);
		}
		
		private function startDraggingScreen(e:MouseEvent):void {
			if (!dragging) {
				this.startDrag();
				dragging = true;
			}
			
		}
		private function stopDraggingScreen(e:MouseEvent):void {
			dragging = false;
			this.stopDrag();
		}
		
		private function onClose(e:Event):void {
			e.target.removeEventListener(ButtonEvent.ON_RELEASE, onClose);
			dispatchEvent(new Event(Event.CLOSE));
		}
	}
	
}