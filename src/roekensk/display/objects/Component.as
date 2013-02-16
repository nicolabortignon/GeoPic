package roekensk.display.objects 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import roekensk.utils.Utils;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Component extends Sprite
	{
		public var _width:Number;
		public var _height:Number;
		public var _color:Number;
		
		public function Component(width:Number,height:Number,color:Number = 0xCCCCCC) 
		{
			_width = width;
			_height = height;
			_color = color;
			
			drawComp();
		}
		
		public function drawComp():void {
			var comp:Shape = new Shape();
			comp.graphics.beginFill(_color);
			comp.graphics.drawRect(0, 0, _width, _height);
			comp.graphics.endFill();
			
			addChild(comp);
		}
		
		//public function removeChildren():void {
		//	Utils.removeChildren(this);
		//}
		
	}
	
}