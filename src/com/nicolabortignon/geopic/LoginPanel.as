package com.nicolabortignon.geopic
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.system.Capabilities;
	import flash.text.TextField;
	
	public class LoginPanel extends MovieClip
	{
		public var passwordTextField:TextField;
		public var usernameTextField:TextField;
		
		
		public function LoginPanel()
		{
			super();
			this.visible = false;
			this.alpha = 0;
			
			
		}
		
		public function show(){
			var appIstance:ApplicationCapabilities = ApplicationCapabilities.getInstance();
			this.x = ((appIstance.mainWindowWidth - this.width) / 2);
			this.y = (appIstance.mainWindowHeight - this.height + 100) / 2;
	 
			TweenMax.to(this,.6,{autoAlpha:1, y:(appIstance.mainWindowHeight - this.height)/ 2});
		}
	}
}