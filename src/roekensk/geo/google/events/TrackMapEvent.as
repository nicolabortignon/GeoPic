package roekensk.geo.google.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class TrackMapEvent extends Event 
	{
		public static var SELECTION_CHANGED:String = "SELECTION_CHANGED";
		public function TrackMapEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new TrackMapEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TrackMapEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}