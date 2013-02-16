package roekensk.display.objects 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import roekensk.display.objects.events.OptionFieldEvent;
	import roekensk.objects.Option;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class OptionField extends TextField
	{
		public var id:Number;
		public var option:Option;
		
		public function OptionField(option:Option,id:Number = 0) 
		{
			super();
			this.option = option;
			this.text = option.name;
			this.height = 17;
			
			//this.selectable = false;
			
			//this.mouseChildren = false;
			//this.useHandCursor = false;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseOver(e:MouseEvent):void {
			trace("over");
			this.backgroundColor = 0xAAAAFF;
		}
		private function onMouseOut(e:MouseEvent):void {
			this.backgroundColor = 0xFFFFFF;
		}
		private function onMouseUp(e:MouseEvent):void {
			dispatchEvent(new OptionFieldEvent(OptionFieldEvent.OPTION_SELECTED));
		}
		
	}
	
}