package tests 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import roekensk.utils.Color;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class ColorTest extends Sprite
	{
		
		public function ColorTest() 
		{
			var s:Shape = new Shape();
			s.graphics.beginFill(Color.RGBtoHEX(255, 155, 0), 1);
			s.graphics.drawRect(0, 0, 20, 20);
			
			addChild(s);
		}
		
	}
	
}