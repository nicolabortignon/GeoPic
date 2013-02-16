package tests 
{
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class TableTest extends Sprite
	{
		
		public function TableTest() 
		{
			var o:Object = new Object();
			o.titel = "bla";
			o.inhoud = "hmm";
			
			
			//var dp:DataProvider = new DataProv
			
			var arr:Array = new Array();
			arr.push(new DataGridColumn("titel"));
			
			var dg:DataGrid = new DataGrid();
			dg.width = 500;
			dg.height = 200;
			dg.dataProvider = o;
			dg.columns = arr;
			
			addChild(dg);
		}
		
	}
	
}