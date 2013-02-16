package roekensk.views 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import roekensk.display.objects.Button;
	import roekensk.display.objects.events.ButtonEvent;
	import roekensk.display.plot.events.PlotContainerEvent;
	import roekensk.display.plot.InteractivePlotContainer;
	import roekensk.display.plot.PlotContainer;
	import roekensk.display.table.Table;
	import roekensk.display.table.TableColumn;
	import roekensk.geo.display.PlotElevation;
	import roekensk.geo.display.PlotGroundElevation;
	import roekensk.geo.display.PlotSpeed;
	import roekensk.geo.webservices.TrackService;
	import roekensk.utils.Utils;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class DetailScreen extends Sprite
	{
		private var elePlotCont:InteractivePlotContainer;
		private var spdPlotCont:InteractivePlotContainer;
		private var inf:Table ;
		
		private var trackService:TrackService;

		public var _name:String = "detailscreen";

		
		public function DetailScreen(ts:TrackService,hgt:Array=null) 
		{
			
			trackService = ts;
			//_parent = p;
	
			build();
			
		}
		public function build():void {
			var elePlot:PlotElevation = new PlotElevation(trackService.getTrack(), true, 2);
			var spdPlot:PlotSpeed = new PlotSpeed(trackService.getTrack());
			
			spdPlotCont = new InteractivePlotContainer(500, 100, spdPlot);
			elePlotCont = new InteractivePlotContainer(500, 200, elePlot);
			
			addPlotContainerEventListeners(spdPlotCont);
			addPlotContainerEventListeners(elePlotCont);
			
			/*if(hgt!=null) {
				var hgtPlot:PlotGroundElevation = new PlotGroundElevation(hgt, elePlot._width, elePlot._height, elePlot.yMax);
				hgtPlot.yMin = elePlot.yMin;
				elePlotCont.addPlot(hgtPlot);
			}*/
			
			spdPlotCont.y = 210;
			spdPlotCont.x = 0;
			
			elePlotCont.x = 0;
			elePlotCont.y = 0;
			addChild(spdPlotCont);
			addChild(elePlotCont);
			
		
			var titleCol:TableColumn = new TableColumn("_name");
			var valueCol:TableColumn = new TableColumn("_formattedValue");
			
			var cols:Array = new Array();
			cols.push(titleCol, valueCol);
			
			inf = new Table(150, 30, trackService.getDetails(null),cols);
			inf.x = 535;
			inf.y = 0;
			addChild(inf);
			
			dispatchEvent(new Event(Event.COMPLETE));
			trace("dispatched");
		}
		
		private function addPlotContainerEventListeners(pc:InteractivePlotContainer):void {
			pc.addEventListener(PlotContainerEvent.PLOT_CLICKED, onPlotContainerSelectionChanged);
		}
		
		private function onPlotContainerSelectionChanged(e:PlotContainerEvent):void {
			var pc:InteractivePlotContainer = e.target as InteractivePlotContainer;

			updateComponents(pc.getSelection(),pc);
		}
		
		private function updateComponents(selection:Array, source:Object = null):void {
			synchComponents(selection, source);
		}
		
		private function synchComponents(selection:Array, source:Object):void {
			if (spdPlotCont != null && spdPlotCont != source) {
				spdPlotCont.setSelection(selection);
			}
			if (elePlotCont != null && elePlotCont != source) {
				elePlotCont.setSelection(selection);
			}
			
			var information:Array = trackService.getDetails(selection);
			if (inf != null) {
				inf.setInf(information);
			}

		}
		
	}
	
}