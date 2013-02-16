package roekensk.geo.utils
{
	
	import flash.geom.Transform;
	import flash.net.URLRequestMethod;
	
	import roekensk.geo.objects.TrackPoint;
	import roekensk.utils.Color;
	import roekensk.utils.Math2;
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class GeoCalculation 
	{
		
		
		
		public static function calcGlideRatio(p1:TrackPoint, p2:TrackPoint):Number {
			var d:Number = calcDistance(p1, p2);
			var h:Number = Math.abs(p2.ele - p1.ele);
			
			var ratio:Number = (d * 1000) / h;
			return ratio;
		}
		
		public static function calcOverallGlideRatio(t:Array):Number {
			var d:Number = calcTotalDistance(t);
			var h:Number = t[0].ele - t[t.length - 1].ele;
			
			var ratio:Number = (d * 1000) / h;
			return ratio;
		}
		
		public static function calcAverageElevationPercentageBetween(t:Array):Number {
			//var d:Number = calcDistanceBetween(id1, id2, t) * 1000;
			
			//var hundredMeters:Number = d * 100 / d;

			var p1:TrackPoint = t[0] as TrackPoint;
			var p2:TrackPoint = t[t.length-1] as TrackPoint;
			
			var d:Number = calcTotalDistance(t)*1000;
			var h:Number = Math.abs(p1.ele - p2.ele) * 100 / d;
			//var h:Number = 0;
			return h;
		}
		
		public static function calcAverageGlideRatio(t:Array):Number {
			var total:Number = 0, ratio:Number, p1:TrackPoint, p2:TrackPoint, gr:Number,
			l:int = t.length;
			for (var i:int = 0; i < l; i++) {
				if (i + 1 < t.length) {
					p1 = t[i] as TrackPoint;
					p2 = t[i + 1] as TrackPoint;
					
					gr = calcGlideRatio(p1, p2);

					total = total + gr;
				}
			}
			ratio = total / t.length;
			return ratio;
		}
		
		public static function findMaxGlideRatio(t:Array):Number {
			var max:Number = 0, lastGlide:Number = 0,
			p1:TrackPoint, p2:TrackPoint,
			l:int = t.length;
			for (var i:int = 0; i < l; i=i+1) {
				if (i + 1 < t.length) {
					p1 = t[i] as TrackPoint;
					p2 = t[i + 1] as TrackPoint;
					
					lastGlide = calcGlideRatio(p1, p2);
					
					if (lastGlide > max) {
						max = lastGlide;
					}
				}
			}
			return max;
		}
		
		public static function findMedianGlideRatio(t:Array):Number {
			// sort
			var arr:Array = new Array(), p1:TrackPoint, p2:TrackPoint, lastGlide:Number, 
			l:int = t.length;
			for (var i:int = 0; i < l; i=i+1) {
				if (i + 1 < t.length) {
					p1 = t[i] as TrackPoint;
					p2 = t[i + 1] as TrackPoint;
					
					lastGlide = calcGlideRatio(p1, p2);
					
					arr.push(lastGlide);
				}
			}
			arr.sort(Array.NUMERIC);
			
			/*for (var j:Number = 0; j < arr.length; j++) {
				trace("#"+j+": "+arr[j]);
			}
			*/
			var ratio:Number = arr[Math.floor(arr.length / 2)];
			return ratio;
		}
		
		public static function calcStraightDistance(p1:TrackPoint, p2:TrackPoint):Number {
			return calcDistance(p1, p2);
		}
		
		public static function calcDistance(p1:TrackPoint, p2:TrackPoint):Number {
			var r:Number = 6371; /* straal aarde*/
			
			var dLat:Number = Math2.degToRad(p2.lat - p1.lat);
			var dLon:Number = Math2.degToRad(p2.lon - p1.lon);
			//Math.sqrt((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y)); // euclidian multiplication
			var a:Number = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(Math2.degToRad(p1.lat)) * Math.cos(Math2.degToRad(p2.lat)) * Math.sin(dLon/2) * Math.sin(dLon/2); 
			var c:Number = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
			var d:Number = r * c;
			//trace(d);
			var h:Number = p2.ele - p1.ele;
			
			var t:Number = Math.pow(d, 2) + Math.pow(h/1000, 2);
			return Math.sqrt(t);
		}
		
		public static function calcDistanceBetween(id1:Number, id2:Number, t:Array):Number {
			var distance:Number = 0, p1:TrackPoint, p2:TrackPoint;
			
			for (var i:int = id1; i < id2; i=i+1) {
				if(i+1 < t.length) {
					p1 = t[i] as TrackPoint;
					p2 = t[i + 1] as TrackPoint;
					
					distance = distance + GeoCalculation.calcDistance(p1, p2);
				}
			}
			return distance;
		}
		
		public static function calcTotalDistance(t:Array):Number {
			var distance:Number = 0, p1:TrackPoint, p2:TrackPoint,
			l:int = t.length;
			for (var i:int = 0; i < l; i=i+1) {
				if(i+1 < t.length) {
					p1 = t[i] as TrackPoint;
					p2 = t[i + 1] as TrackPoint;
					
					distance = distance + GeoCalculation.calcDistance(p1, p2);
				}
			}
			return distance;
		}
		
		public static function calcSpeed(p1:TrackPoint, p2:TrackPoint):Number {
			var speed:Number = 0;
			
			var d:Number = calcDistance(p1, p2);
			var time:Number = p2.timeStamp.totalSeconds - p1.timeStamp.totalSeconds;

			speed = (d * 3600) / time;
			
			return speed;
		}
		
		public static function calcAverageSpeed(t:Array):Number {
			var total:Number = 0, p1:TrackPoint, p2:TrackPoint,
			l:int = t.length, avg:Number;
			for (var i:int = 0; i < l; i=i+1) {
				if (i + 1 < t.length) {
					p1 = t[i] as TrackPoint;
					p2 = t[i + 1] as TrackPoint;
					
					total += calcSpeed(p1, p2);
				}
			}
			avg = (total / t.length);
			return avg;
		}
		
		public static function findMedianSpeed(t:Array):Number {
			var arr:Array = new Array(),
			l:int = t.length, p1:TrackPoint, p2:TrackPoint, s:Number, median:Number
			for (var i:int = 0; i < l; i=i+1) {
				if (i + 1 < l) {
					p1 = t[i] as TrackPoint;
					p2 = t[i + 1] as TrackPoint;
					
					s = calcSpeed(p1, p2);
					
					arr.push(s);
				}
			}
			arr.sort(Array.NUMERIC);
			
			median = arr[Math.floor(arr.length / 2)];
			return median;
		}
		
		public static function toBearing(nr:Number):Number {
			// convert radians to degrees (as bearing: 0...360)
			return (Math2.radToDeg(nr)+360) % 360;

		}
		
		public static function calculateBearing(p1:TrackPoint, p2:TrackPoint):Number {
			var lat1:Number = Math2.degToRad(p1.lat);//lat1.toRad(); 
			var lat2:Number = Math2.degToRad(p2.lat);//lat2.toRad();
			var dLon:Number = Math2.degToRad(p2.lon - p1.lon);

			  var y:Number = Math.sin(dLon) * Math.cos(lat2);
			  var x:Number = Math.cos(lat1)*Math.sin(lat2) -
					  Math.sin(lat1)*Math.cos(lat2)*Math.cos(dLon);
			  return toBearing(Math.atan2(y, x));

			
			
			//
			/*var y:Number = Math.sin(p1.lon-p2.lon) * Math.cos(p2.lat);
			var x:Number = Math.cos(p1.lat)*Math.sin(p2.lat) - Math.sin(p1.lat)*Math.cos(p2.lat)*Math.cos(p1.lon-p2.lon);
			return(Math.atan2(-y, x)); // -y 'cos Williams treats W as +ve!
			*/

		}
		public static function calculateTilting(p1:TrackPoint, p2:TrackPoint):Number {
			var dHeight:Number = p2.ele - p1.ele;
			var dist:Number = calcDistance(p1, p2)*1000;
			
			return Math.atan2(dHeight, dist);
		}
		
		public static function findMaxSpeed(t:Array):Number {
			var max:Number = 0,
			lastSpeed:Number = 0,
			l:int = t.length, p1:TrackPoint, p2:TrackPoint;
			for (var i:int = 0; i < l; i=i+1) {
				if (i + 1 < l) {
					p1= t[i] as TrackPoint;
					p2 = t[i + 1] as TrackPoint;
					
					lastSpeed = calcSpeed(p1, p2);
					
					if (lastSpeed > max) {
						max = lastSpeed;
					}
				}
			}
			return max;
		}
		
		public static function calcOverallTime(t:Array):Number {
			var timeInSeconds:Number = 0,
			p1:TrackPoint = t[0] as TrackPoint, 
			p2:TrackPoint = t[(t.length-1)] as TrackPoint;
			
			timeInSeconds = p2.timeStamp.totalSeconds - p1.timeStamp.totalSeconds;
			
			return timeInSeconds;
		}
		
		public static function calcTimeBetween(id1:Number, id2:Number, t:Array):Number {
			var timeInSeconds:Number = 0,
			p1:TrackPoint = t[id1] as TrackPoint,p2:TrackPoint = t[id2] as TrackPoint;
	
			timeInSeconds = p2.timeStamp.totalSeconds - p1.timeStamp.totalSeconds;
			
			return timeInSeconds;
		}
		
		public static function findFurthestPointFrom(t:Array, target:TrackPoint):TrackPoint {
			var max:Number = 0, furthest:TrackPoint, dist:Number = 0,
			l:int = t.length;
			for (var i:int = 0; i < l; i=i+1) {
				dist = calcDistance(target, t[i] as TrackPoint);
				if (dist > max) {
					max = dist;
					furthest = t[i] as TrackPoint;
				}
			}
			return furthest;
		}
		
		public static function findMaxElevation(t:Array):Number {
			var max:Number = 0, lastHeight:Number = 0,
			l:int = t.length, p:TrackPoint;
			for (var i:int = 0; i < l; i=i+1) {
				p = t[i] as TrackPoint;
				lastHeight = p.ele;
				
				if (lastHeight > max) {
					max = lastHeight;
				}
			}
			return max
		}
		
		public static function findMaxGroundLevel(t:Array):Number {
			var max:Number = 0, lastHeight:Number = 0,
			l:int = t.length, p:TrackPoint;
			for (var i:int = 0; i < l; i=i+1) {
				p = t[i] as TrackPoint;
				lastHeight = p.grnd;
				
				if (lastHeight > max) {
					max = lastHeight;
				}
			}
			return max
		}
		
		public static function findLowestElevation(t:Array):Number {
			var min:Number = t[0].ele,lastHeight:Number = 0,
			l:int = t.length, p:TrackPoint
			for (var i:int = 0; i < l; i=i+1) {
				p = t[i] as TrackPoint;
				lastHeight = p.ele;
				
				if (lastHeight < min) {
					min = lastHeight;
				}
			}
			return min
		}
		public static function findLowestGroundLevel(t:Array):Number {
			var min:Number = t[0].ele,lastHeight:Number = 0,
			l:int = t.length, p:TrackPoint
			for (var i:int = 0; i < l; i=i+1) {
				p = t[i] as TrackPoint;
				lastHeight = p.grnd;
				
				if (lastHeight < min) {
					min = lastHeight;
				}
			}
			return min
		}
		
		public static function findNearestId(t:Array, tp:TrackPoint):Number {
			var nearest:TrackPoint, nearestDist:Number = calcDistance(tp, t[0]), 
			nearestId:Number = 0, lastDist:Number = 0, 
			l:int = t.length, temp:TrackPoint;
			
			for (var i:int = 0; i < l; i=i+1) {
				temp = t[i];
				lastDist = calcDistance(tp, temp);
				
				if (lastDist < nearestDist) {
					nearestDist = lastDist;
					nearestId = i;
					nearest = temp;
				}
			}
			
				return nearestId;
		}
		
		public static function calcVario(i:Number, t:Array):Number {
			var p1:TrackPoint, p2:TrackPoint;
			if (i == 0) {
				p1 = t[0];
			} else {
				p1 = t[i - 1];
			}
			p2 = t[i];
			
			var h1:Number = p1.ele, h2:Number = p2.ele;
			
			var dh:Number = h2 - h1;
			
			var t1:Number = p1.timeStamp.totalSeconds, t2:Number = p2.timeStamp.totalSeconds;
			
			var dt:Number = t2 - t1;
			
			var v:Number = (dh * dt) / dt;
			
			return v;
		}
		
		public static function portSpeedToColor(p1:TrackPoint, p2:TrackPoint,arr:Array):Number {
			
				var maxSpeed:Number = GeoCalculation.findMaxSpeed(arr);
				
				var speed:Number = GeoCalculation.calcSpeed(p1, p2);
				
				var g:Number = Math.floor((255 * speed) / maxSpeed);
				var r:Number = 255 - g;
				
				return Color.RGBtoHEX(r, g, 0);
			
		}
	}
}