package roekensk.geo.webservices 
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import roekensk.geo.objects.TimeStamp;
	import roekensk.geo.objects.TrackPoint;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class GpxService  extends EventDispatcher
	{
		public var id:int;
		private var track:Array;
		
		private var file:String;
		public function GpxService(path:String="") 
		{
			file = path;
		}
		
		public function load(path:String=""):void {
			try {
				var xmlLoader:URLLoader = new URLLoader();
				
				if (path.length <= 1) {
					path = file;
				}
				xmlLoader.addEventListener(Event.COMPLETE, onLoad);
				xmlLoader.load(new URLRequest(path));
			} catch (e:IOError) {
				trace(e.message);
			}
		}
		
		private function onLoad(e:Event):void {
			var _content:XML = new XML(e.target.data);
			
			track = new Array();
			
			var ns:Namespace = _content.namespace();

			
			
			var trkL:int = _content.ns::trk.length();
			var segL:int;
			var pntL:int;
			var pnt:XML, trackPoint:TrackPoint;
			const MAX_POINTS:int = 1000;
			trace("trkL: "+trkL);
			for (var k:int = 0; k < trkL; k++) {
				segL = _content.ns::trk[k].ns::trkseg.length();
				for (var j:int = 0; j < segL; j++) {
					pntL = _content.ns::trk[k].ns::trkseg[j].ns::trkpt.length();
					if (pntL > MAX_POINTS) {
						pntL = MAX_POINTS;
					}
					for (var i:int = 0; i < pntL; i++) {
						pnt = _content.ns::trk[k].ns::trkseg[j].ns::trkpt[i];
						trackPoint = new TrackPoint(pnt.attribute("lat"), pnt.attribute("lon"), pnt.ns::ele, new TimeStamp(pnt.ns::time));
						
						track.push(trackPoint);
					}
				}
			}
			pnt = null;
			_content = null;
			/*var l:int = _content.ns::trk[0].ns::trkseg.ns::trkpt.length(), trk:XML, trackPoint:TrackPoint;
			for (var i:int = 0; i < l; i++) {
				trk = _content.ns::trk[0].ns::trkseg.ns::trkpt[i];
				trackPoint = new TrackPoint(trk.attribute("lat"), trk.attribute("lon"), trk.ns::ele, new TimeStamp(trk.ns::time));
				
				track.push(trackPoint);
			}*/
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function getTrack():Array {
			return this.track;
		}
		
		public function uploadGpxFile():void {
			
		}
		
	}
	
}