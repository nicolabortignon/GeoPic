package roekensk.geo.webservices 
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class XmlLoaderService extends EventDispatcher
	{
		
		public function XmlLoaderService(path:String) 
		{
			try {
				var xmlLoader:URLLoader = new URLLoader();
				
				xmlLoader.addEventListener(Event.COMPLETE, onLoad);
				xmlLoader.load(new URLRequest(path));
			} catch (e:IOError) {
				trace(e.message);
			}
		}
		
		private function onLoad(e:Event):void {
			var _content:XML = new XML(e.target.data);
			
			filterData(_content);
			
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function filterData(content:XML):void {
			
		}
	}
	
}