package roekensk.geo.display
{
        import roekensk.display.plot.Plot;
        import roekensk.geo.objects.TrackPoint;
		import roekensk.geo.utils.GeoCalculation;
       
        /**
         * ...
         * @author DefaultUser (Tools -> Custom Arguments...)
         */
        public class PlotGroundElevation extends Plot
        {
               
               
               
                public function PlotGroundElevation(_arr:Array/*,width:Number,height:Number*/,max:Number=0,min:Number=0)
                {
                        super(_arr);//, width, height);
						if(max != 0) {
                        yMax = max;
						} else {
							yMax = GeoCalculation.findMaxGroundLevel(_arr);
						}
						yMin = GeoCalculation.findLowestGroundLevel(_arr);
                       
                        fill_color = 0xFFEE55;
                        filled = true;
                        color = 0xFFEE33;
                        alpha = 0.75;
                        buffer = 150;
                       
                        //trace("profileplot- " + _arr[0]);
                        //yMax = //GeoCalculation.findMaxElevation(this.arr);
                        
						//drawPlot();
                       
                }
               
                override public function calcY(p:Object,i:Number):Number
                {
					var tmp:TrackPoint = arr[i] as TrackPoint;
                        return tmp.grnd;
                }
        }
       
}