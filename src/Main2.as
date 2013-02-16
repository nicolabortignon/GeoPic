package 
{
	
	
	import com.google.maps.controls.MapTypeControl;
	import com.google.maps.controls.PositionControl;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapType;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.Polyline;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Transform;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;
	import roekensk.display.objects.Button;
	import roekensk.display.objects.events.ButtonEvent;
	import roekensk.display.objects.events.PointerEvent;
	import roekensk.display.objects.Selection;
	import roekensk.display.plot.events.PlotContainerEvent;
	import roekensk.display.plot.InteractivePlotContainer;
	import roekensk.display.objects.Information;
	import roekensk.display.objects.Pointer;
	import roekensk.display.plot.PlotContainer;
	import roekensk.display.PopUpScreen;
	import roekensk.display.table.Table;
	import roekensk.display.table.TableColumn;
	import roekensk.geo.display.PlotDistFromPoint;
	import roekensk.geo.display.PlotElevation;
	import roekensk.geo.display.PlotGroundElevation;
	import roekensk.geo.display.PlotSpeed;
	import roekensk.display.plot.events.PlotClickedEvent;
	import roekensk.geo.google.TrackMap;
	import roekensk.geo.google.utils.GMapsUtils;
	import roekensk.geo.objects.TimeStamp;
	import roekensk.geo.objects.TrackPoint;
	import roekensk.geo.observers.MapAndGpxLoadObserver;
	import roekensk.geo.utils.GeoCalculation;
	import roekensk.geo.webservices.ElevationPointService;
	import roekensk.geo.webservices.ElevationService;
	import roekensk.geo.webservices.ElevationTrackService;
	import roekensk.geo.webservices.GpxService;
	import roekensk.geo.webservices.TrackService;
	import roekensk.geo.webservices.XMLElevationServiceImplementation;
	import roekensk.utils.StringUtils;
	import roekensk.utils.Tracking;
	import roekensk.views.DetailScreen;
	import roekensk.views.Screen;
	
	import flash.external.ExternalInterface;
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Main extends Sprite
	{
		public var xmlLoader:URLLoader = new URLLoader();
		public var es:ElevationService;//new ElevationPointService();
		public var gpxServ:GpxService;
		
		public var elePlot:PlotElevation;
		public var spdPlot:PlotSpeed;
		
		public var track:Array = new Array();
		public var trackMarker:Marker;
		public var activeId:Number = 0;
		public var selectedIds:Array;
		//public var selection:Array;
		
		public var plot:PlotElevation;
		public var elePlotContainer:InteractivePlotContainer;
		public var speedPlotContainer:InteractivePlotContainer;
		
		public var plotContainers:Array = new Array();
		
		public var map:TrackMap;
		public var infoTable:Table;
		public var specificInfoTalbe:Table;
		
		public var gpxLoaded:Boolean = false;
		public var mapReady:Boolean = false;
		
		public var online:Boolean = false;
		public var gpxFile:String = "map";//"big";//"PG_edited";//"20081012";//"20080926";//"ballon"//"20080920"; // 
		public var QA:Boolean = true;
		public var browser:Boolean = false;
		public var loadHeight:Boolean = false;
		
		public var observer:MapAndGpxLoadObserver = new MapAndGpxLoadObserver();
		
		public var txtDebug:TextField = new TextField();
		public var version:String = "BaggioCrux 0.0.1";
		
		public var btnToPNG:Button;
		public var btnPlay:Button;
		public var btnEnlarge:Button;
		
		public var player:Timer;
		public var playing:Boolean = false;
		
		public function Main() 
		{
			txtDebug.text = "version: " + version;
			txtDebug.y = 300;
			txtDebug.width = 400;
			addChild(txtDebug);
			
			map = new TrackMap();
			
			observer.addEventListener(Event.COMPLETE, onMapAndGpxLoaded);
			
			gpxServ = new GpxService(gpxFile +".gpx");
			gpxServ.addEventListener(Event.COMPLETE, onGpxLoaded);
			gpxServ.load();
			
			placeButtons();
			// scar: "ABQIAAAAUZob4Z3xY1adEWLD1eY09BQJRWwD01Ppi8JsFWHDcgIYF6woWBQxXbwc4VnE7UCIX2TyIC2wdfpN1Q";
			if (QA) {// krob: ABQIAAAAUZob4Z3xY1adEWLD1eY09BRYNTL4YQa4RfI8UA6TgTC3b_PJ8RTqo0lpzDdb8y98DZGzSkvXrN1BNQ
				map.key = "ABQIAAAAUZob4Z3xY1adEWLD1eY09BRYNTL4YQa4RfI8UA6TgTC3b_PJ8RTqo0lpzDdb8y98DZGzSkvXrN1BNQ";
			} else {
				map.key = "ABQIAAAAUZob4Z3xY1adEWLD1eY09BSHDbtwGDkzVAMEvLxWohm9As36zxQhpREhIw2a52tXiM9jN19ZdPSBhg";
			}
			map.url = "http://localhost";
			
			
			map.setSize(new Point(500, 300));
			
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.addEventListener(MapMouseEvent.MOUSE_UP, onMapTrackClicked);
			
			addChild(map);
		}
		
		public function placeButtons():void {
			btnToPNG = new Button("export PNG", 100, 20);
			btnToPNG.addEventListener(ButtonEvent.ON_RELEASE, onReleasePngButton);
			btnToPNG.x = 400;
			btnToPNG.y = 350;
			btnToPNG.disable();
			addChild(btnToPNG);
			
			btnPlay = new Button("Play", 100, 20);
			btnPlay.addEventListener(ButtonEvent.ON_RELEASE, onReleaseBtnPlay);
			btnPlay.x = 200;
			btnPlay.y = 350;
			btnPlay.disable();
			addChild(btnPlay);
			
			btnEnlarge = new Button("Enlarge Selection", 100, 20);
			btnEnlarge.addEventListener(ButtonEvent.ON_RELEASE, onReleaseBtnEnlarge);
			btnEnlarge.x = 300;
			btnEnlarge.y = 350;
			btnEnlarge.disable();
			addChild(btnEnlarge);
		}
		
		public function onReleaseBtnEnlarge(e:ButtonEvent):void {
			var trkSel:Array = new Array();
			var hgtSel:Array = null;
			if (es != null) {
				hgtSel = new Array();
			}
			for (var i:Number = selectedIds[0]; i < selectedIds[1]; i++) {
				trkSel.push(track[i]);
				if(es!=null) {
					hgtSel.push(es.trk[i]);
				}
			}
			var detailScreen:DetailScreen = new DetailScreen(new TrackService(trkSel),hgtSel);
			var popup:Screen = new Screen(detailScreen, "Selection");
			popup.addEventListener(Event.CLOSE,closePopUp);
			popup.x = 100;
			popup.y = 200;
			addChild(popup);
		}
		
		private function closePopUp(e:Event):void {
			e.target.removeEventListener(Event.CLOSE, closePopUp);
			removeChild(e.target as DisplayObject);
		}
		
		public function onReleaseBtnPlay(e:ButtonEvent):void {
			if (playing) {
				stopPlay();
			} else {
				startPlay();
			}
		}
		
		public function stopPlay():void {
			btnPlay.setText("Play");
			player.stop();
			playing = false;
		}
		
		public function startPlay():void {
			var rep:Number = track.length - (activeId);
			if(rep > 0) {
				playing = true;
				btnPlay.setText("Pause");
				
				player = new Timer(50, track.length-(activeId));
				player.addEventListener(TimerEvent.TIMER, playerHandler);
				player.addEventListener(TimerEvent.TIMER_COMPLETE, playerCompleteEvent);
				
				player.start();
			}
		}
		
		private function playerHandler(e:TimerEvent):void {
			var t:Timer = e.target as Timer;
			var realtime:Boolean = false;
			
			getDetails(activeId);
			
			for (var i:Number = 0; i < plotContainers.length; i++) {
				var pc:PlotContainer = plotContainers[i];
				pc.movePointer(activeId, pc.plots[0].calcCoords(activeId));
			}
			
			
			if (activeId + 1 < track.length && realtime) {
				var d:Number = GeoCalculation.calcTimeBetween(activeId, activeId + 1, track)*1000;
				
				trace(d);
				t.delay = d/40;
				
			}
			activeId++;
			//t.repeatCount = track.length - (activeId+1);
		}
		
		public function playerCompleteEvent(e:TimerEvent):void {
			stopPlay();
			e.target.stop();
			
		}
		
		public function onReleasePngButton(e:ButtonEvent):void {
			trace("export png");
		}
		
		public function onMapAndGpxLoaded(e:Event):void {
			showTrackOnMap();
		}
		
		public function onMapReady(e:MapEvent):void {
			map.addControl(new ZoomControl());
			map.addControl(new PositionControl());
			map.removeMapType(MapType.HYBRID_MAP_TYPE);
			map.addControl(new MapTypeControl());
			
			map.enableScrollWheelZoom();
			
			observer.setMapLoaded(true);
		}
		
		public function onMapTrackClicked(e:MapMouseEvent):void {
			getDetails(e.target.activeId);
			if (browser) Tracking.googleAnalytics("/clicks/map");
		}
		
		public function onGpxLoaded(e:Event):void {
			this.track = gpxServ.getTrack();
			
			observer.setGpxLoaded(true);
			
			if(loadHeight) {
				es = new XMLElevationServiceImplementation(gpxFile + "_h.xml",track);//new ElevationTrackService(track);
				es.addEventListener(Event.COMPLETE, onElevationServiceComplete);
			} else {
				plotThis();
			}
			
			btnPlay.enable();
			startCalculations();
		}
		
		public function showTrackOnMap():void {
			
			var begin:TrackPoint = track[0];
			var verste:TrackPoint = GeoCalculation.findFurthestPointFrom(track, track[0]);//track[track.length-1];
			var c:LatLng = new LatLng((begin.lat + verste.lat)/2,(begin.lon+verste.lon)/2);
			map.setCenter(c, 14, MapType.PHYSICAL_MAP_TYPE);
			
			map.createTrackOnMap(track,null);
			
		}
		
		public function onElevationServiceComplete(e:Event):void {
			plotThis();
		}
		
		public function startCalculations():void {
			var totalDistance:Number = GeoCalculation.calcTotalDistance(track);
			
			var avSpd:Information = new Information("average speed", GeoCalculation.calcAverageSpeed(track),"km/h");
			var dist:Information = new Information("distance", totalDistance,"km");
			var time:Information = new Information("overall time", (GeoCalculation.calcOverallTime(track) / 60),"min");
			var avGr:Information = new Information("average glide ratio", GeoCalculation.calcAverageGlideRatio(track));
			var meGr:Information = new Information("median glide ratio", GeoCalculation.findMedianGlideRatio(track));
			var hiGr:Information = new Information("max glide ratio", GeoCalculation.findMaxGlideRatio(track));
			var maxSpd:Information = new Information("max speed", GeoCalculation.findMaxSpeed(track),"km/h");
			
			
			
			var h:Number = GeoCalculation.findMaxElevation(track);
			var l:Number = GeoCalculation.findLowestElevation(track);
			
			var highest:Information = new Information("highest point", h,"m");
			var lowest:Information = new Information("lowest point", l,"m");
			var dEle:Information = new Information("height difference", h - l,"m");
			
			var titleCol:TableColumn = new TableColumn("_name");
			var valueCol:TableColumn = new TableColumn("_formattedValue");
			
			var cols:Array = new Array();
			cols.push(titleCol,valueCol);
			
			var inf:Array = new Array();
			//inf.push(avSpd, dist, time, avGr, highest, lowest, dEle, meGr, hiGr, maxSpd);
			inf.push(dist, time, dEle, highest, lowest, meGr, avGr, avSpd, hiGr, maxSpd);
			
			infoTable = new Table(150, 200, inf, cols);
			infoTable.x = 510;
			addChild(infoTable);
			
			specificInfoTalbe = new Table(150, 160, inf, cols);
			specificInfoTalbe.x = 510;
			specificInfoTalbe.y = 210;
			addChild(specificInfoTalbe);
		}
		
		public function plotThis():void {
			//var disPlot:PlotDistFromPoint = new PlotDistFromPoint(track, track[0], 700,50);
			elePlot = new PlotElevation(track, true, 2);// 50);
			
			spdPlot = new PlotSpeed(track);
			
			//var elePlotContainer:PlotContainer = new PlotContainer(650,150,elePlot);
			elePlotContainer = new InteractivePlotContainer(660, 275, elePlot);// , 7);
			
			if(es!=null) {
				var profile:PlotGroundElevation = new PlotGroundElevation(es.trk,elePlot.yMax,elePlot.yMin);
				profile.yMin = elePlot.yMin;
				elePlotContainer.addPlot(profile);
			}
			
			elePlotContainer.x = 0;
			elePlotContainer.y = 380;
			addChild(elePlotContainer);
			
			speedPlotContainer = new InteractivePlotContainer(660, 100, spdPlot);//, 3);//660, 200, spdPlot);
			speedPlotContainer.y = 680;
			//speedPlotContainer.y = 600;
			addChild(speedPlotContainer);
			
			plotContainers.push(elePlotContainer, speedPlotContainer);
			
			// SYNCHRONIZE
			for (var i:Number = 0; i < plotContainers.length; i++) {
				var pc:PlotContainer = plotContainers[i];
				pc.addEventListener(PlotContainerEvent.POINTER_DRAGGING, onPlotPointerStartDrag);
				pc.addEventListener(PlotContainerEvent.POINTER_STOP_DRAG, onPlotPointerStopDrag);
				pc.addEventListener(PlotContainerEvent.PLOT_CLICKED, onPlotContainerClick);
				pc.addEventListener(PlotContainerEvent.POINTER_SELECTION_CHANGED, onPlotContainerSelectionChanged);
			}
			
		}
		
		public function onPlotContainerSelectionChanged(e:PlotContainerEvent):void {
			for (var i:Number = 0; i < plotContainers.length; i++) {
				
			}
		}
		
		public function onPlotPointerStartDrag(e:PlotContainerEvent):void {
			synchPointer(e);
			var id:Number = e.target.clickedId;
			getDetails(id);
		}
		public function onPlotPointerStopDrag(e:PlotContainerEvent):void {
			if (browser) Tracking.googleAnalytics("/clicks/plot/" + e.target.plots[0]._name);
			
			synchPointer(e);
		}
		
		public function synchPointer(e:PlotContainerEvent):void {
			var id:Number = e.target.getActiveId();
			
			for (var i:Number = 0; i < plotContainers.length; i++)
			{
				var pc:PlotContainer = plotContainers[i];
				if (pc != e.target as PlotContainer) {
					pc.setActiveId(id);
					pc.movePointer(id, pc.plots[0].calcCoords(id));
				}
				
			}
		}
		
		public function putPointersOnMap():void {
			var m:Marker = new Marker(GMapsUtils.convertTrackPointToLatLng(track[0] as TrackPoint));
			m.shadow.visible = false;
			
			map.addOverlay(m);
			
			var e:Marker = new Marker(GMapsUtils.convertTrackPointToLatLng(track[track.length-1] as TrackPoint));
			e.shadow.visible = false;
			
			map.addOverlay(e);
		}
		
		public function onPlotContainerClick(e:PlotContainerEvent):void {
			if(browser)Tracking.googleAnalytics("/clicks/plot/"+e.target.plots[0]._name);
			
			var id:Number = e.target.getActiveId();
			selectedIds = e.target.getSelection();
			
			if (selectedIds != null && (selectedIds[0] - selectedIds[1]) != 0) {
				getSelectionDetails(selectedIds[0], selectedIds[1]);
			} else {
				for (var i:Number = 0; i < plotContainers.length; i++)
				{
					var pc:PlotContainer = plotContainers[i];
					pc.setActiveId(id);
				}
				getDetails(id);
			}
			synchPointer(e);
		}
		
		public function getSelectionDetails(id1:Number, id2:Number):void {
			btnEnlarge.enable();
			var selection:Array = new Array();
			
			for (var i:Number = id1; i < id2; i++) {
				selection.push(track[i]);
			}
			
			showSelectionDetails(selection);
		}
		
		public function getDetails(id:Number):void {
			btnEnlarge.disable();
			if(id <= track.length) {
				activeId = id;
				//if(online) {
				if(track[id].grnd == 0) {
					//es.addEventListener(Event.COMPLETE, onGetDetailsComplete);
					if(es!=null) {
						track[id].grnd = es.getHeight(id); //track[id]);
					}
				}
				showDetails(id);
			}
		}
		
		public function showSelectionDetails(sel:Array):void {
			var totalDistance:Number = GeoCalculation.calcTotalDistance(sel);
			
			var avSpd:Information = new Information("average speed", GeoCalculation.calcAverageSpeed(sel),"km/h");
			var dist:Information = new Information("distance", totalDistance,"km");
			var time:Information = new Information("overall time", (GeoCalculation.calcOverallTime(sel) / 60),"min");
			var avGr:Information = new Information("average glide ratio", GeoCalculation.calcAverageGlideRatio(sel));
			var meGr:Information = new Information("median glide ratio", GeoCalculation.findMedianGlideRatio(sel));
			var hiGr:Information = new Information("max glide ratio", GeoCalculation.findMaxGlideRatio(sel));
			var maxSpd:Information = new Information("max speed", GeoCalculation.findMaxSpeed(sel),"km/h");
			
			
			
			var h:Number = GeoCalculation.findMaxElevation(sel);
			var l:Number = GeoCalculation.findLowestElevation(sel);
			
			var highest:Information = new Information("highest point", h,"m");
			var lowest:Information = new Information("lowest point", l,"m");
			var dEle:Information = new Information("height difference", h - l,"m");
			
			var titleCol:TableColumn = new TableColumn("_name");
			var valueCol:TableColumn = new TableColumn("_formattedValue");
			
			var cols:Array = new Array();
			cols.push(titleCol,valueCol);
			
			var inf:Array = new Array();
			//inf.push(avSpd, dist, time, avGr, highest, lowest, dEle, meGr, hiGr, maxSpd);
			inf.push(dist, time, dEle,/* highest, lowest,*/ meGr, avGr, avSpd, hiGr, maxSpd);
			
			specificInfoTalbe.setInf(inf);
			trace("selIds: " + selectedIds[0] + " & " + selectedIds[1]);
			if (online) {
				map.createTrackOnMap(track, selectedIds);
			}
		}
		
		public function showDetails(id:Number):void {
			//track[id].grnd = e.currentTarget.temp.height;
			
			var other:Number = 1;
			if(id >= track.length-1) { other = 0 }
			/*trace("======="+ id+"/"+track.length +"=======");
			trace("elevation: " + track[id].ele);// + " (" + (track[id].ele - heightTrack[id].ele) +")");
			trace("dist travelled: " + GeoCalculation.calcDistanceBetween(0, id, track));
			trace("dist straight: " + GeoCalculation.calcDistance(track[0], track[id]));
			trace("speed: " + GeoCalculation.calcSpeed(track[id], track[id + other]));
			trace("glide ratio: " + GeoCalculation.calcGlideRatio(track[id], track[id + other]));
			
			trace("time travelled: " + GeoCalculation.calcTimeBetween(0,id,track)/60);
			*/
			
			var elev:Information = new Information("Above Sea",track[id].ele,"m");
			var travDist:Information = new Information("Straight Distance",GeoCalculation.calcDistance(track[0], track[id]),"km");
			var straightDist:Information = new Information("Travelled Distance",GeoCalculation.calcDistanceBetween(0, id, track),"km");
			var speed:Information = new Information("Speed",GeoCalculation.calcSpeed(track[id], track[id + other]),"km/h");
			var gr:Information = new Information("Glide Ratio",GeoCalculation.calcGlideRatio(track[id], track[id + other]));
			var time:Information = new Information("Time",GeoCalculation.calcTimeBetween(0,id,track)/60,"min");
			var height:Information = new Information("Above Ground", (track[id].ele - track[id].grnd),"m");
			var vario:Information = new Information("Vario",GeoCalculation.calcVario(id,track),"m/s");
			
			var inf:Array = new Array();
			
			
			//map.setCenter(GMapsUtils.convertTrackPointToLatLng(track[id]));
			
			
			
			//elePlot.movePointer(id);
			
			
			if (online) {
				//trace("height: " + (track[id].ele - track[id].grnd));// + heightTrack[id].ele);
				//var height:Information = new Information("Height", (track[id].ele - track[id].grnd));
				//inf.push(height);
				map.setCenter(GMapsUtils.convertTrackPointToLatLng(track[id]));
				if (null == trackMarker) {
					trackMarker = new Marker(GMapsUtils.convertTrackPointToLatLng(track[id]));
					trackMarker.shadow.visible = false;
					map.addOverlay(trackMarker);
				} else {
					trackMarker.setLatLng(GMapsUtils.convertTrackPointToLatLng(track[id]));
				}
			}
			inf.push(elev, travDist, straightDist, speed, gr, time, height,vario);
			
			specificInfoTalbe.setInf(inf);
		}
	}
}

*/
