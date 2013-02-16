package roekensk.geo.webservices 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import roekensk.display.objects.Information;
	import roekensk.geo.objects.TrackPoint;
	import roekensk.geo.utils.GeoCalculation;
	import roekensk.geo.utils.TravelType;
	import roekensk.geo.webservices.events.TrackServiceEvent;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class TrackService extends EventDispatcher
	{
		private var track:Array;
		
		private var heightService:ElevationTrackService;
		public var elevationAvailable:Boolean = false;
		private var groundLevelAvailable:Boolean = false;
		
		private var travelType:String;
		
		public function TrackService(track:Array,travelType:String = "AIR") 
		{
			this.track = track;
			this.travelType = travelType;
			//heightService = new ElevationTrackService(track);
			//heightService.addEventListener(Event.COMPLETE, onHeightTrackComplete);
		}
		
		public function getTrack():Array {
			return this.track;
		}
		public function getTravelType():String {
			return this.travelType;
		}
		
		public function getDetails(selection:Array):Array {
			if (selection == null) {
				return getSelectionDetails(track);
			} else if ((selection[0] - selection[1]) == 0) {
				return getSinglePointDetails(selection[0]);
			} else {
				var trackSelection:Array = new Array();
				for (var i:Number = selection[0]; i < selection[1]; i++) {
					trackSelection.push(track[i]);
				}
				return getSelectionDetails(trackSelection);
			}
		}
		
		private function getSinglePointDetails(id:Number):Array {
			var information:Array = new Array();

			var other:Number = 1;
            if(id >= track.length-1) { other = 0 }
			
			var elev:Information = new Information("Above Sea",track[id].ele,"m");
			var travDist:Information = new Information("Straight Distance",GeoCalculation.calcDistance(track[0], track[id]),"km");
			var straightDist:Information = new Information("Travelled Distance",GeoCalculation.calcDistanceBetween(0, id, track),"km");
			var speed:Information = new Information("Speed",GeoCalculation.calcSpeed(track[id], track[id + other]),"km/h");
			var gr:Information = new Information("Glide Ratio",GeoCalculation.calcGlideRatio(track[id], track[id + other]));
			var time:Information = new Information("Time",GeoCalculation.calcTimeBetween(0,id,track)/60,"min");
			var height:Information = new Information("Above Ground", (track[id].ele - track[id].grnd),"m");
			var vario:Information = new Information("Vario",GeoCalculation.calcVario(id,track),"m/s");
			
			switch (travelType) {
				case TravelType.AIR :
					information.push(elev,travDist,straightDist,speed,gr,time,height,vario);
					break;
				case TravelType.BICYCLE :
					information.push(elev,travDist,straightDist,speed,time);
					break;
				case TravelType.FOOT : 
					information.push(elev, travDist, straightDist, speed, time);
					break;
				default :
					information.push(elev, travDist, straightDist, speed, gr, time, height, vario);
			}
			
			return information;
		}
		
		private function getSelectionDetails(selection:Array):Array {
			var information:Array = new Array();

			var totalDistance:Number = GeoCalculation.calcTotalDistance(selection);
			
			var avSpd:Information = new Information("average speed", GeoCalculation.calcAverageSpeed(selection),"km/h");
			var dist:Information = new Information("distance", totalDistance,"km");
			var time:Information = new Information("overall time", (GeoCalculation.calcOverallTime(selection) / 60),"min");
			var avGr:Information = new Information("average glide ratio", GeoCalculation.calcAverageGlideRatio(selection));
			var meGr:Information = new Information("median glide ratio", GeoCalculation.findMedianGlideRatio(selection));
			var hiGr:Information = new Information("max glide ratio", GeoCalculation.findMaxGlideRatio(selection));
			var meSpd:Information = new Information("median speed", GeoCalculation.findMedianSpeed(selection));
			var maxSpd:Information = new Information("max speed", GeoCalculation.findMaxSpeed(selection), "km/h");
			var hPerc:Information = new Information("elevation percentage", GeoCalculation.calcAverageElevationPercentageBetween(selection),"%");

			var h:Number = GeoCalculation.findMaxElevation(selection);
			var l:Number = GeoCalculation.findLowestElevation(selection);
			
			var highest:Information = new Information("highest point", h,"m");
			var lowest:Information = new Information("lowest point", l,"m");
			var dEle:Information = new Information("height difference", h - l,"m");
			
			switch (travelType) {
				case TravelType.AIR :
					information.push(dist,time,dEle,highest,lowest,meGr,avGr,avSpd,meSpd,maxSpd);
					break;
				case TravelType.BICYCLE :
					information.push(dist,highest,lowest,time,avSpd,maxSpd,meSpd,hPerc);
					break;
				case TravelType.FOOT : 
					information.push(dist,time,avSpd,maxSpd,meSpd,hPerc);
					break;
				default :
					information.push(dist, time, dEle, highest, lowest, meGr, avGr, avSpd, meSpd, maxSpd,hPerc);
			}
			
			return information;
		}
		private function onHeightTrackComplete(e:Event):void {
			var ets:ElevationTrackService = e.target as ElevationTrackService, tp:TrackPoint;
			
			var l:int = track.length;
			for (var i:int = 0; i < l; i++) {
				tp = track[i] as TrackPoint;
				tp.grnd = ets.trk[i];
				trace(tp.grnd);
				track[i] = tp;
			}
			elevationAvailable = true;
			
			dispatchEvent(new TrackServiceEvent(TrackServiceEvent.HEIGHT_AVAILABLE));
		}
		private function replaceElevationWithGroundLevel():void {
			var l:int = track.length, p:TrackPoint = null;
			for (var i:int = 0; i < l; i++) {
				p = track[i] as TrackPoint;
				p.ele = p.grnd;
				track[i] = p;
			}
			//redo ->
			dispatchEvent(new TrackServiceEvent(TrackServiceEvent.HEIGHT_AVAILABLE));
		}
		public function setGroundLevelAvailable(available:Boolean):void {
			groundLevelAvailable = available;
			if (available && travelType!=TravelType.AIR) {
				replaceElevationWithGroundLevel();
			}
		}
	}
	
	
	
}