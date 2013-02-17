package com.nicolabortignon.geopic
{
	import com.greensock.TweenMax;
	import com.nicolabortignon.geopic.ApplicationCapabilities;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class TutorialPanel extends MovieClip
	{
		public var rightButton:MovieClip;
		public var leftButton:MovieClip;
		public var currentPage:MovieClip;
		
		private const _leftButtonPosition:int =  - 373;
		private const _leftShadowPosition:int = 273;
		private const _rightButtonPosition:int = 565;
		private const _rightShadowPosition:int = 114;
		private const _totalPages:int = 5;
		private var _currentPage:int = 0; 
		public function TutorialPanel()
		{
		
			
			super();
			this.visible = false;
			rightButton.leftShadow.visible = false;
			leftButton.rightShadow.visible = false;
			
			rightButton.buttonMode = true;
			rightButton.useHandCursor = true;
			rightButton.mouseChildren = false;
			
			leftButton.buttonMode = true;
			leftButton.useHandCursor = true;
			leftButton.mouseChildren = false;
			
			currentPage.leftShadow.visible = false;
			currentPage.rightShadow.visible = false;
			
			
			currentPage.addEventListener(MouseEvent.CLICK, nextPage);
			rightButton.addEventListener(MouseEvent.MOUSE_OVER, overStateRight);
			rightButton.addEventListener(MouseEvent.MOUSE_OUT, outStateRight);
			leftButton.addEventListener(MouseEvent.MOUSE_OVER, overStateLeft);
			leftButton.addEventListener(MouseEvent.MOUSE_OUT, outStateLeft);
			
			_currentPage = 0;
		
		}
		
		private function overStateLeft(e:MouseEvent):void{
			TweenMax.to(leftButton.leftShadow,.4,{autoAlpha:.5,x:_leftShadowPosition-20});
			TweenMax.to(leftButton,.4,{x:_leftButtonPosition+20});
		}
		private function outStateLeft(e:MouseEvent):void{
			TweenMax.to(leftButton.leftShadow,.4,{autoAlpha:1,x:_leftShadowPosition+20});
			TweenMax.to(leftButton,.4,{x:_leftButtonPosition});
		}
		
		
		private function overStateRight(e:MouseEvent):void{
			TweenMax.to(rightButton.rightShadow,.4,{autoAlpha:.5,x:_rightShadowPosition+20});
			TweenMax.to(rightButton,.4,{x:_rightButtonPosition-20});
		}
		private function outStateRight(e:MouseEvent):void{
			TweenMax.to(rightButton.rightShadow,.4,{autoAlpha:1,x:_rightShadowPosition-20});
			TweenMax.to(rightButton,.4,{x:_rightButtonPosition});
		}
		
		
		
		private function nextPage(e:MouseEvent):void{
			// move NEXT
			
		}
		
		private function previousPage(e:MouseEvent):void{
			
		}
		
		
		public function show():void{
			rightButton.x =  ApplicationCapabilities.getInstance().mainWindowHeight+500;
			leftButton.x = -500;
			currentPage.alpha = 0;
			
			
			this.visible = true;
			TweenMax.to(rightButton,.5,{delay:1.2,x:_rightButtonPosition});
			TweenMax.to(leftButton,.5,{delay:1.2,x:_leftButtonPosition});
			TweenMax.to(currentPage,1,{delay:1.5,autoAlpha:1});
			
			
		}
	}
}