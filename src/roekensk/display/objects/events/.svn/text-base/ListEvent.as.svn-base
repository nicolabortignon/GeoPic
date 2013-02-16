package roekensk.display.objects.events 
{
	import flash.events.Event;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class ListEvent extends Event 
	{
		public static var ITEM_SELECTED:String = "item selected";
		public function ListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ListEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ListEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}