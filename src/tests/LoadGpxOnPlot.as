package tests 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import roekensk.display.plot.InteractivePlotContainer;
	import roekensk.geo.display.PlotSpeed;
	import roekensk.geo.webservices.GpxService;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class LoadGpxOnPlot extends Sprite
	{
		
		public function LoadGpxOnPlot() 
		{
			var gpxService:GpxService = new GpxService();//"http://127.0.0.1/flexTest/" + "2/09/20090515.gpx");
			gpxService.load("http://krob.xtreemhost.com/flex/2/09/20090515.gpx");
			gpxService.addEventListener(Event.COMPLETE, onGpxServiceComplete);
			
		}
		
		private function onGpxServiceComplete(e:Event):void {
			var serv:GpxService = e.target as GpxService;
			var trk:Array = serv.getTrack();
			
			var plot:PlotSpeed = new PlotSpeed(trk);
			var plotCont:InteractivePlotContainer = new InteractivePlotContainer(400, 100, plot);
			
			addChild(plotCont);
		}
	}
	
}