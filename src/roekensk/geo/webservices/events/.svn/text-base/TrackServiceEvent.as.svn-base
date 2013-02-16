package roekensk.geo.webservices.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class TrackServiceEvent extends Event 
	{
		public static var HEIGHT_AVAILABLE:String = "HEIGHT_AVAILABLE";
		public function TrackServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new TrackServiceEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TrackServiceEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}