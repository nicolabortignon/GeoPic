package roekensk.views 
{
	import com.flashdynamix.utils.SWFProfiler;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import roekensk.display.objects.Button;
	import roekensk.display.objects.events.ButtonEvent;
	import roekensk.display.plot.events.PlotContainerEvent;
	import roekensk.display.plot.InteractivePlotContainer;
	import roekensk.display.plot.Plot;
	import roekensk.display.table.Table;
	import roekensk.display.table.TableColumn;
	import roekensk.geo.display.PlotElevation;
	import roekensk.geo.display.PlotGroundElevation;
	import roekensk.geo.display.PlotSpeed;
	import roekensk.geo.google.events.TrackMapEvent;
	import roekensk.geo.google.TrackMap;
	import roekensk.geo.utils.TravelType;
	import roekensk.geo.webservices.ElevationService;
	import roekensk.geo.webservices.ElevationTrackService;
	import roekensk.geo.webservices.events.TrackServiceEvent;
	import roekensk.geo.webservices.GpxService;
	import roekensk.geo.webservices.TrackService;
	import roekensk.geo.webservices.XMLElevationServiceImplementation;
	import roekensk.utils.QueryString;
	import roekensk.utils.Tracking;
	import roekensk.views.events.ScreenEvent;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class MainScreen extends Sprite
	{
		public var QA:Boolean = true;
		
		private var elevation:InteractivePlotContainer;
		private var speed:InteractivePlotContainer;
		private var info:Table;
		private var dynamicInfo:Table;
		
		private var map:TrackMap;
		
		private var btnPlay:Button;
		private var btnEnlarge:Button;
		private var btnProfile:Button;
		
		private var trackService:TrackService;
		
		private var popUpWindows:Array = new Array();
		private var selection:Array;
		
		public function MainScreen() 
		{
			SWFProfiler.init(stage, this);
			init();
		}
		
		private function init():void {
			
			var file:String = "";
			trace(ExternalInterface.available);
			if (ExternalInterface.available) {
				var qs:QueryString = QueryString.getInstance();
				file = qs.getValue("track"); 
			}
			if (file =="") {
				file = "20100619.gpx";
			}
			var gpxService:GpxService = new GpxService(file);//"track.gpx");//"PG_edited.gpx");//"test.gpx");//"lopen20090118.gpx");//"20081214.gpx");//"ballon.gpx");//"20080926.gpx");//"20080920.gpx");//"20081214.gpx");//"20081012.gpx");//
			gpxService.addEventListener(Event.COMPLETE, onGpxLoaded);
		}
		
		private function onGpxLoaded(e:Event):void {
			var gpxService:GpxService = e.target as GpxService;
			removeEventListener(Event.COMPLETE, onGpxLoaded);
			var gpxTrack:Array = gpxService.getTrack();
			
			trackService = new TrackService(gpxTrack,TravelType.GROUND);
			//trackService.addEventListener(TrackServiceEvent.HEIGHT_AVAILABLE, onHeightAvailable);
			
			prepareComponents();
		}
		private function onHeightAvailable(e:TrackServiceEvent):void {
			trackService.removeEventListener(TrackServiceEvent.HEIGHT_AVAILABLE, onHeightAvailable);
			
			//var grndPlot:PlotGroundElevation = new PlotGroundElevation(trackService.getTrack(), 20, 20, trackService.getTrack();
		}
		private function prepareComponents():void {
			addEventListener(ScreenEvent.COMPONENTS_COMPLETE, onComponentsComplete);
			
			prepareMap();
			preparePlotContainers();
			prepareInformationTables();
			
			prepareButtons();
			
			dispatchEvent(new ScreenEvent(ScreenEvent.COMPONENTS_COMPLETE));
		}
		
		private function prepareButtons():void {
			btnEnlarge = new Button("Enlarge Selection", 100, 20);
			btnEnlarge.disable();
			
			btnProfile = new Button("Load Profile", 100, 20);
			btnProfile.addEventListener(ButtonEvent.ON_RELEASE, onBtnProfileRelease);
			btnProfile.disable();
		}
		private function prepareProfilePlot(t:Array):void {
			if (trackService.getTravelType() != TravelType.AIR) {
				elevation.redraw();
			} else { // AIR
				var profile:PlotGroundElevation = new PlotGroundElevation(t,elevation._p.yMax,elevation._p.yMin);
				//trace("ymax: " + profile.yMax + " ymin: " + profile.yMin);
				
				//redo->
				elevation.addPlot(profile);
			}
		}
		
		private function onBtnProfileRelease(e:ButtonEvent):void {
			//btnProfile.setText("Loading Profile...");
			btnProfile.disable();
			
			//var heightService:ElevationService = new XMLElevationServiceImplementation("PG_edited_h.xml", trackService.getTrack());//new ElevationTrackService(trackService.getTrack());
			var heightService:ElevationService = new ElevationTrackService(trackService.getTrack());
			heightService.addEventListener(Event.COMPLETE, onHeightServiceComplete);
		}
		private function onHeightServiceComplete(e:Event):void {
			var hServ:ElevationService = e.target as ElevationService;
			
			trackService.setGroundLevelAvailable(true);
			prepareProfilePlot(hServ.getTrack());
		}
		private function onBtnEnlargeRelease(e:ButtonEvent):void {
			var sel:Array = new Array();
			var t:Array = trackService.getTrack();
			
			for (var i:int = selection[0]; i < selection[1]; i++) {
				sel.push(t[i]);
			}
			
			var trackSelectionService:TrackService = new TrackService(sel,trackService.getTravelType());
			var popup:DetailScreen = new DetailScreen(trackSelectionService);
			popup.addEventListener(Event.CLOSE, onDetailScreenClosed);
			popup.x = 50;
			popup.y = 100;
			addChild(popup);
			
			track(e.target);
		}
		private function onDetailScreenClosed(e:Event):void {
			var popup:DetailScreen = e.target as DetailScreen;
			popup.removeEventListener(Event.CLOSE, onDetailScreenClosed);
			removeChild(popup);
		}
		private function prepareInformationTables():void {
			var titleCol:TableColumn = new TableColumn("_name");
			var valueCol:TableColumn = new TableColumn("_formattedValue");
			
			var cols:Array = new Array();
			cols.push(titleCol, valueCol);
			info = new Table(150,200,trackService.getDetails(null),cols);
			dynamicInfo = new Table(150, 300, trackService.getDetails(null),cols);
		}
		private function preparePlotContainers():void {
			var spdPlot:Plot = new PlotSpeed(trackService.getTrack());
			speed = new InteractivePlotContainer(660, 150, spdPlot);
			
			var ele:Plot = new PlotElevation(trackService.getTrack(), true);
			elevation = new InteractivePlotContainer(500, 200, ele);
		}
		private function prepareMap():void {
			map = new TrackMap();
			// scar: "ABQIAAAAUZob4Z3xY1adEWLD1eY09BQJRWwD01Ppi8JsFWHDcgIYF6woWBQxXbwc4VnE7UCIX2TyIC2wdfpN1Q";
			if (QA) {// krob: ABQIAAAAUZob4Z3xY1adEWLD1eY09BRYNTL4YQa4RfI8UA6TgTC3b_PJ8RTqo0lpzDdb8y98DZGzSkvXrN1BNQ
				map.key = "ABQIAAAAUZob4Z3xY1adEWLD1eY09BRYNTL4YQa4RfI8UA6TgTC3b_PJ8RTqo0lpzDdb8y98DZGzSkvXrN1BNQ";
			} else {
				map.key = "ABQIAAAAUZob4Z3xY1adEWLD1eY09BSHDbtwGDkzVAMEvLxWohm9As36zxQhpREhIw2a52tXiM9jN19ZdPSBhg";
			}
			map.setSize(new Point(500, 300));
			
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
		}
		private function onMapReady(e:MapEvent):void {
			map.removeEventListener(MapEvent.MAP_READY, onMapReady);
			map.createTrackOnMap(trackService.getTrack(), null);
			map.centerMapOnTrack(trackService.getTrack());
			
			map.addEventListener(TrackMapEvent.SELECTION_CHANGED, onMapSelectionChanged);
		}
		private function onComponentsComplete(e:ScreenEvent):void {
			removeEventListener(ScreenEvent.COMPONENTS_COMPLETE, onComponentsComplete);
			
			if(speed!=null) {
				addPlotContainerEventListeners(speed);
				speed.x = 0;
				speed.y = 310;
				addChild(speed);
			}
			
			if (elevation != null) {
				addPlotContainerEventListeners(elevation);
				elevation.y = 470;
				elevation.x = 160;
				addChild(elevation);
			}
			
			if (dynamicInfo != null) {
				dynamicInfo.y = 470;
				addChild(dynamicInfo);
			}
			if (info != null) {
				info.y = 0;
				info.x = 510;
				addChild(info);
			}
			
			if (map != null) {
				map.y = 0;
				map.x = 0;
				addChild(map);
			}
			
			if (btnEnlarge != null) {
				btnEnlarge.x = 510;
				btnEnlarge.y = 230;
				addChild(btnEnlarge);
			}
			if (btnProfile != null) {
				btnProfile.x = 510;
				btnProfile.y = 255;
				btnProfile.enable();
				addChild(btnProfile);
			}
			
		}
		private function addPlotContainerEventListeners(pc:InteractivePlotContainer):void {
			pc.addEventListener(PlotContainerEvent.PLOT_CLICKED, onPlotContainerSelectionChanged);
		}
		private function onMapSelectionChanged(e:TrackMapEvent):void {
			var m:TrackMap = e.target as TrackMap;
			updateComponents(new Array(m.activeId, m.activeId),m);
		}
		private function onPlotContainerSelectionChanged(e:PlotContainerEvent):void {
			var pc:InteractivePlotContainer = e.target as InteractivePlotContainer;

			updateComponents(pc.getSelection(),pc);
		}
		
		private function updateComponents(selection:Array, source:Object = null):void {
			synchComponents(selection, source);
		}
		
		private function synchComponents(selection:Array, source:Object):void {
			
			if ((selection[0] - selection[1]) != 0) {
				this.selection = selection;
				btnEnlarge.addEventListener(ButtonEvent.ON_RELEASE, onBtnEnlargeRelease);
				btnEnlarge.enable();
			} else {
				this.selection = null;
				btnEnlarge.disable();
				btnEnlarge.removeEventListener(ButtonEvent.ON_RELEASE, onBtnEnlargeRelease);
			}
			
			if (speed != null && speed != source) {
				speed.setSelection(selection);
			}
			if (elevation != null && elevation != source) {
				elevation.setSelection(selection);
			}
			if (map != null && map.ready && map != source) {
				map.setSelection(trackService.getTrack(), selection);
			}
			
			var information:Array = trackService.getDetails(selection);
			if (dynamicInfo != null) {
				dynamicInfo.setInf(information);
			}

		}
		
		private function track(o:Object):void {
			var trackString:String;
			switch (o) {
				case speed :
					trackString = "/clicks/plot/speed";
					break;
				case elevation :
					trackString = "/clicks/plot/elevation";
					break;
				case map :
					trackString = "/clicks/map";
					break;
				case btnEnlarge :
					trackString = "/clicks/btn/detailView";
					break;
			}
			
			if (ExternalInterface.available) {
				Tracking.googleAnalytics(trackString);
			}
		}
		
	}
	
}