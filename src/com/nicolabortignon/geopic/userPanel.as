package com.nicolabortignon.geopic
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class userPanel extends MovieClip
	{
		public var userPanelContent:MovieClip;
		public var expandButton:MovieClip;
		private var _userPanelYPosition:int = 25;
		private var _isUserPanelOpen:Boolean = false;
		
		public function userPanel()
		{
			super();
			expandButton.buttonMode = true;
			expandButton.useHandCursor = true;
			expandButton.mouseChildren = false;
			expandButton.addEventListener(MouseEvent.CLICK, expandImpldePanel);
		}
		
		private function expandImpldePanel(e:MouseEvent):void{
			_userPanelYPosition
			
			if(_isUserPanelOpen){
				_isUserPanelOpen = false;
				expandButton.gotoAndStop(1);
				TweenMax.to(userPanelContent,.5,{y:_userPanelYPosition-userPanelContent.height});
			} else {
				expandButton.gotoAndStop(2);
				_isUserPanelOpen = true;
				TweenMax.to(userPanelContent,.5,{y:_userPanelYPosition});
			}
			
		}
	}
}