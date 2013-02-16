package roekensk.geo.utils 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import roekensk.geo.objects.Track;
	import roekensk.geo.objects.TrackPoint;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class DouglasPeucker extends EventDispatcher
	{
		private var track:Array;
		public var result:Array;
		
		
		
		public function DouglasPeucker() {
			
		}
		
		public function calculate(track:Array, steps:Number=1):void {
			this.track = track;
			var tempResult:Array = new Array();
			var lastId:Number = 0;
			//for (var j:Number = 0; j < steps; j++) {
				lastId = checkPoints(0, track.length - 1);
				tempResult.push(track[lastId]);
			//}
			tempResult.push(track[checkPoints(0, lastId)]);
			
			
			result = new Array();
			result.push(track[0]);
			for (var i:Number = 0; i < tempResult.length; i++) {
				result.push(tempResult[i]);
				//trace("lat: "+tempResult[i].lat + " lon: " + tempResult[i].lon);
			}
			result.push(track[track.length - 1]);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function checkPoints(start:Number, end:Number):Number {
			trace("start: " + start + "end " + end);
			//var startPoint:TrackPoint, endPoint:TrackPoint;
			var startPoint:TrackPoint = track[start] as TrackPoint;
			var endPoint:TrackPoint = track[end] as TrackPoint;
			trace("start: lat: " + startPoint.lat + " lon: " + startPoint.lon);
			trace("end: lat: " + endPoint.lat + " lon: " + endPoint.lon);
			var slope:Number = calcSlope(startPoint, endPoint);
			trace("slope: " + slope);
			var coeff:Number = (end - start);
			var scale:Number = (endPoint.lat - startPoint.lat)/coeff;
			
			var p1:TrackPoint, p2:TrackPoint;
			var dist:Number = 0;var tempDist:Number;
			
			var furthestIndex:Number;
			
			var index:Number = 1;
			
			for (var i:Number = start; i < end;i++) {
				p1 = track[i];
				
				p2 = new TrackPoint((p1.lat+(scale*index)).toString(), (slope * (p1.lat+(scale*index)) + 1).toString());
				
				tempDist = GeoCalculation.calcStraightDistance(p1, p2);
				
				if (dist < tempDist) {
					dist = tempDist;
					furthestIndex = i;
				}
				index++;
			}
			trace("dist: " + dist);
			trace(furthestIndex);
			return furthestIndex;
		}
		
		
		private function calcSlope(p1:TrackPoint, p2:TrackPoint):Number {
			return (p2.lat - p1.lat) / (p2.lon - p1.lon);
		}
	}
	
}