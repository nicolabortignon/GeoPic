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
			rightButton.addEventListener(MouseEvent.CLICK, nextPage);
			leftButton.addEventListener(MouseEvent.CLICK, previousPage);
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
			if(_currentPage < _totalPages){
				_currentPage++;
				TweenMax.to(currentPage,.2,{x:currentPage.x - 300,y:currentPage.y+100,scaleX:.8,scaleY:.8, autoAlpha:.1, onComplete:function(){
					currentPage.gotoAndStop(_currentPage+1);
					rightButton.gotoAndStop(_currentPage+2);
					leftButton.gotoAndStop(_currentPage);
					currentPage.x = currentPage.x + 600;
					currentPage.alpha = 1;
					currentPage.visible = true;
					TweenMax.to(currentPage,.2,{scaleX:1,scaleY:1,y:currentPage.y-100,x:currentPage.x - 300, autoAlpha:1});
				}});
				leftButton.visible = true;
				rightButton.visible = true;
				
			}
			if(_currentPage == _totalPages){
				rightButton.visible = false;
			}
			if(_currentPage == 1){
				leftButton.visible = false;
				TweenMax.to(leftButton,.5,{autoAlpha:1, delay:.2});
			}
			
		}
		
		private function previousPage(e:MouseEvent):void{
			if(_currentPage >= 0){
				_currentPage--;
				TweenMax.to(currentPage,.2,{scaleX:.6,scaleY:.6,y:currentPage.y+100,  x:currentPage.x + 400, autoAlpha:.1, onComplete:function(){
					currentPage.gotoAndStop(_currentPage+1);
					rightButton.gotoAndStop(_currentPage+2);
					leftButton.gotoAndStop(Math.max(0,_currentPage));
					currentPage.x = currentPage.x - 600;
					currentPage.alpha = 1;
					currentPage.visible = true;
					TweenMax.to(currentPage,.2,{scaleX:1,scaleY:1,y:currentPage.y-100,x:currentPage.x + 200, autoAlpha:1});
				}});
			
				leftButton.visible = true;
				rightButton.visible = true;
				
			}
			if(_currentPage == 0){
				leftButton.visible = false;
			}
			if(_currentPage < _totalPages-1){
				rightButton.visible = false;
				rightButton.alpha = 0;
				TweenMax.to(rightButton,.5,{autoAlpha:1, delay:.2});
			}
	
			
			
		}
		
		
		public function show():void{
			
			leftButton.visible = false;
			rightButton.gotoAndStop(2);
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