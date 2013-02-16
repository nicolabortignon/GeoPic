package roekensk.display.objects.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class SelectionEvent extends Event 
	{
		public static var ON_SELECTED:String = "on selected";
		public function SelectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new SelectionEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SelectionEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}