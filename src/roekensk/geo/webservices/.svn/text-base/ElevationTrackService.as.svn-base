package roekensk.geo.webservices 
{
	import alducente.services.WebService;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import roekensk.geo.objects.TrackPoint;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class ElevationTrackService extends ElevationService
	{
		
		private var ws:WebService = new WebService();
		//public var arr:Array;
		
		//public var trk:Array;
		
		public var heightArray:Array = new Array();
		private var counter:Number = 0;
		
		private static var unit:String = "meters";
		
		public function ElevationTrackService(track:Array) 
		{
			arr = track;
			ws.addEventListener(Event.CONNECT, onConnect);
			
			findElevation(arr);
			
		}
		
		public function findElevation(_arr:Array):void {
			this.arr = _arr;
			
			try {
				ws.connect("http://gisdata.usgs.gov/XmlWebServices/TNM_Elevation_service.asmx?WSDL");
			} catch (e:Error) {
				trace("ERROR: " + e.message);
			}
		}
		
		override public function getHeight(id:Number):Number {
			return trk[id];
		}
		
		public function onConnect(e:Event):void {
			trk = new Array();
			for (var i:Number = 0; i < arr.length; i++) {
				var tp:TrackPoint = arr[i] as TrackPoint;
				ws.getElevation(done, tp.lon, tp.lat, unit, -1, 1);
			}
			//ws.getElevation(done,"4.522445","50.810392","meters",-1,1);
			trace("gedaan");
			//dispatchEvent(new Event(Event.COMPLETE));
		}
		public function done(serviceResponse:XML):void {
			
			var soap:Namespace = serviceResponse.namespace();
	
			var b:XML = new XML(serviceResponse.soap::Body[0]);
			
			var serv:Namespace = new Namespace("http://gisdata.usgs.gov/XMLWebServices2/");
			
			
			var e:Number = b.serv::getElevationResponse[0].serv::getElevationResult[0].USGS_Elevation_Web_Service_Query.Elevation_Query.Elevation;
			
			var tp:TrackPoint = new TrackPoint("","","",null);
			tp.grnd = e;
			trk[counter] = e;//tp;
			heightArray[counter] = e;
			arr[counter].grnd = e;
			
			
			counter++;
			//trace("ele: "+e);
			trace("<hgt>" + e + "</hgt>");
			if(counter == arr.length) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		
		
	}
	
}