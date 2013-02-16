package roekensk.utils 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.*;
	
	import flash.external.ExternalInterface;
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Tracking 
	{
		
		public static function googleAnalytics(goal:String):void {
			//var l:URLLoader = new URLLoader();
			//l.load(new URLRequest("javascript:pageTracker._trackPageview('" + goal +"');"));
			//navigateToURL(new URLRequest("javascript:pageTracker._trackPageview('" + goal +"');"));
			
			ExternalInterface.call("pageTracker._trackPageview",goal);
		}
		
	}
	
}