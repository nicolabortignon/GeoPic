package com.nicolabortignon.geopic
{
	
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quart;
	
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
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
		
		
		private var _retrivingRemote:Boolean;
		
		public const welcomeBackMessage:String = "Welcome Back, logging in and retrieving your informations";
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
			
			passwordTextfield.addEventListener(KeyboardEvent.KEY_DOWN,handler);
			usernameTextfield.addEventListener(KeyboardEvent.KEY_DOWN,handler);
		}
		
		function handler(event:KeyboardEvent){
			if(event.charCode == 13){
				startLogingIn();
			}
		}
		
		private function startLogingIn(e:MouseEvent = null):void{
			//	loaderLogin.visible = true;
			//	logoCappuccino.visible = false;
			if(_retrivingRemote == false){
				this.mouseChildren = false;
				TweenMax.to(loaderLogin,.5,{autoAlpha:1});
				TweenMax.to(logoCappuccino,.5,{autoAlpha:0});
				RemoteResourcesManager.getInstance().tryLoginRegister(usernameTextfield.text,MD5.hash(passwordTextfield.text), loginCallback);
				_retrivingRemote = true;
			}
		}
		
		private function loginCallback(o:Object):void{
			TweenMax.to(loaderLogin,.5,{autoAlpha:0});
			TweenMax.to(logoCappuccino,.5,{autoAlpha:1});
			
			var jsonResponse:Object = com.adobe.serialization.json.JSON.decode(o as String);
			trace(jsonResponse["code"]);
			outputMessage.text = jsonResponse["message"];
			
			if(jsonResponse["code"] == "correct"){
				TweenMax.to(this,1,{onComplete:hide});	
				SettingsManager.getInstance().username = usernameTextfield.text;
				SettingsManager.getInstance().password = passwordTextfield.text;
				SettingsManager.getInstance().saveData(); 
				
				ApplicationController.beginTutorial();
				
			} else {
				// there was an error UH!
				_retrivingRemote = false;	
			}
			this.mouseChildren = true;
			
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
		
		
		public function automaticLogin():void{
			outputMessage.text = welcomeBackMessage; 
			usernameTextfield.text = SettingsManager.getInstance().username;
			passwordTextfield.text = SettingsManager.getInstance().password;
			passwordTextfield.displayAsPassword = true;
			startLogingIn();
			
			
		}
		private function clickPasswordTextField(e:MouseEvent):void{
		}
		
		public function hide(){
			TweenMax.to(this,.5,{autoAlpha:0,ease:Quart.easeIn, y:(this.y+100)});
		}
		public function show(){
			var appIstance:ApplicationCapabilities = ApplicationCapabilities.getInstance();
			this.x = ((appIstance.mainWindowWidth - this.width) / 2);
			this.y = (appIstance.mainWindowHeight - this.height + 100) / 2;
			
			TweenMax.to(this,.5,{autoAlpha:1,ease:Quart.easeOut, y:(appIstance.mainWindowHeight - this.height)/ 2});
		}
	}
}