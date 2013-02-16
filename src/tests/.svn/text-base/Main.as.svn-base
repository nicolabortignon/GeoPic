package tests
{
	import mx.rpc.soap.WebService;
	import roekensk.display.table.Table;
	import roekensk.geo.webservices.ElevationService;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import roekensk.geo.display.PlotGlideRatio;
	import roekensk.geo.utils.GeoCalculation;
	import roekensk.geo.objects.TimeStamp;
	import roekensk.geo.objects.TrackPoint;
	import roekensk.utils.Math2;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Main extends Sprite
	{
		public var xmlLoader:URLLoader = new URLLoader();
		public var es:ElevationService = new ElevationService();
		
		public var txtStart:TextField = new TextField();
		public var txtEnd:TextField = new TextField();
		
		public var track:Array = new Array();
		
		public var infoTable:Table;
		
		public function Main() 
		{
			xmlLoader.addEventListener(Event.COMPLETE, loadGpx);
			xmlLoader.load(new URLRequest("PG_edited.gpx"));
			
			var time:TimeStamp = new TimeStamp("2008-09-19T06:28:11Z");
			trace("day: "+time.month);
			
			var s:String = "12.3";
			
			trace("test: " + (parseFloat(s)+3));
			
			txtStart.text = "bla";
			txtEnd.text = "blo";
			
			txtStart.y = 50;
			txtEnd.y = 75;
			
			
			
			addChild(txtStart);
			addChild(txtEnd);
		}
		
		public function loadGpx(e:Event):void {
			var _content:XML = new XML(e.target.data);
			
			
			trace("ns: " + _content.namespace());
			var ns:Namespace = _content.namespace();
			
			//trace(_content.ns::trk[0]);
			//trace(_content.ns::trk[0].trkseg.trkpt.attribute("lat"));
			
			var beginLat:Number = parseFloat(_content.ns::trk[0].ns::trkseg.ns::trkpt[0].attribute("lat"));
			var beginLon:Number = parseFloat(_content.ns::trk[0].ns::trkseg.ns::trkpt[0].attribute("lon"));
			
			
			
			var endLat:Number = _content.ns::trk[0].ns::trkseg.ns::trkpt[_content.ns::trk[0].ns::trkseg.ns::trkpt.length() - 1].attribute("lat");
			var endLon:Number = _content.ns::trk[0].ns::trkseg.ns::trkpt[_content.ns::trk[0].ns::trkseg.ns::trkpt.length() - 1].attribute("lon");

			
			for (var i:Number = 0; i < _content.ns::trk[0].ns::trkseg.ns::trkpt.length(); i++) {
				
				var trk:XML = _content.ns::trk[0].ns::trkseg.ns::trkpt[i];
				
				var trackPoint:TrackPoint = new TrackPoint(trk.attribute("lat"), trk.attribute("lon"), trk.ns::ele, new TimeStamp(trk.ns::time));
				
				track.push(trackPoint);
			}
			
			trace("begin service");
			es.findElevation(track);
			es.addEventListener(Event.COMPLETE, onElevationServiceComplete);

		}
		
		public function onElevationServiceComplete(e:Event):void {
			trace("end service");
			track = es.heightArray;
			
			//trace("ms: " + GeoCalculation.findMedianSpeed(track));
			
			
			var grPlot:PlotGlideRatio = new PlotGlideRatio(track, 700, 200);
			grPlot.y = 200;
			addChild(grPlot);
		}
		
		public function calcDistance(p1:Point, p2:Point):Number {
			var r:Number = 6371; // straal aarde
			
			var dLat:Number = Math2.degToRad(p2.x - p1.x);
			var dLon:Number = Math2.degToRad(p2.y - p1.y);
			
			var a:Number = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(Math2.degToRad(p1.x)) * Math.cos(Math2.degToRad(p2.x)) * Math.sin(dLon/2) * Math.sin(dLon/2); 
			var c:Number = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
			var d:Number = r * c;
			
			return d;
		}
	}
	
}
