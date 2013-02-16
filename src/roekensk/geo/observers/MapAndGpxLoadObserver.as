package roekensk.geo.observers 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class MapAndGpxLoadObserver extends EventDispatcher
	{
		private var mapLoaded:Boolean = false;
		private var gpxLoaded:Boolean = false;
		
		public function MapAndGpxLoadObserver() 
		{
			
		}
		
		public function setMapLoaded(b:Boolean):void {
			mapLoaded = b;
			dispatchEvent(new Event(Event.CHANGE));
			checkBoth();
		}
		
		public function setGpxLoaded(b:Boolean):void {
			gpxLoaded = b;
			dispatchEvent(new Event(Event.CHANGE));
			checkBoth();
		}
		
		private function checkBoth():void {
			if (gpxLoaded && mapLoaded) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
	}
	
}