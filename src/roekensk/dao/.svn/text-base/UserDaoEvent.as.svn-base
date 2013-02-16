package roekensk.dao 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class UserDaoEvent extends Event 
	{
		public static var LOGIN_SUCCESS:String = "LOGIN_SUCCESS";
		public static var LOGIN_FAILED:String = "LOGIN_FAILED";
		public static var REGISTER_SUCCESS:String = "REGISTER_SUCCESS";
		public static var REGISTER_FAILED:String = "REGISTER_FAILED";
		
		public function UserDaoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new UserDaoEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("UserDaoEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}