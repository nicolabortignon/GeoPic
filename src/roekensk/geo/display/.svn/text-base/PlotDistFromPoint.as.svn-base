package roekensk.geo.display 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import roekensk.display.plot.Plot;
	import roekensk.geo.objects.TrackPoint;
	import roekensk.geo.utils.GeoCalculation;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class PlotDistFromPoint extends Plot
	{
		

		public var _target:TrackPoint;
		
		
		public function PlotDistFromPoint(_arr:Array,target:TrackPoint,width:Number,height:Number) 
		{
			super(_arr);
			this._target = target;
			
			yMax = GeoCalculation.calcDistance(_target, GeoCalculation.findFurthestPointFrom(arr, _target));
			
			//drawPlot();
		}
		
		override public function calcY(p:Object,i:Number):Number {
			return GeoCalculation.calcDistance(p as TrackPoint, _target);
		}
		
	}
	
}