package roekensk.display.plot
{
        import flash.display.GradientType;
        import flash.display.InterpolationMethod;
        import flash.display.Shape;
        import flash.display.SpreadMethod;
        import flash.display.Sprite;
        import flash.geom.Matrix;
        import flash.geom.Point;
		import roekensk.display.objects.Selection;
        import roekensk.geo.objects.TrackPoint;
        import roekensk.utils.Color;
		import roekensk.utils.Utils;
       
        /**
        * ...
        * @author DefaultUser (Tools -> Custom Arguments...)
        */
        public class Plot extends Sprite
        {
                public var arr:Array;
               
                public var _width:Number;
                public var _height:Number;
				
				public var xMax:Number = 1;
				
                public var yMax:Number = 1;
                public var yMin:Number = 0;
               
                public var buffer:Number = 0;
               
                public var plot:Shape = new Shape();
               
                public var thickness:Number = 2;
               
                public var xLabel:String = "x";
                public var yLabel:String = "y";
               
                public var filled:Boolean = false;
                public var fill_color:Number = 0x993333;
                public var fill_gradient:Boolean = false;
                public var fill_alpha:Number = 0.75;
                public var color:Number = 0x00FF00;
                //public var alpha:Number = 1;
               
                public function Plot(_arr:Array)
                {
                        this.arr = _arr;
                       
                       
                        //drawPlot();
                }
               
                public function draw(_width:Number, _height:Number):void {
                        this._width = _width;
                        this._height = _height;
                        removeChildren();
                        drawPlot();
                }
               
             /*   public function removeChildren():void{
                        while(this.numChildren){
                                removeChildAt(0);
                        }
                }
               */
                public final function calcCoords(i:Number):Point {
                        
						//var xMax:Number = (arr.length * this._width) / arr.length;
                       
                        var newX:Number, newY:Number = 0;
                       
                        //newX = (this._width / arr.length) * i;
                       
                        // x coords on distance
						
						
						
						
						
						var o:Object = arr[i];
						
						newX = (this._width / xMax) * calcX(o,i);
                        var h:Number = calcY(o, i);

                        var croppedHeight:Number = (h - yMin + buffer);
                        var croppedMax:Number = (yMax - yMin + buffer);
                        newY = (croppedHeight / croppedMax * _height) - _height;
						
						/*var yRange:Number = yMax - yMin;
						var yRangeScaled:Number = yRange * _height / yRange;
						newY = yRangeScaled * h - _height;*/
                       
                        var point:Point = new Point(newX, -newY);
                        return point;
                }
       
				public function calcX(p:Object, i:Number):Number {
					return 1;
				}
				
                public function calcY(p:Object,i:Number):Number {
                       
                        return 1;
                }
               
                public final function drawPlot():void {
                       
                        plot.graphics.lineStyle(thickness, alpha);
                        if (filled) {
                                if (fill_gradient) {
                                       
                                        var matrix:Matrix = new Matrix();
                                        var rot:Number = Math.PI / 2; // 90
                                        matrix.createGradientBox(_width, _height, -rot,25, 0);
                                        plot.graphics.beginGradientFill(GradientType.LINEAR,
                                        [0xFF0000, 0x00FF00], //colors
                                        [0.75, 0.75], // alphas
                                        [0, 250], // ratios
                                        matrix);
                                } else {
                                        plot.graphics.beginFill(fill_color, fill_alpha);
                                }
                        }
                        var lastColor:Number = color,
						l:int = arr.length, p:Point;
                        for (var i:int = 0; i < l; i++) {
                                p = calcCoords(i);
								var newColor:Number = color;
                               
                               // var newColor:Number = color;
                                if(i>0) {
                                        newColor = colorPlot(arr[i - 1] /*as TrackPoint*/, arr[i]);
                                }
                                plot.graphics.lineStyle(thickness, newColor,alpha); //lineGradientStyle(GradientType.LINEAR, [lastColor, newColor],[1,1],[0,255]);
                                if(i<1) {
                                        plot.graphics.moveTo(p.x, p.y);
                                } else {
                                        plot.graphics.lineTo(p.x, p.y);
                                }
                               
                                lastColor = newColor;
                        }
                        if (filled) {
                                p = calcCoords(/*arr[arr.length - 1], */arr.length-1);
                                plot.graphics.lineStyle(1, 0x000000, 0);
                                plot.graphics.lineTo(p.x, _height);
                                //plot.graphics.lineTo(_width, arr[arr.length-1]);
                                p = calcCoords(0);
                               
                                plot.graphics.lineTo(p.x, _height);
                               
                                plot.graphics.endFill();
                        }
                        addChild(plot);
                }
               
                public function colorPlot(p1:Object, p2:Object):Number {
                        return color;
                }
               
                public function findId(xPos:Number):Number {
                        return Math.floor(xPos/(this._width/arr.length)) + 1 ;
                }
				
				public function redraw():void {
					Utils.removeChildren(this);
					drawPlot();
				}
        }
       
}