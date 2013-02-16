package roekensk.display.plot 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import roekensk.display.plot.events.PlotClickedEvent;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class ClickablePlotOverlay extends Sprite
	{
		private var overlay:Shape;
		private var _width:Number;
		private var _height:Number;
		private var _total:Number;
		
		public var id:Number;
		
		public function ClickablePlotOverlay(width:Number,height:Number,nrOfPoints:Number) 
		{
			_width = width;
			_height = height;
			_total = nrOfPoints;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseUp);
		}
		
		private function onMouseUp(e:MouseEvent):void {
			id:Number = Math.floor(mouseX/(this._width/_total));
			
			var ne:PlotClickedEvent = new PlotClickedEvent(PlotClickedEvent.ON_READY);
			dispatchEvent(ne);
		}
		
		public function putOverlay():void {
			overlay = new Shape();
			overlay.graphics.beginFill(0x000000, 0);
			overlay.graphics.drawRect(0, 0, _width, _height);
			overlay.graphics.endFill();
			addChild(overlay);
		}
		
	}
	
}