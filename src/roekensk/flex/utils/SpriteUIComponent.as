package roekensk.flex.utils
{
	import flash.display.Sprite;
	import mx.core.UIComponent;
	
	/**
	 * ...
	 * @author krkcrd1
	 */
	public class SpriteUIComponent extends UIComponent
	{
		
		public function SpriteUIComponent(sprite:Sprite) 
		{
			super ();

			explicitHeight = sprite.height;
			explicitWidth = sprite.width;

			addChild (sprite);
		}
		
	}
	
}