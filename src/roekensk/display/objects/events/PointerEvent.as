package roekensk.display.objects.events 
{
	import flash.events.Event;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class PointerEvent extends Event 
	{
		public static var MOVED:String = "moved";
		public static var CLICKED:String = "clicked";
		
		public function PointerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new PointerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PointerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}