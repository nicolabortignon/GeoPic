package com.nicolabortignon.geopic
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class userPanel extends MovieClip
	{
		public var userPanelContent:MovieClip;
		public var expandButton:MovieClip;
		public var usernameTextField:TextField;
		private var _userPanelYPosition:int = 25;
		private var _isUserPanelOpen:Boolean = false;
		private var _isLogged:Boolean = false;
		
		public function userPanel()
		{
			super();
			expandButton.buttonMode = true;
			expandButton.useHandCursor = true;
			expandButton.mouseChildren = false;
			expandButton.addEventListener(MouseEvent.CLICK, expandImpldePanel);
			this.visible = false;
			
		}
		
		public function login(username:String):void{
			_isLogged = true;
			usernameTextField.text = username;
			this.visible = true;
		}
		private function expandImpldePanel(e:MouseEvent):void{
			_userPanelYPosition
			if(_isLogged){
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
}