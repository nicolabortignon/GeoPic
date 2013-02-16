package roekensk.display.objects.events 
{
	import flash.events.Event;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class OptionFieldEvent extends Event 
	{
		public static var OPTION_SELECTED:String = "selected";
		
		public function OptionFieldEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new OptionFieldEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("OptionFieldEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}