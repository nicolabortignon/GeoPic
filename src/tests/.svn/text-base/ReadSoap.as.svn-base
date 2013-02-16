package tests 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class ReadSoap extends Sprite
	{
		public var xmlLoader:URLLoader = new URLLoader();
		public function ReadSoap() 
		{
			xmlLoader.addEventListener(Event.COMPLETE, loadSoap);
			xmlLoader.load(new URLRequest("tests/soap.xml"));
		}
		
		public function loadSoap(e:Event):void {
			var content:XML = new XML(e.target.data);
			
			var soap:Namespace = content.namespace();
	
			var b:XML = new XML(content.soap::Body[0]);
			
			var serv:Namespace = new Namespace("http://gisdata.usgs.gov/XMLWebServices2/");
			
			b = new XML(b.serv::getElevationResponse[0].serv::getElevationResult[0].serv::USGS_Elevation_Web_Service_Query.serv::Elevation_Query);
			trace(b.serv::Elevation);
			
		}
	}
	
}