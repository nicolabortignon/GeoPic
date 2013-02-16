package roekensk.geo.webservices 
{
	import flash.events.EventDispatcher;
	import roekensk.geo.objects.Track;
	import roekensk.geo.objects.TripDay;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class TripXmlLoaderService extends XmlLoaderService
	{
		private var trip:Array = new Array();
		public var name:String = "TRIPXMLLOADER";
		
		public function TripXmlLoaderService(path:String) 
		{
			super(path);
		}
		
		override public function filterData(content:XML):void {
			
			var o:Object = new Object();
			//trace(content.day);
			var l:int = content.day.length();
			
			for (var i:int = 0; i < l; i++) {
				//o.id = content.day[i].attribute("id");
				//trace("stuk "+i+": "+content[i]);
			//	trace(content.day[i].attribute("id"));
				
				var day:TripDay = new TripDay();
				var tracks:int = content.day[i].track.length();
				for (var j:int = 0; j < tracks; j++) {
					var trackPath:String = content.day[i].track[j].file.text()
					var t:Track = new Track(j,content.day[i].track[j].file.text());
					day.addTrack(t);
					
				}
				trip.push(day);
			}
		}
		
		public function getTrip():Array {
			return this.trip;
		}
		
	}
	
}