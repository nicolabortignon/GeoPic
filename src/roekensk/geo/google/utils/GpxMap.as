package roekensk.geo.google.utils 
{
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapType;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.Polyline;
	import com.google.maps.overlays.PolylineOptions;
	import roekensk.geo.google.events.TrackMapEvent;
	import roekensk.geo.objects.TrackPoint;
	import roekensk.geo.utils.GeoCalculation;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class GpxMap extends Map
	{
		public var overlays:Array = new Array();
		public var track:Array;
		
		private var trackMarker:Marker;
		
		public var activeId:Number = 0;
		public var ready:Boolean = false;
		
		public function GpxMap() 
		{
			
		}
		
		public function clearMap():void {
			for (var a:Number = 0; a < overlays.length; a++) {
				removeOverlay(overlays[a]);
			}
		}
		
		public function createTrackOnMap(track:Array, selection:Array, col:Number=0xFF0000):void {
			this.track = track;
						
			var tempArr:Array = new Array();
			overlays = new Array();
			var line:Polyline;
			if (selection == null || (selection[0] - selection[1] == 0)) {
				var l:int = track.length;
				for (var i:int = 0; i < l; i++) {
					tempArr.push(GMapsUtils.convertTrackPointToLatLng(track[i] as TrackPoint));
					
				}
				line = new Polyline(tempArr, new PolylineOptions({strokeStyle: { thickness: 5, color: col, alpha: 0.5, pixelHinting: true } }));
				
				//line = new Polyline(tempArr);
				overlays.push(line);
			}
			
			

			var lenght:int = overlays.length;
			for (var m:int = 0; m < lenght; m++) {
				
				overlays[m].addEventListener(MapMouseEvent.MOUSE_UP, onMapTrackClicked);
				
				addOverlay(overlays[m]);
			}
			
			//putPointersOnMap();
		}
		
		public function centerMapOnTrack(track:Array):void {
			var begin:TrackPoint = track[0];
			var verste:TrackPoint = GeoCalculation.findFurthestPointFrom(track, track[0]);//track[track.length-1];
			var c:LatLng = new LatLng((begin.lat + verste.lat)/2,(begin.lon+verste.lon)/2);
			setCenter(c, 14, MapType.PHYSICAL_MAP_TYPE);
		}
		
		public function setSelection(track:Array, selection:Array):void {
			//if ((selection[0] - selection[1]) != 0) {
				createTrackOnMap(track, selection);
				//moveMarker(activeId = selection[0]);
			/*} else {
				
			}*/
		}
		
		public function onMapTrackClicked(e:MapMouseEvent):void {
			/*var tp:TrackPoint = GMapsUtils.convertLatLngToTrackPoint(e.latLng);
			var id:Number = GeoCalculation.findNearestId(track, tp);
			setSelection(track,new Array(id,id));
			
			dispatchEvent(new TrackMapEvent(TrackMapEvent.SELECTION_CHANGED));*/
		}
	
	}
	
}