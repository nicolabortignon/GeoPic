package tests 
{
	import com.google.maps.MapEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import roekensk.display.plot.InteractivePlotContainer;
	import roekensk.geo.display.PlotSpeed;
	import roekensk.geo.google.TrackMap;
	import roekensk.geo.objects.TrackPoint;
	import roekensk.geo.utils.DouglasPeucker;
	import roekensk.geo.webservices.GpxService;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class DouglasPeuckerTest extends Sprite
	{
		private var track:Array;
		private var gpxService:GpxService;
		public function DouglasPeuckerTest() 
		{
			gpxService = new GpxService();//"http://127.0.0.1/flexTest/" + "2/09/20090515.gpx");
			gpxService.load("PG_edited.gpx");
			gpxService.addEventListener(Event.COMPLETE, onGpxServiceComplete);
			
		}
		
		private function onGpxServiceComplete(e:Event):void {
			var serv:GpxService = e.target as GpxService;
			var trk:Array = serv.getTrack();
			trace("tracklength: " + trk.length);
			var plot:PlotSpeed = new PlotSpeed(trk);
			var plotCont:InteractivePlotContainer = new InteractivePlotContainer(400, 100, plot);
			
			addChild(plotCont);
			
			var tp:TrackPoint = trk[1] as TrackPoint;
			trace(tp.lat.valueOf());
			
			var dp:DouglasPeucker = new DouglasPeucker();
			dp.addEventListener(Event.COMPLETE, onDPComplete);
			
			dp.calculate(gpxService.getTrack(), 12);
		}
		private function onDPComplete(e:Event):void {
			trace("complete");
			var dp:DouglasPeucker = e.target as DouglasPeucker;
			track = dp.result;
			trace(dp.result.join());
			
			var map:TrackMap = new TrackMap();
			map.key = "bla";
			map.setSize(new Point(500, 300));
			
			
			
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			addChild(map);
		}
		private function onMapReady(e:MapEvent):void {
			var map:TrackMap = e.target as TrackMap;
			map.createTrackOnMap(track, null);
		}
	}
	
}