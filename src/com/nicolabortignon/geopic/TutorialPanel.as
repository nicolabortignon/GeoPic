package com.nicolabortignon.geopic
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class TutorialPanel extends MovieClip
	{
		public var rightButton:MovieClip;
		public var leftButton:MovieClip;
		public var currentPage:MovieClip;
		
		
		private const _totalPages:int = 5;
		private var _currentPage:int = 0; 
		public function TutorialPanel()
		{
		
			
			super();
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
		
			_currentPage = 0;
		
		}
		
		private function nextPage(e:MouseEvent):void{
			// move NEXT
			
		}
		
		private function previousPage(e:MouseEvent):void{
			
		}
	}
}