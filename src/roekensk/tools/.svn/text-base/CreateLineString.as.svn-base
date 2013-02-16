package roekensk.tools 
{
	import com.google.maps.LatLng;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import mx.utils.StringUtil;
	import roekensk.geo.objects.TrackPoint;
	import roekensk.geo.utils.GeoCalculation;
	import roekensk.geo.webservices.GpxService;
	import roekensk.geo.webservices.TrackService;
	import roekensk.utils.Math2;
	
	/*
	 * 
	<gx:FlyTo>
          <gx:duration>$dur</gx:duration>
          <Camera>
            <longitude>$long</longitude>
            <latitude>$lat</latitude>
            <altitude>$alt</altitude>
            <heading>$heading</heading>
            <tilt>$tilt</tilt>
            <roll>0</roll>
          </Camera>
        </gx:FlyTo>
	 * 
	 */
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	* http://code.google.com/apis/kml/documentation/kmlreference.html#linestring
	*/
	public class CreateLineString extends Sprite
	{
		private var txtLineString:TextField;
		private var lineString:String = "";
		private static var kmlTemplate:String = "<?xml version =\"1.0\" encoding =\"UTF-8\"?>\n <kml xmlns =\"http://www.opengis.net/kml/2.2\" xmlns:gx =\"http://www.google.com/kml/ext/2.2\" xmlns:kml =\"http://www.opengis.net/kml/2.2\" xmlns:atom =\"http://www.w3.org/2005/Atom\">\n <Document>\n <name> Test </name>\n\t<open>1</open>\n $place \n\t<gx:Tour>\n\t\t <name> LineString Tour </name>\n\t\t <gx:Playlist>\n\n$tour\n\n</gx:Playlist>\n</gx:Tour>\n</Document>\n</kml>";
		
		
		private static var flyToXmlTag:String = "<gx:FlyTo>\n<gx:duration>$dur</gx:duration>\n<gx:flyToMode>smooth</gx:flyToMode>\n<Camera>\n<longitude>$lon</longitude>\n<latitude>$lat</latitude>\n<altitude>$alt</altitude>\n<heading>$heading</heading>\n<tilt>$tilt</tilt>\n<roll>0</roll>\n<altitudeMode>$altiMode</altitudeMode>\n</Camera>\n</gx:FlyTo>\n";
		//private var flyToXmlTag:String = "";
		
		
		private var track:Array;
		
		public function CreateLineString(f:String = "track.gpx") 
		{
			//flyToXmlTag = "<gx:FlyTo><gx:duration>$dur</gx:duration><Camera><longitude>$lon</longitude><latitude>$lat</latitude><altitude>$alt</altitude>"/*<heading>$heading</heading>*/+"<tilt>$tilt</tilt><roll>0</roll></Camera></gx:FlyTo>";
			
			var service:GpxService = new GpxService(f);//"valthorens/20090206/20090206_skien4.gpx");
			service.load();
			service.addEventListener(Event.COMPLETE, onGpxLoaded);
			
			txtLineString = new TextField();
			txtLineString.width = 500;
			txtLineString.height = 600;
			txtLineString.border = true;
			txtLineString.multiline = true;
			addChild(txtLineString);
			
		}
		
		private function onGpxLoaded(e:Event):void {
			var service:GpxService = e.target as GpxService;
			track = service.getTrack();
			
			//createLineString(track);
			txtLineString.text = createTourXml(track);
			//trace(txtLineString.text);
		}
		/*
		  
		
        <gx:FlyTo>
          <gx:duration>4.1</gx:duration>
          <Camera>
            <longitude>170.157</longitude>
            <latitude>-43.671</latitude>
            <altitude>9700</altitude>
            <heading>-6.333</heading>
            <tilt>33.5</tilt>
            <roll>0</roll>
          </Camera>
        </gx:FlyTo>
		
		 
		*/
		private function createTourXml(track:Array):String {
			var p1:TrackPoint,p2:TrackPoint,p0:TrackPoint, duration:Number, long:Number, lat:Number, altitude:Number, heading:Number, tilt:Number;
			var l:int = (track.length - 1);
			
			
			var xml:String = "";
			
			var completeXml:String ="";
			
			var avgHead:Number = 0;
			
			for (var i:int = 1; i < l; i++) {
				if(i==1) {	
					p1 = track[i-1] as TrackPoint;
					p2 = track[i] as TrackPoint;
				} else {
					p1 = p2;
					p2 = track[i] as TrackPoint;
				}
				duration = (p2.timeStamp.totalSeconds - p1.timeStamp.totalSeconds);
				//trace("dur :"+duration);
				long = p1.lon;
				lat = p1.lat;
				altitude = p1.ele;
				heading = (GeoCalculation.calculateBearing(p1, p2));
				tilt = 90+(Math2.radToDeg(GeoCalculation.calculateTilting(p1, p2)));
// "<gx:FlyTo>\n<gx:duration>$dur</gx:duration>\n<Camera>\n<longitude>$lon<\longitude>\n<latitude>$lat</latitude>\n<altitude>$alt</altitude>\n<heading>$heading</heading>\n<tilt>$tilt</tilt>\n<roll>0</roll>\n</Camera>\n<\gx:FlyTo>";
				xml = flyToXmlTag.replace("$dur", duration/10);
				xml = xml.replace("$lon",long);
				xml = xml.replace("$lat",lat);
				xml = xml.replace("$alt", 3);// altitude);
				xml = xml.replace("$heading",heading);
				xml = xml.replace("$tilt", 79);
				
				//xml = xml.replace("$altiMode","clampToGround"); // "absolute");//"clampToGround"); //absolute
				
				completeXml += xml;
				avgHead += heading;
			}
			//trace(flyToXmlTag);
			avgHead = avgHead / l;

			completeXml = kmlTemplate.replace("$tour", completeXml);
			completeXml = completeXml.replace("$place", createLineString(track));
			completeXml = completeXml.replace("$altiMode","clampToGround"); // "absolute");//"clampToGround"); //absolute
			return completeXml;
		}
		
		/*
		 
		
		
		 * 
		 */
		private function createLineString(track:Array):String {
var placeMark:String = "\n<Placemark>\n<name>line</name>\n<LineString>\n<extrude>0</extrude>\n<tessellate>1</tessellate>\n<altitudeMode>$altiMode</altitudeMode>\n\t<coordinates>\n\t\t$coords\n\t</coordinates>\n</LineString>\n</Placemark>";
			
			var l:int = track.length;
			
			var comma:String = ",";
			var space:String = " ";
			var nl:String = "\n";
			
			var tp:TrackPoint;
			
			for (var i:int = 0; i < l; i++) {
				tp = track[i];
				
				lineString += tp.lon + comma + tp.lat + comma + tp.ele + space + nl;
			}
			
			placeMark = placeMark.replace("$coords", lineString);
			
			return placeMark;
		}
		
	}
	
}