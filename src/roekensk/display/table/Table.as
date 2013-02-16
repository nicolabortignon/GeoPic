package roekensk.display.table 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import roekensk.display.objects.Component;
	import roekensk.display.objects.Information;
	import roekensk.display.table.TableCell;
	import roekensk.display.table.TableColumn;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Table extends Component
	{
		private var _inf:Array;
		private var _columns:Array;
		
		public function Table(width:Number, height:Number, inf:Array, cols:Array) 
		{
			super(width, 20*inf.length);
			_inf = inf;
			_columns = cols;
			
			addEventListener(Event.CHANGE, onContentChange);
			
			fillTable();
		}
		
		public function onContentChange(e:Event):void {
			removeChildren();
			fillTable();
		}
		
		public function fillTable():void {
			this._height = 20 * _inf.length;
			drawComp();
			
			var l:int = _columns.length;
			for (var i:int = 0; i < l; i++) {
				drawColumn(i,_columns[i] as TableColumn);
			}
			
		}
		
		/*override public function drawComp():void {
			var comp:Shape = new Shape();
			comp.graphics.beginFill(_color);
			comp.graphics.drawRect(0, 0, _width, _height);
			comp.graphics.endFill();
			
			addChild(comp);
		}*/
		
		public function drawColumn(colnr:Number, col:TableColumn):void {
			if (null != _inf) {
				var l:int = _inf.length;
				for (var i:int = 0; i < l; i++) {
					//var information:Information = _inf[i] as Information;
					var information:Object = _inf[i];
					
					var cell:TableCell = new TableCell(information[col._name]);//col._name]);
					cell.width = this.width / _columns.length;
					cell.x = colnr * cell.width;
					cell.y = i * cell.height;
					
					addChild(cell);
				}
			}
		}
		
		public function setInf(inf:Array):void {
			this._inf = inf;
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function setColums(cols:Array):void {
			this._columns = cols;
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function getInf():Array {
			return _inf;
		}
		public function getColumns():Array {
			return _columns;
		}
		
	}
	
}