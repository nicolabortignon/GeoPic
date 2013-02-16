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
	public class ElevationPointService extends EventDispatcher
	{
		
		private var ws:WebService = new WebService();
		public var tp:TrackPoint;
		
		public var height:Number;
		private var counter:Number = 0;
		
		private static var unit:String = "meters";
		
		public function ElevationPointService() 
		{
			ws.addEventListener(Event.CONNECT, onConnect);
		}
		
		
		public function findElevation(t:TrackPoint):void {
			this.tp = t;
			trace("findElevation");
			ws.connect("http://gisdata.usgs.gov/XmlWebServices/TNM_Elevation_service.asmx?WSDL");
		}
		
		public function onConnect(e:Event):void {
			
				ws.getElevation(done, tp.lon, tp.lat, unit, -1, 1);
			
			//ws.getElevation(done,"4.522445","50.810392","meters",-1,1);
		}
		public function done(serviceResponse:XML):void {
			var soap:Namespace = serviceResponse.namespace();
	
			var b:XML = new XML(serviceResponse.soap::Body[0]);
			
			var serv:Namespace = new Namespace("http://gisdata.usgs.gov/XMLWebServices2/");
			
			
			var e:Number = b.serv::getElevationResponse[0].serv::getElevationResult[0].USGS_Elevation_Web_Service_Query.Elevation_Query.Elevation;
			
			trace("service: "+e);
			tp.grnd = e;
			height = e;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
	
}