package roekensk.display.objects 
{
	import flash.display.Shape;
	import flash.text.TextField;
	import roekensk.display.objects.events.ListEvent;
	import roekensk.display.objects.events.OptionFieldEvent;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class List extends Component
	{
		private var content:Array = new Array();
		public var selectedId:Number = 0;
		
		public function List(content:Array) 
		{
			super(100, 200, 0xFF0000);
			this.content = content;
			
			drawComp();
		}
		
		override public function drawComp():void {
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0xFFFFFF, 0.75);
			bg.graphics.lineStyle(1, 0x000000);
			bg.graphics.drawRect(0, 0, width, height);
			bg.graphics.endFill();
			
			fillList();
		}
		
		public function fillList():void {
			var l:int = content.length;
			for (var i:int = 0; i < l; i++) {
				var txt:OptionField = new OptionField(content[i],i);
				//txt.text = content[i].toString();
				txt.y = i * 17;
				txt.border = true;
				
				txt.addEventListener(OptionFieldEvent.OPTION_SELECTED, optionSelected);
				
				addChild(txt);
			}
		}
		private function optionSelected(e:OptionFieldEvent):void {
			trace("selected!!");
			selectedId = e.target.id;
			dispatchEvent(new ListEvent(ListEvent.ITEM_SELECTED));
		}
	}
	
}