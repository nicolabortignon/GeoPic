package roekensk.geo.display
{
        import flash.display.BitmapData;
        import flash.display.GradientType;
        import flash.display.Shape;
        import flash.display.Sprite;
        import flash.events.Event;
        import flash.events.EventDispatcher;
        import flash.events.MouseEvent;
        import flash.geom.Point;
        import flash.ui.Mouse;
        import roekensk.display.objects.DraggablePointer;
		import roekensk.display.objects.Selection;
        import roekensk.display.plot.events.PlotClickedEvent;
		import roekensk.display.plot.events.PlotEvent;
        import roekensk.display.plot.Plot;
        import roekensk.display.objects.Pointer;
		import roekensk.display.plot.SelectablePlot;
        import roekensk.geo.objects.TrackPoint;
        import roekensk.geo.webservices.ElevationPointService;
        import roekensk.utils.Color;
       
        import roekensk.geo.utils.GeoCalculation;
       
        /**
        * ...
        * @author DefaultUser (Tools -> Custom Arguments...)
        */
        public class PlotElevation extends Plot
        {
                public var _name:String = "elevation";
               
                private var disp:EventDispatcher = new EventDispatcher();
                private var _color:Boolean = false;
               
                public var temp:Object = new Object();
                public var clickedId:Number;
				
                public var clickedPos:Point;
               
                public var po:Pointer;
               
                //private var eps:ElevationPointService = new ElevationPointService();
               
                public function PlotElevation(_arr:Array,color:Boolean=false,thickness:Number=3)
                {
                        super(_arr);
                        this.thickness = thickness;
                        this._color = color;
                       
                        xLabel = "distance";
                        yLabel = "height";
                       
                        filled = true;
                        fill_color = 0x000000;
                        fill_alpha = 0;
                        buffer = 2;
						
                        //yMin = 0;//GeoCalculation.findLowestElevation(this.arr);
						xMax = GeoCalculation.calcDistanceBetween(0, arr.length, arr);
						yMin = GeoCalculation.findLowestElevation(this.arr);
                        yMax = GeoCalculation.findMaxElevation(this.arr);
						
                        this.addEventListener(MouseEvent.MOUSE_UP, onClick);
                }
               
                public function onClick(e:MouseEvent):void {
                        clickedId = findId(mouseX);//Math.floor(mouseX/(this._width/arr.length)) + 1 ;
                        clickedPos = calcCoords(clickedId);
                       
                        var ne:Event = new PlotEvent(PlotEvent.ON_RELEASE);

                        dispatchEvent(ne);
                }
               
                public function putPointer():void {
                        po = new DraggablePointer(0, 0);//p.x, p.y);
                       
                        addChild(po);
                }

                public function movePointer(id:Number):void {
                        trace("movepionter");
                        var p:Point = new Point();
                        p = this.calcCoords(id);
                       
                        po.x = p.x;
                        po.y = p.y;
                }
               
				override public function calcX(p:Object, i:Number):Number {
					return GeoCalculation.calcDistanceBetween(0, i, arr);
				}
				
                override public function calcY(p:Object,i:Number):Number
                {
                        return p.ele;
                }
               
                override public function colorPlot(p1:Object, p2:Object):Number {
                        if(_color) {
                        return GeoCalculation.portSpeedToColor(p1 as TrackPoint, p2 as TrackPoint, arr);
                        } else {
                                return Color.RGBtoHEX(0, 255, 0);
                        }
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