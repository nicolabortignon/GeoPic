package roekensk.geo.display 
{
	import roekensk.display.plot.Plot;
	import roekensk.geo.utils.GeoCalculation;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class PlotSelector extends Plot
	{
		
		public function PlotSelector(_arr:Array) 
		{
			super(_arr);
			
			xLabel = "distance";
			yLabel = "height";
			
			xMax = GeoCalculation.calcDistanceBetween(0, arr.length, arr);
			yMin = GeoCalculation.findLowestElevation(this.arr);
			yMax = GeoCalculation.findMaxElevation(this.arr);
						
		}
		
		override public function calcX(p:Object, i:Number):Number {
			return GeoCalculation.calcDistanceBetween(0, i, arr);
		}
		
		override public function calcY(p:Object,i:Number):Number
		{
				return p.ele;
		}
		
	}
	
}