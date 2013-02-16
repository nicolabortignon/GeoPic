package roekensk.display.plot 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import roekensk.display.objects.events.SelectionEvent;
	import roekensk.display.objects.Selection;
	import roekensk.display.objects.SelectionBox;
	import roekensk.display.plot.events.PlotEvent;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class SelectablePlot extends Plot
	{
		private var tempSelection:Selection;
		private var selecting:Boolean = false;
		private var tempX:Number = 0;
		
		private var selectionBox:SelectionBox;
		
		public function SelectablePlot(arr:Array) 
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			super(arr);
		}
		
		private function onMouseDown(e:MouseEvent):void {
			if (selection == null) {
				trace("bla");
				selection = new Selection();
				selection.items.push(findId(mouseX));
			}
			selecting = true;
			
			if (selectionBox != null) {
				removeChild(selectionBox);
			}
			selectionBox = new SelectionBox();
			selectionBox.x = tempX = mouseX;
			this.addChild(selectionBox);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onEnterFrame(e:Event):void {
			//trace("onEnterFrame");
			selectionBox.visible = true;
			//selectionBox.x = calcCoords(findId(selection.items[0])).x;
			selectionBox.y = this.y-7;
			
			if (mouseX < this._width && mouseX > 0) {
				var w:Number = mouseX - tempX;
				if (w < 0) {
					selectionBox.x = mouseX;
					selectionBox.width = Math.abs(w);
				} else {
					selectionBox.width = mouseX - selectionBox.x;
				}
				selectionBox.height = this._height;
			}
		}
		
		private function onMouseUp(e:MouseEvent):void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			if (e.target == this || this.contains(e.target as DisplayObject)) {
				onRelease(e);
			} else {
				onReleaseOutside(e);
			}
			selecting = false;
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onRelease(e:MouseEvent):void {
			selection.items.push(findId(mouseX));
			selection.items.sort(Array.NUMERIC);
			trace(selection.items.join());
			
			dispatchEvent(new PlotEvent(PlotEvent.ON_SELECTED));
			
			selection = null;
		}
		private function onReleaseOutside(e:MouseEvent):void {
			selection = null;
		}
		
	}
	
}