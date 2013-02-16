package com.nicolabortignon.components
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class CustomButton extends MovieClip
	{
		
		private var _isSelected = false;
		private var _selectedCallBackFunction:Function;
		public var id:int;
		
		public function CustomButton()
		{
			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false;
			
			this.addEventListener(MouseEvent.CLICK, clicked);	
			this.addEventListener(MouseEvent.MOUSE_OVER, overState);
			this.addEventListener(MouseEvent.MOUSE_OUT, outState);
		}
		private function overState(e:MouseEvent):void{
			this.gotoAndStop(2);
		}
		private function outState(e:MouseEvent):void{
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

