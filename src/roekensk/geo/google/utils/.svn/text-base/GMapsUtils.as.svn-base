package roekensk.geo.google.utils
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Polyline;
	import com.google.maps.overlays.PolylineOptions;
	import roekensk.geo.objects.TrackPoint;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class GMapsUtils 
	{
		
		public static function convertTrackPointToLatLng(tp:TrackPoint):LatLng {
			return new LatLng(tp.lat, tp.lon);
		}
		public static function convertLatLngToTrackPoint(ll:LatLng):TrackPoint {
			return new TrackPoint(""+ll.lat(), ""+ll.lng(), "0", null);
		}
		public static function createPolyLine(tp1:TrackPoint, tp2:TrackPoint):Polyline {
			return new Polyline([convertTrackPointToLatLng(tp1),
								convertTrackPointToLatLng(tp2)]);
		}
		
	}
	
}