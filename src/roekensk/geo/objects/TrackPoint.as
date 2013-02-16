package roekensk.geo.objects
{
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class TrackPoint 
	{
		public var lat:Number = 0;
		public var lon:Number = 0;
		public var ele:Number = 0;
		public var timeStamp:TimeStamp;
		
		public var grnd:Number = 0;
		
		public function TrackPoint(_lat:String,_lon:String,_ele:String="0",_time:TimeStamp=null) 
		{
			this.lat = parseFloat(_lat);
			this.lon = parseFloat(_lon);
			this.ele = parseFloat(_ele);
			this.timeStamp = _time;
		}
		
		public function toXMLString():String {
			var s:String = "<trkpt lat=\""+lat+"\" "+"lon=\""+lon+"\">\n\t<ele>" +ele + "</ele>\n\t<time>" + timeStamp.raw + "</time>\n</trkpt>";
			return s;
		}
		
	}
	
}