package tests 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import roekensk.geo.events.PlotClickedEvent;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class EventTester extends Sprite
	{
		
		public function EventTester() 
		{
			var evt:PlotClickedEvent = new PlotClickedEvent(PlotClickedEvent.ON_READY);
			var disp:EventDispatcher = new EventDispatcher();
			
			this.addEventListener(PlotClickedEvent.ON_READY, plotClicked);
			
			dispatchEvent(evt);
		}
		
		public function plotClicked(e:Event):void {
			trace("jeeej");
		}
	}
	
}