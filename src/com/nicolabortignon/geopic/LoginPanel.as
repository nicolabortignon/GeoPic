package com.nicolabortignon.geopic
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Quart;
	
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	
	public class LoginPanel extends MovieClip
	{
		public var passwordTextfield:TextField;
		public var usernameTextfield:TextField;
		public var startButton:MovieClip;
		public var logoCappuccino:MovieClip;
		public var loaderLogin:MovieClip;
		public var outputMessage:TextField;
		
		
		public const emailString:String = "email";
		public const passwordString:String = "password";
		
		public function LoginPanel()
		{
			super();
			this.visible = false;
			this.alpha = 0;
			loaderLogin.visible = false;
			
			startButton.buttonMode = true
			startButton.useHandCursor = true;
			startButton.mouseChildren = false;
			usernameTextfield.text= emailString;
			passwordTextfield.text = passwordString;
			
			
			usernameTextfield.addEventListener(MouseEvent.CLICK, clickUsernameTextField);
			usernameTextfield.addEventListener(FocusEvent.FOCUS_IN, selectUsernameTextField);
			usernameTextfield.addEventListener(FocusEvent.FOCUS_OUT, deselectUsernameTextField);
			
			passwordTextfield.addEventListener(MouseEvent.CLICK, clickPasswordTextField);
			passwordTextfield.addEventListener(FocusEvent.FOCUS_IN, selectPasswordTextField);
			passwordTextfield.addEventListener(FocusEvent.FOCUS_OUT, deselectPasswordTextField);
			
			
			startButton.addEventListener(MouseEvent.CLICK, startLogingIn);
		}
		
		private function startLogingIn(e:MouseEvent):void{
		//	loaderLogin.visible = true;
		//	logoCappuccino.visible = false;
			
			TweenMax.to(loaderLogin,.5,{autoAlpha:1});
			TweenMax.to(logoCappuccino,.5,{autoAlpha:0});
		}
	
		private function selectUsernameTextField(e:FocusEvent) {
			if(usernameTextfield.text == emailString){
				usernameTextfield.text = "";
			} else {
				e.target.setSelection(0, e.target.getLineLength(0));
			}
		}
		private function deselectUsernameTextField(e:FocusEvent) {
			if(usernameTextfield.text == "")
				usernameTextfield.text = emailString;
		}
		 
		private function clickUsernameTextField(e:MouseEvent):void{
			 
		}
		 
		 
		 private function selectPasswordTextField(e:FocusEvent) {
			 if(passwordTextfield.text == passwordString){
				 passwordTextfield.text = "";
				 passwordTextfield.displayAsPassword = true; 
			 } else {
				 e.target.setSelection(0, e.target.getLineLength(0));
			 }
		 }
		 private function deselectPasswordTextField(e:FocusEvent) {
			 if(passwordTextfield.text == ""){
				 passwordTextfield.text = passwordString;
				 passwordTextfield.displayAsPassword = false; 
			 }
		 }
		 
		 private function clickPasswordTextField(e:MouseEvent):void{
			 
		 }
		
		
		public function show(){
			outputMessage.text = "";
			var appIstance:ApplicationCapabilities = ApplicationCapabilities.getInstance();
			this.x = ((appIstance.mainWindowWidth - this.width) / 2);
			this.y = (appIstance.mainWindowHeight - this.height + 100) / 2;
	 
			TweenMax.to(this,.5,{autoAlpha:1,ease:Quart.easeOut, y:(appIstance.mainWindowHeight - this.height)/ 2});
		}
	}
}