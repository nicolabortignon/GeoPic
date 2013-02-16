﻿package roekensk.display.objects.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class ButtonEvent extends Event 
	{
		public static var ON_RELEASE:String = "on release";
		public function ButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ButtonEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ButtonEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}