package roekensk.utils {
public class Math2 {
 /*static function rndBetween(n1:Number, n2:Number):Number {
  return n1+Math.random(n2-n1+1);
 }*/
 public static function radToDeg(n:Number):Number {
  return n*180/Math.PI;
 }
 public static function degToRad(n:Number):Number {
  return n/180*Math.PI;
 }
 public static function degSin(n:Number):Number {
  return Math.sin(n/180*Math.PI);
 }
 public static function degCos(n:Number):Number {
  return Math.cos(n/180*Math.PI);
 }
 public static function degTan(n:Number):Number {
  return Math.tan(n/180*Math.PI);
 }
 public static function angleBetweenRad(x1:Number, y1:Number, x2:Number, y2:Number):Number {
  return Math.atan2((y1-y2), (x1-x2));
 }
 public static function angleBetweenDeg(x1:Number, y1:Number, x2:Number, y2:Number):Number {
  return Math.atan2((y1-y2), (x1-x2))*180/Math.PI;
 }
 public static function distanceBetween(x1:Number, y1:Number, x2:Number, y2:Number):Number {
  return Math.sqrt(Math.pow((y1-y2),2)+ Math.pow((x1-x2),2));
 }
 
 public static function roundDecimal(num:Number, places:Number):Number {
		return int( (num) * Math.pow(10, places) ) / Math.pow(10, places);
	}
}
}