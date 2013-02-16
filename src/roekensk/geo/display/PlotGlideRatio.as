package roekensk.geo.display 
{
	import roekensk.display.plot.Plot;
	import roekensk.geo.objects.TrackPoint;
	import roekensk.geo.utils.GeoCalculation;
	
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class PlotGlideRatio extends Plot
	{
		
		public function PlotGlideRatio(_arr:Array,width:Number,height:Number) 
		{
			super(_arr, width, height);
			yMax = GeoCalculation.findMedianGlideRatio(this.arr) * 10;//GeoCalculation.findMaxGlideRatio(arr);
		   
			drawPlot();
		}
		
		
		override public function calcY(p:TrackPoint, i:Number):Number {
			var gr:Number = 0;
			if (i + 1 < arr.length) {
				gr = GeoCalculation.calcGlideRatio(arr[i], arr[i + 1]);
			} else {
				gr = GeoCalculation.calcGlideRatio(arr[i], arr[arr.length-1]);
			}
			if (gr > yMax) {
				gr = yMax;
			}
			return gr;
		}

	}
	
}