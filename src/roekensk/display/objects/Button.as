package roekensk.display.objects 
{
	import com.google.maps.styles.BevelStyle;
	import com.google.maps.styles.ButtonStyle;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BevelFilter;
	import flash.text.StaticText;
	import flash.text.TextField;
	import roekensk.display.objects.events.ButtonEvent;
	import roekensk.utils.Utils;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Button extends Component
	{
		public var id:int;
		public var _property:Object;
		
		private var comp:Shape;
		private var state:String = ButtonState.BUTTON_IDLE;
		private var _text:String ="";
		public function Button(text:String, width:Number,height:Number,color:Number = 0xFF0000) 
		{
			super(width, height, color);
			
			this._text = text;
			
			this.mouseChildren = false;
			this.useHandCursor = false;
			
			addEventListeners();
			
			drawComp();
		}
		
		private function addEventListeners():void {
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function removeEventListeners():void {
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function setText(t:String):void {
			_text = t;
			redrawComp(state);
		}
		
		public function enable():void {
			removeEventListeners();
			addEventListeners();
			redrawComp(ButtonState.BUTTON_IDLE);
		}
		public function disable():void {
			removeEventListeners();
			redrawComp(ButtonState.BUTTON_DISABLED);
		}
		
		private function onMouseDown(e:MouseEvent):void {
			redrawComp(ButtonState.BUTTON_PRESSED);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function onMouseOver(e:MouseEvent):void {
			
			redrawComp(ButtonState.BUTTON_OVER);
		}
		private function onMouseOut(e:MouseEvent):void {

			redrawComp(ButtonState.BUTTON_IDLE);
		}
		
		private function onMouseUp(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			if (e.target == this || this.contains(e.target as DisplayObject)) {
				onReleaseHandler(e);
			} else {
				onReleaseOutsideHandler(e);
			}
			
			redrawComp(ButtonState.BUTTON_IDLE);
		}
		
		private function onReleaseHandler(e:MouseEvent):void {
			dispatchEvent(new ButtonEvent(ButtonEvent.ON_RELEASE));
		}
		private function onReleaseOutsideHandler(e:MouseEvent):void {
			
		}
		
		private function redrawComp(s:String):void {
			state = s;
			drawComp();
		}
		override public function drawComp():void {
			removeChildren();
			
			comp = new Shape();
			var txtBox:TextField = new TextField();
			txtBox.x = 5;
			txtBox.y = 1;
			txtBox.width = _width - 5;
			txtBox.height = _height - 2;
			txtBox.text = _text;
			//txtBox.border = true
			//txtBox.selectable = false;
			var pushedDist:Number = 2;
			switch(state) {
				case ButtonState.BUTTON_IDLE : 
					txtBox.textColor = 0x000000;
					_color = 0xDDDDDD;
					break;
				case ButtonState.BUTTON_PRESSED :
					pushedDist = -1;
					txtBox.x = 6;
					txtBox.y = 2;
					//_color = 0xCCCCCC;
					break;
				case ButtonState.BUTTON_OVER :
					_color = 0xEEEEEE;
					break;
				case ButtonState.BUTTON_DISABLED :
					txtBox.textColor = 0xAAAAAA;
					break;
			}
			
			
			comp.graphics.beginFill(_color);
			comp.graphics.drawRoundRect(0, 0, _width, _height,5,5);
			comp.graphics.endFill();
			
			var bFilter:BevelFilter = new BevelFilter(pushedDist, 45, 0xFFFFFF, 1, 0x000000, 1, 1, 1, 1, 1, "inner");
			var fArr:Array = new Array(bFilter);
			
			comp.filters = fArr;
			
			addChild(comp);
			addChild(txtBox);
		}
		
	}
	
}