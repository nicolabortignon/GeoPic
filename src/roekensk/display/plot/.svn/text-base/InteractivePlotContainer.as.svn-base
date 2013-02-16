package roekensk.display.plot 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import roekensk.display.objects.SelectionBox;
	import roekensk.display.plot.events.PlotContainerEvent;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class InteractivePlotContainer extends PlotContainer
	{
		private var selectionBox:SelectionBox;
		private var tempX:Number = 0;
		
		private var selection:Array;
		
		private var player:Timer;
		
		public function InteractivePlotContainer(width:Number, height:Number, p:Plot) 
		{
			super(width, height, p);

			po.visible = true;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownOnPlot);
			addEventListener(PlotContainerEvent.POINTER_SELECTION_CHANGED, onSelectionChanged);
			addEventListener(PlotContainerEvent.POINTER_STOP_DRAG, onPointerStopDrag);
		}
		
		public function setSelection(sel:Array):void {
			this.selection = sel;
			
			redrawSelection();
			
		}
		public function getSelection():Array {
			return this.selection;
		}
		
		private function redrawSelection():void {
			this.setActiveId(selection[0]);
			movePointer(this.getActiveId(), calcCoords(this.getActiveId()));
			
			if (selectionBox != null) {
				removeChild(selectionBox);
			}
			selectionBox = new SelectionBox();
			addChild(selectionBox);

			selectionBox.x = calcCoords(getActiveId()).x + plotX;
			selectionBox.y = plotY;
			selectionBox.height = _p._height;
			selectionBox.width = calcCoords(selection[1]).x - selectionBox.x +plotX;
		}
		
		public function onMouseDownOnPlot(e:MouseEvent):void {
			if (selectionBox != null) {
				removeChild(selectionBox);
				selectionBox = new SelectionBox();
				addChild(selectionBox);
			}
			if (mouseWithinRange() && !po.holding) {

				selectionBox = new SelectionBox();
				selectionBox.x = tempX = mouseX;
				selectionBox.y = plotY;
				selectionBox.height = plots[0].height-2;
				addChild(selectionBox);
				this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				
				selection = new Array();
				selection.push(plots[0].findId(mouseX-plotX));
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpOnPlot);
			}
		}
		
		public function onMouseUpOnPlot(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpOnPlot);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		
			if (selection[1] == undefined) {
				selection[1] = selection[0];
			}
			selection.sort(Array.NUMERIC);
			setActiveId(selection[0]);
			
			movePointer(getActiveId(), calcCoords(getActiveId()));
			dispatchEvent(new PlotContainerEvent(PlotContainerEvent.PLOT_CLICKED));
			
			
		}
		
		private function onEnterFrame(e:Event):void {
			selectionBox.visible = true;
			if (mouseWithinRange()) {
				selection[1] = plots[0].findId(mouseX - plotX);
				if (mouseX < this._width && mouseX > 0) {
					var w:int = mouseX - tempX;
					if (w < 0) {
						selectionBox.x = mouseX;
						selectionBox.width = Math.abs(w);
					} else {
						selectionBox.width = mouseX - selectionBox.x;
					}
				}
			}
		}
		
		private function onSelectionChanged(e:PlotContainerEvent):void {
			if (selectionBox != null) {
				removeChild(selectionBox);
				selectionBox = new SelectionBox();
				addChild(selectionBox);
			}
			selectionBox.y = plotY;
			selectionBox.height = _p._height;
			selectionBox.x = _p.calcCoords(selection[0]).x;
			selectionBox.width = - selectionBox.x - _p.calcCoords(selection[1]).x ;
		}
		
		private function onPointerStopDrag(e:PlotContainerEvent):void {
			selection[0] = selection[1] = getActiveId();
			dispatchEvent(new PlotContainerEvent(PlotContainerEvent.PLOT_CLICKED));
		}
		
		override public function addPlot(p:Plot):void {
			super.addPlot(p);
			po.visible = true;
		}
		override public function redraw():void {
			super.redraw();
			po.visible = true;
		}
		
		public function play():void {
			var l:int = this._p.arr.length;
			var d:int;
			if (this.selection == null) {
				selection = [0, 0];
				d = 0
			} else {
			
				d = selection[0];
			}
			trace("l: " + l + " sel: " + selection[0]);
			if (selection[0] < l-1) {
				player = new Timer(100, this._p.arr.length-1 - selection[0]);
				player.addEventListener(TimerEvent.TIMER, playerHandler);
				player.addEventListener(TimerEvent.TIMER_COMPLETE, playerCompleteEvent);
				player.start();
			}
		}
		public function stop():void {
			player.stop();
			player.removeEventListener(TimerEvent.TIMER, playerHandler);
			player.removeEventListener(TimerEvent.TIMER_COMPLETE, playerCompleteEvent);
		}
		private function playerHandler(e:TimerEvent):void {
			setSelection([selection[0] + 1, selection[0] + 1]);
			dispatchEvent(new PlotContainerEvent(PlotContainerEvent.PLOT_CLICKED));
		}
		private function playerCompleteEvent(e:TimerEvent):void {
			var t:Timer = e.target as Timer;
			t.stop();
			t.removeEventListener(TimerEvent.TIMER, playerHandler);
			t.removeEventListener(TimerEvent.TIMER_COMPLETE, playerCompleteEvent);
		}
	}
	
}