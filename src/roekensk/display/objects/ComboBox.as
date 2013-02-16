package roekensk.display.objects 
{
	import flash.text.TextField;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class ComboBox extends Component
	{
		private var options:Array = new Array();
		private var selectedId:Number = 0;
		public function ComboBox(width:Number, height:Number,color:Number=0xFF0000) 
		{
			super(width, height, color);
			
			drawComp();
		}
		
		override public function drawComp():void {
			var txt:TextField = new TextField();
			
			var btn:Button = new Button("V", 20, 20);
			
			txt.width = 100;
			txt.height = 19;
			txt.border = true;
			
			btn.x = 101;
			
			addChild(txt);
			addChild(btn);
		}
		
	}
	
}