package roekensk.tools 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import roekensk.display.objects.Button;
	import roekensk.display.objects.events.ButtonEvent;
	import roekensk.display.plot.events.PlotContainerEvent;
	import roekensk.display.plot.InteractivePlotContainer;
	import roekensk.geo.display.PlotElevation;
	import roekensk.geo.display.PlotSelector;
	import roekensk.geo.objects.TrackPoint;
	import roekensk.geo.webservices.ElevationPointService;
	import roekensk.geo.webservices.GpxService;
	import roekensk.utils.QueryString;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class EditGpx extends Sprite
	{
		private var txtOutput:TextField;
		private var txtInfo:TextField;
		private var btnExtract:Button;
		private var plot:InteractivePlotContainer;
		
		private var track:Array;
		private var selection:Array;
		
		public function EditGpx() 
		{
			txtOutput = new TextField();
			txtOutput.multiline = true;
			txtOutput.width = 500;
			txtOutput.height = 300;
			txtOutput.x = 5;
			txtOutput.y = 235;
			txtOutput.border = true;
			
			txtOutput.text = "Loading gpx file...";
			addChild(txtOutput);
			
			btnExtract = new Button("Extract selection", 100, 20);
			btnExtract.disable();
			btnExtract.x = 400;
			btnExtract.y = 205;
			btnExtract.addEventListener(ButtonEvent.ON_RELEASE, onExtractClicked);
			addChild(btnExtract);
			
			txtInfo = new TextField();
			txtInfo.border = true;
			txtInfo.width = 300;
			txtInfo.height = 20;
			txtInfo.x = 5;
			txtInfo.y = 205;
			addChild(txtInfo);
			
			init();
			
		}
		
		private function init():void {
			var f:String = "";
			//trace(ExternalInterface.available);
			if (ExternalInterface.available && f == "") {
				var qs:QueryString = QueryString.getInstance();
				f = qs.getValue("track"); 
			}
			if (f =="") {
				f = "20100130.gpx";
			}
			
			var gpxServ:GpxService = new GpxService(f);
			gpxServ.load();
			gpxServ.addEventListener(Event.COMPLETE, onGpxLoaded);
		}
		
		private function onGpxLoaded(e:Event):void {
			var serv:GpxService = e.target as GpxService;
			
			txtOutput.text = "Gpx file loaded";
			track = serv.getTrack();
			
			createPlot();
		}
		private function onExtractClicked(e:ButtonEvent):void {
			trace("click!");
			
			createXml();
		}
		
		private function createPlot():void {
			var elePlot:PlotSelector = new PlotSelector(track);
			plot = new InteractivePlotContainer(500, 200, elePlot);
			plot.addEventListener(PlotContainerEvent.PLOT_CLICKED, onPlotClicked);
			
			addChild(plot);
		}
		private function onPlotClicked(e:PlotContainerEvent):void {
			var cont:InteractivePlotContainer = e.target as InteractivePlotContainer;
			var sel:Array = cont.getSelection();
			
			var dif:int = sel[0] - sel[1];
			if (dif != 0) {
				btnExtract.enable();
				selection = sel;
				var tp1:TrackPoint = track[sel[0]];
				var tp2:TrackPoint = track[sel[1]];
				txtInfo.text = "from: " + tp1.timeStamp.hours + ":" + tp1.timeStamp.minutes + " to: " + tp2.timeStamp.hours + ":" + tp2.timeStamp.minutes;
			} else {
				btnExtract.disable();
			}
		}
		
		private function createXml():void {
			var newTrack:Array = new Array();
			
			for (var i:int = selection[0]; i <= selection[1]; i++) {
				newTrack.push(track[i]);
			}
			
			var xmlHeader:String = "<?xml version = \"1.0\" encoding = \"UTF-8\" standalone = \"no\"?><gpx xmlns = \"http://www.topografix.com/GPX/1/1\" creator = \"\" version = \"1.1\" xmlns:xsi = \"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation = \"http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd\" >\n<trk>\n<name>Extracted</name>\n<trkseg>\n";
			var xmlEnding:String = "</trkseg> \n</trk>\n</gpx>";
			var nl:String = "\n";
			
			txtOutput.text = xmlHeader;
			
			var l:int = newTrack.length;
			var tp:TrackPoint;
			for (var j:int = 0; j < l; j++)
			{
				tp = newTrack[j];
				txtOutput.appendText(tp.toXMLString()+nl);
			}
			txtOutput.appendText(xmlEnding);
			
			
		}
	}
	
}