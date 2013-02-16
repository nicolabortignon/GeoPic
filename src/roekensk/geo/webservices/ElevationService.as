package roekensk.geo.webservices 
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class ElevationService extends EventDispatcher
	{
		public var trk:Array;
		
		public var arr:Array;
		
		public function getHeight(id:Number):Number {
			return 0;
		}

		public function getTrack():Array {
			return arr;
		}
	}
	
}