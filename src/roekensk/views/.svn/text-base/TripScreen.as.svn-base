package roekensk.views 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import roekensk.display.objects.Button;
	import roekensk.display.objects.events.ButtonEvent;
	import roekensk.geo.objects.Track;
	import roekensk.geo.objects.TripDay;
	import roekensk.geo.webservices.GpxService;
	import roekensk.geo.webservices.TripXmlLoaderService;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class TripScreen extends Sprite
	{
		private var trip:Array;
		private var trkList:Sprite;
		
		public function TripScreen() 
		{
			var tripService:TripXmlLoaderService = new TripXmlLoaderService("ValThorens2009.xml");
			tripService.addEventListener(Event.COMPLETE, tripLoaded);
			
		}
		
		private function tripLoaded(e:Event):void {
			var serv:TripXmlLoaderService = e.target as TripXmlLoaderService;
			
			trip = serv.getTrip();

			createList();
		}
		
		private function createList():void {
			
			for (var i:int = 0; i < trip.length; i++) {
				var dayBtn:Button = new Button("day " + (1+i), 40, 20);
				dayBtn.x = (i * 45);
				dayBtn.id = i;
				dayBtn.addEventListener(ButtonEvent.ON_RELEASE, onDayBtnClicked);
				
				addChild(dayBtn);
			}
		}
		
		private function onDayBtnClicked(e:ButtonEvent):void {
			var btn:Button = e.target as Button;
			
			var d:TripDay = trip[btn.id] as TripDay;
			showTracks(d);
		}
		
		private function showTracks(day:TripDay):void {
			var trackService:GpxService;
			var l:int = day.getTracks().length;

			//trace(this.contains(trkList));
			if (trkList != null && this.contains(trkList)) {
				trace("remove list");
				this.removeChild(trkList);
			}
			trkList = new Sprite();
			for (var i:int = 0; i < l; i++) {
				
				/*var t:Track = day.getTrack(i) as Track;
				trackService = new GpxService(t.getPath());
				trackService.addE
				*/
				var trackBtn:Button = new Button("track " + (i+1), 70, 20);
				trackBtn._property = day.getTrack(i);
				
				trackBtn.y = 30 + i * 22;
				trackBtn.x = 10;
				
				trkList.addChild(trackBtn);
				
				trackBtn.addEventListener(ButtonEvent.ON_RELEASE, onTrackBtnClicked);
			}
			addChild(trkList);
		}
		
		private function onTrackBtnClicked(e:ButtonEvent):void {
			var btn:Button = e.target as Button;
			var trk:Track = btn._property as Track;
			trace("track: " + trk.getPath());
			
			var ts:TrackScreen = new TrackScreen(trk.getPath());
			ts.addEventListener(Event.COMPLETE, onTrackScreenLoaded);
			
			
		}
		
		private function onTrackScreenLoaded(e:Event):void {
			var ts:TrackScreen = e.target as TrackScreen;
			
			var popupScreen:Screen = new Screen(ts);
			popupScreen.addEventListener(Event.CLOSE, onPopupScreenClose);
			popupScreen.y = 25;
			popupScreen.x = 10;
			addChild(popupScreen);
		}
		
		private function onPopupScreenClose(e:Event):void {
			var popup:Screen = e.target as Screen;
			popup.removeEventListener(Event.CLOSE, onPopupScreenClose);
			removeChild(popup);
		}
		
	}
	
}