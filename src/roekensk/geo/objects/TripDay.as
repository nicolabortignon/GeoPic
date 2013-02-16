package roekensk.geo.objects 
{
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class TripDay 
	{
		private var name:String;
		private var tracks:Array = new Array();
		public function TripDay() 
		{
			
		}
		
		public function setName(n:String):void {
			this.name = n;
		}
		public function getName():String {
			return this.name;
		}
		
		public function setTracks(t:Array):void {
			this.tracks = t;
		}
		public function getTracks():Array {
			return this.tracks;
		}
		public function addTrack(t:Track):void {
			this.tracks.push(t);
		}
		public function getTrack(i:int):Track {
			return tracks[i];
		}
	}
	
}