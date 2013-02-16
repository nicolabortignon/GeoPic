package roekensk.display.plot.events 
{
	import flash.events.Event;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class PlotContainerEvent extends Event 
	{
		public static var POINTER_MOVED:String = "pointer moved";
		public static var PLOT_CLICKED:String = "plot clicked";
		public static var PLOT_DRAGGING:String = "plot dragging";
		public static var PLOT_STOP_DRAG:String = "plot stop drag";
		public static var POINTER_DRAGGING:String = "pointer dragging";
		public static var POINTER_STOP_DRAG:String = "pointer stop drag";
		public static var POINTER_ACTIVE_ID_CHANGED:String = "changed active id";
		public static var POINTER_SELECTION_CHANGED:String = "selection changed";

		
		
		public function PlotContainerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new PlotContainerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PlotContainerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}