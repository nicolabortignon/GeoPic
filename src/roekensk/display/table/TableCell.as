package roekensk.display.table 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import roekensk.utils.Math2;
	import roekensk.utils.StringUtils;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class TableCell extends Sprite
	{
		private var _content:String;
		
		public var txt:TextField = new TextField();
		
		public function TableCell(content:String) 
		{
			if (StringUtils.isNumeric(content)) {
				var nr:Number = new Number(content);
				_content = ""+Math2.roundDecimal(nr,2);
			} else {
				_content = content;
			}
			
			
			addEventListener(Event.CHANGE, onContentChange);
			
			drawCell();
			addChild(txt);
		}
		
		public function onContentChange(e:Event):void {
			drawCell();
		}
		
		public function drawCell():void {
			txt.x = 0;
			txt.y = 0;

			txt.text = _content;
			txt.textColor = 0x000000;
			
			txt.border = true;
			txt.height = 20;
			//txt.width = this.width;
			
			
		}
		
		public function setContent(content:String):void {
			this._content = content;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}
	
}