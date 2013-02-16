package roekensk.display.plot.events  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class PlotClickedEvent extends Event 
	{
		public static const ON_READY:String = "ready";
		
		public function PlotClickedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new PlotClickedEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PlotClickedEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}