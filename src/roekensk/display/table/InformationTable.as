package roekensk.display.table 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import roekensk.display.table.Table;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class InformationTable extends Table
	{
		var bg:Shape = new Shape();
		var table:Shape;
		
		var _width:Number;
		var _height:Number;
		
		var _inf:Array = new Array();
		
		public function InformationTable(width:Number,height:Number,inf:Array) 
		{
			var bg:Shape = drawBg();
			var table:Shape = drawTable();
			
			addChild(bg);
			addChild(table);
		}
		
		public function addInformationArray() {
			
		}
		public function addInformation() {
			
		}
		
	}
	
}