package roekensk.geo.webservices 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import roekensk.geo.objects.TrackPoint;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class XMLElevationServiceImplementation extends ElevationService
	{
		
		
		public function XMLElevationServiceImplementation(path:String,track:Array) 
		{
			arr = track;
			var xmlLoader:URLLoader = new URLLoader();
			
			xmlLoader.addEventListener(Event.COMPLETE, onLoad);
			xmlLoader.load(new URLRequest(path));
		}
		
		override public function getHeight(id:Number):Number {
			return trk[id];
		}
		
		public function onLoad(e:Event):void {
			
			var _content:XML = new XML(e.target.data);
			
			//trace(_content.hgt[0]);
			trk = new Array();
			var l:int = _content.hgt.length();
			for (var i:int = 0; i < l; i++) {
				trk.push(_content.hgt[i]);
				arr[i].grnd = _content.hgt[i];
				//var pt:XML = _content.trk[0].trkseg.trkpt[i];
				/*var tp:TrackPoint = arr[i] as TrackPoint;
				tp.grnd = trk[i];//_content.hgt[i];
				arr[i] = tp;*/
				//var trackPoint:TrackPoint = new TrackPoint(trk.attribute("lat"), trk.attribute("lon"), trk.ele, new TimeStamp(trk.time));
				
				//track.push(trackPoint);
			}

			dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}
	
}