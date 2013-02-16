package roekensk.display.plot.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class PlotEvent extends Event 
	{
		public static var ON_SELECTED:String = "on selected";
		public static var ON_RELEASE:String = "on release";
		public function PlotEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new PlotEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PlotEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}