package roekensk.display.objects 
{
	import com.google.maps.wrappers.SpriteFactory;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import roekensk.display.objects.events.PointerEvent;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Pointer extends Sprite
	{
		public var id:Number;
		
		private var ed:EventDispatcher = new EventDispatcher();
		public var holding:Boolean = false;
		
		public function Pointer(_x:Number,_y:Number) 
		{
			var s:Shape = new Shape();
			
			s.graphics.beginFill(0x33FFF00);
			s.graphics.lineStyle(1, 0x000000);
			s.graphics.moveTo(_x, _y);
			
			s.graphics.lineTo(_x - 5, _y - 10);
			s.graphics.curveTo(_x - 5, _y - 15, _x, _y - 16);
			s.graphics.curveTo(_x + 5, _y - 15, _x + 5, _y - 10);
			s.graphics.lineTo(_x, _y);
			
			addChild(s);
			
			//this.addEventListener(MouseEvent.MOUSE_UP, onClick);
		}
		
		public function onClick(e:Event):void {
			ed.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
			//dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
		}
		
		public function move(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
			
			ed.dispatchEvent(new PointerEvent(PointerEvent.MOVED));
		}
	}
	
}