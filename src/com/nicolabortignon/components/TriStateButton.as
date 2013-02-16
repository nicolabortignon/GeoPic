package com.nicolabortignon.components
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class TriStateButton extends MovieClip
	{
		
		private var _isSelected = false;
		private var _selectedCallBackFunction:Function;
		public var id:int;
		
		public function TriStateButton()
		{
			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);	
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);	
			this.addEventListener(MouseEvent.MOUSE_OVER, overState);
			this.addEventListener(MouseEvent.MOUSE_OUT, outState);
			this.alpha = .9;
		}
		private function overState(e:MouseEvent):void{
			this.alpha = 1;
		}
		private function outState(e:MouseEvent):void{
			this.alpha = .9;
		}
		private function mouseDownHandler(e:MouseEvent):void{
			this.alpha = 1;
			this.gotoAndStop(2);
		}
		private function mouseUpHandler(e:MouseEvent):void{
			this.alpha = .9;
			this.gotoAndStop(1);
		}
		
		private function clicked(e:MouseEvent):void{
			if(_isSelected){
				return;
			}
			else{
				select();
				if(_selectedCallBackFunction != null)
					_selectedCallBackFunction();
			}
		}
		public function select():void{
			this.gotoAndStop(2);
			_isSelected = true;
		}
		public function deselect():void{
			this.gotoAndStop(1);
			_isSelected = false;
		}
		
		public function isSelected():Boolean{
			return _isSelected;
		}
		public function setCallBackFunction(f:Function):void{
			_selectedCallBackFunction = f;
		}
	}
}  
