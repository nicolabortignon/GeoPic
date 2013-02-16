package roekensk.display.plot 
{
	import com.google.maps.wrappers.SpriteFactory;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import roekensk.display.objects.DraggablePointer;
	import roekensk.display.objects.events.PointerEvent;
	import roekensk.display.objects.Pointer;
	import roekensk.display.objects.Selection;
	import roekensk.display.plot.events.PlotClickedEvent;
	import roekensk.display.plot.events.PlotContainerEvent;
	import roekensk.display.plot.events.PlotEvent;
	import roekensk.utils.Math2;
	import roekensk.utils.Utils;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class PlotContainer extends Sprite
	{
		public var _p:Plot;
		public var _bg:Shape;
		public var plots:Array = new Array();
		
		public var plotBg:Sprite;
		
		public var _width:Number;
		public var _height:Number;
		
		public const borderLeft:Number = 75;
		public const borderTop:Number = 30;
		
		public var plotX:Number;
		public var plotY:Number;
		
		public var labelX:TextField;
		public var labelY:TextField;
		
		public var po:Pointer;
		
		private var clickedId:Number;
		
		
		public var scaleLines:Number;
		
		public function PlotContainer(width:Number, height:Number, p:Plot,lines:Number = 5) 
		{
			this._width = width;
			this._height = height;
			this.scaleLines = lines
			
			this._p = p;
			plots.push(p);
			
			plotX = borderLeft-5-10;
			plotY = borderTop / 4;

			drawContainer();
		}
		
		public function drawPlots():void {
			var l:int = plots.length;
			for (var i:int = 1; i < l; i++) {
			//for (var i:Number = plots.length+1; i <=1 ; i--) {
				plots[i].x = plotX;
				plots[i].y = plotY;
				plots[i].draw(_width - borderLeft, _height - borderTop);
				addChild(plots[i]);
				
				
			}
			// DRAW BASE PLOT ON TOP
			plots[0].x = plotX;
			plots[0].y = plotY;
			plots[0].draw(_width - borderLeft, _height - borderTop);
			addChild(plots[0]);
		}
		
		public function drawContainer():void {
			drawBackGround();
			
			drawLines();
			drawPlots();
			
			putPointer();
			
			putLabels();
		}
		
		public function addPlot(p:Plot):void {
			plots.push(p);
			redraw();
		}
		public function redraw():void {
			Utils.removeChildren(this);
			drawContainer();
		}


		private function putPointer():void {
			po = new DraggablePointer(0, 0);//p.x, p.y);
			movePointer(0, calcCoords(0));
			po.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownOnPointer);
			
			po.visible = false;
			addChild(po);
		}
		
		public function onMouseDownOnPointer(e:MouseEvent):void {	
			po.holding = true;
			po.addEventListener(Event.ENTER_FRAME, onEnterFramePointer);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		}
	
		private function onEnterFramePointer(e:Event):void {
			if (e.target.holding) {
	
				if (mouseWithinRange()) {
					po.x = mouseX;
					
					clickedId = findId(mouseX-plotX);
					po.y = calcCoords(clickedId).y + plotY;
					
					dispatchEvent(new PlotContainerEvent(PlotContainerEvent.POINTER_DRAGGING));
				}
			}
		}
		private function onMouseUpHandler(e:MouseEvent):void {
			if (e.target == po || po.contains(e.target as DisplayObject)) {
				dispatchEvent(new PlotContainerEvent(PlotContainerEvent.POINTER_STOP_DRAG));
				po.removeEventListener(Event.ENTER_FRAME, onEnterFramePointer);
				onReleasePointer(e);
			} else {
				dispatchEvent(new PlotContainerEvent(PlotContainerEvent.POINTER_STOP_DRAG));
				po.removeEventListener(Event.ENTER_FRAME, onEnterFramePointer);
				onReleaseOutsidePointer(e);
			}
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		}
		private function onReleasePointer(e:MouseEvent):void {
			loosePointer(e);
		}
		private function onReleaseOutsidePointer(e:MouseEvent):void {
			loosePointer(e);
		}
		private function loosePointer(e:MouseEvent):void {
			po.holding = false;
		}

		public function movePointer(id:Number,p:Point):void {
			po.move(p.x + plotX, p.y + plotY);
		}
				
		private function drawBackGround():void {
			_bg = new Shape();
			_bg.graphics.lineStyle(1, 0x000000);
			
			// bg
			_bg.graphics.beginFill(0xEEEEEE);
			_bg.graphics.drawRect(0, 0, this._width, this._height);
			_bg.graphics.endFill();
			
			// plot bg
			plotBg = new Sprite();
			
			_bg.graphics.lineStyle(1, 0xDDDDDD, 1);
			_bg.graphics.beginFill(0xDDDDDD);
			_bg.graphics.drawRect(plotX,plotY, _width - borderLeft, _height-borderTop);
			_bg.graphics.endFill();
			
			_bg.graphics.lineStyle(1, 0x000000);
			_bg.graphics.moveTo(plotX,plotY);
			_bg.graphics.lineTo(plotX, plotY+_height-borderTop);
			_bg.graphics.lineTo(plotX+_width - borderLeft,plotY+_height-borderTop);
			_bg.graphics.lineTo(plotX+_width - borderLeft,plotY);
			
			addChild(_bg);
		}
		
		private function drawLines():void {
			
			
			var highest:Number = plotY;
			var lowest:Number = plotY+_height-borderTop;
			
			var h:Number = lowest-highest;
			
			var lines:Shape = new Shape();
			for (var i:int = 0; i <= scaleLines; i++) {
				var yPos:Number = i * (h / scaleLines) + plotY;
				if(i!=scaleLines) {
					lines.graphics.lineStyle(1, 0xCCCCCC);
					lines.graphics.moveTo(plotX,yPos);
					lines.graphics.lineTo(plotX+_width - borderLeft, yPos);
				}
				putYLabels(yPos, i,scaleLines );
			}
			var xLabYPos:Number = _height - borderTop / 2 -5;
			
			for (var j:int = 1; j <= scaleLines; j++) {
				if(j!=scaleLines) {
					lines.graphics.moveTo(plotX+ j*((_width - borderLeft)/scaleLines), plotY);
					lines.graphics.lineTo(plotX + j * ((_width - borderLeft) / scaleLines), plotY + _height - borderTop);
				}
				putXLabels(xLabYPos,j, scaleLines);
			}
			addChild(lines);
		}
		
		private function putYLabels(yPos:Number,i:Number,amount:Number):void {
			var txt:TextField = new TextField();
			txt.selectable = false;
			
			
			var yMax:Number = ((_p.yMax - _p.yMin + _p.buffer)/_p._height)-_p._height;
			
			//var croppedHeight:Number = (h - yMin + buffer);
			var croppedMax:Number = (_p.yMax - _p.yMin + _p.buffer);
			//newY = (croppedHeight / croppedMax * _height) - _height;
			
			var croppedHeight:Number = (_height * croppedMax) / _height;
			
			var ele:Number = croppedHeight + _p.yMin - _p.buffer;
			
			var d:Number = _p.yMax - _p.yMin;
			d = d / amount;
			var t:String = "" + Math.abs(Math.round(_p.yMax-(d*i)));//Math.abs(Math.round((ele / amount) * (i - amount)));
			
			txt.text = t;//"" + yPos;
			txt.autoSize = TextFieldAutoSize.CENTER;
			txt.selectable = false;
			//txt.border = true;
			
			txt.x = plotX - (txt.width + 2);
			txt.y = yPos - (txt.height / 2);
			
			addChild(txt);
		}
		
		private function putXLabels(yPos:Number, i:Number, amount:Number):void {
			var txt:TextField = new TextField();
			txt.y = yPos;
			txt.x = plotX + i * ((_width - borderLeft) / amount) - 5-10;
			txt.selectable = false;
			txt.border = false;

			txt.width = 30;
			txt.height = 20;
			
			txt.text = "" + Math2.roundDecimal(_p.xMax / amount * i,2);
			
			addChild(txt);
			
			
		}
		
		private function putLabels():void {
			labelX = new TextField();
			labelY = new TextField();
			
			labelX.height = labelY.height = 20;
			
			labelX.selectable = false;
			labelY.selectable = false;
			
			labelY.x = (borderLeft / 3)-10;
			labelX.x = _width / 2;
			
			labelY.y = (_height-borderTop) / 2;
			labelX.y = _height - borderTop / 2 -5;
			
			labelX.text = _p.xLabel;
			labelY.text = _p.yLabel;
			
			addChild(labelX);
			addChild(labelY);
		}
		
		public function mouseWithinRange():Boolean {
			var isInRange:Boolean = false;
			
			if (((mouseX < (_width - 5)) && (mouseX > plotX)) && ((mouseY < _height-5) && (mouseY > plotY))) {
				isInRange = true;
			}
			
			return isInRange;
		}
		public function setActiveId(id:Number):void {
			this.clickedId = id;
			dispatchEvent(new PlotContainerEvent(PlotContainerEvent.POINTER_ACTIVE_ID_CHANGED));
		}
		public function getActiveId():Number {
			return this.clickedId;
		}	
		public function findId(xPos:Number):Number {
			return _p.findId(xPos);
		}
		
		public function calcCoords(id:Number):Point {
			return _p.calcCoords(id);
		}
		
	}
	
}