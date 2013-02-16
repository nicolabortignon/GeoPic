package roekensk.geo.display
{
        import flash.display.Shape;
        import flash.display.Sprite;
        import flash.events.Event;
        import flash.events.MouseEvent;
        import flash.geom.Point;
        import roekensk.display.plot.events.PlotClickedEvent;
        import roekensk.display.plot.Plot;
        import roekensk.geo.objects.TrackPoint;
        import roekensk.geo.utils.GeoCalculation;
       
        /**
        * ...
        * @author DefaultUser (Tools -> Custom Arguments...)
        */
        public class PlotSpeed extends Plot
        {
                public var _name:String = "speed";
               
                public var clickedId:Number;
                public var clickedPos:Point;
               
                public function PlotSpeed(_arr:Array)//,width:Number,height:Number)
                {
                        super(_arr);
						
						
						
						xMax = GeoCalculation.calcDistanceBetween(0, arr.length, arr);
						
                        yMax = GeoCalculation.findMaxSpeed(arr);
                        yMin = 0;
                        thickness = 1;
						xLabel = "distance";
                        yLabel = "speed";
                        filled = true;
                        fill_gradient = true;
                        fill_alpha = 0.75;
                        //drawPlot();
                        this.addEventListener(MouseEvent.MOUSE_UP, onClick);
                }
               
				override public function calcX(p:Object, i:Number):Number {
					return GeoCalculation.calcDistanceBetween(0, i, arr);
				}
				
                override public function calcY(p:Object, i:Number):Number {
                        if (i + 1 < arr.length) {
                                return GeoCalculation.calcSpeed(arr[i], arr[i + 1]);
                        } else {
                                return GeoCalculation.calcSpeed(arr[i-1], arr[arr.length-1]);
                        }
                       
                }
               
                public function onClick(e:MouseEvent):void {
                        clickedId = Math.floor(mouseX/(this._width/arr.length)) + 1 ;
                        clickedPos = calcCoords(clickedId);
                       
                        var ne:Event = new PlotClickedEvent(PlotClickedEvent.ON_READY);

                        dispatchEvent(ne);
                }
				
				override public function findId(xPos:Number):Number {
					
					var xDist:Number = (xPos * xMax) / this._width;
					
					//return xDist;
					
					
					var l:int = arr.length;
					var lastDist:Number;
					
					var smallesDist:Number = xDist;
					var nearestId:int;
					
					var delta:Number;

					for (var i:int = 0; i < l; i=i+1) {

						lastDist = GeoCalculation.calcDistanceBetween(0, i, arr);
						delta = Math.abs(xDist - lastDist);
						if (delta < smallesDist) {
							smallesDist = delta
							nearestId = i;
						}
					}

					return nearestId;
				}              
               
        }
       
}