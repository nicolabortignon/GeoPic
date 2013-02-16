package tests 
{
	import alducente.services.WebService;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class RouteProfiler extends Sprite
	{
		public var ws:WebService;
		
		public var xml:XML = new XML( <route>
			  <point id="1" lat="61.8083953857422" lon="10.8497076034546" />
			  <point id="2" lat="61.9000000000000" lon="10.8600000000000" />
			  <point id="3" lat="61.9000000000000" lon="10.8800000000000" />
			</route>);
		
		public function RouteProfiler() 
		{
			/*ws = new WebService();
			ws.connect("http://bak.sprovoost.nl:8000/");
			
			ws.addEventListener(Event.CONNECT, onConnect);*/
			
			var request:URLRequest = new URLRequest("http://bak.sprovoost.nl:8000/");
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			
			var _vars:URLVariables = new URLVariables();
			_vars.test = xml;
			
			request.data = _vars;
			
			request.method = URLRequestMethod .POST;
			loader.addEventListener(Event.COMPLETE, handleComplete);
			
			loader.load(request);
			//loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		
		
		private function handleComplete(evt:Event):void
		{
			
			var caller:URLLoader = URLLoader(evt.target);
			trace(caller);
			var vars:URLVariables=new URLVariables(caller.data);
		}
		
		private function onIOError(evt:Event):void {
			
		}
		
		
		
		
		
		
		
		public function onConnect(e:Event):void {
			/*
			  <route>
  <point id="1" lat="61.8083953857422" lon="10.8497076034546" />
  <point id="2" lat="61.9000000000000" lon="10.8600000000000" />
  <point id="3" lat="61.9000000000000" lon="10.8800000000000" />
</route>
			 */
			
			ws.altitude_profile(getProfile,xml);
		}
		
		public function getProfile(serviceResponse:XML):void {
			trace("get");
			trace(serviceResponse);
			trace("end");
		}
		
	}
	
}