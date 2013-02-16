package {
/*
Query String Class. 
Creates a querystring object that reads the current url 
and parses params placing them into a param array easily accessible to actioinscript
*/
import flash.external.*;

class QueryString {
	//instance variables
	var _queryString:String;
	var _all:String;
	var _params:Object;
	
	public function QueryString() {
		readQueryString();
	}
	public function getQueryString():String {
		return _queryString;
	}
	public function getUrl():String {
		return _all;
	}
	public function getParameters():Object {
		return _params;
	}		

	private function readQueryString():void {
		_params = {};
		try  {
			_all = ExternalInterface.call("window.location.href.toString").toString();
			_queryString = ExternalInterface.call("window.location.search.substring", 1).toString();
			if(_queryString) {
				var allParams:Array = _queryString.split('&');
				//var length:uint = params.length;
				
				for (var i = 0, index = -1; i < allParams.length; i++) {
					var keyValuePair:String = allParams[i];
					if((index = keyValuePair.indexOf("=")) > 0) {
						var paramKey:String = keyValuePair.substring(0,index);
						var paramValue:String = keyValuePair.substring(index+1);
						_params[paramKey] = paramValue;
					}
				}
			}
		}
		catch(e:Error) { 
			trace("Some error occured. ExternalInterface doesn't work in Standalone player."); 
		}
	}
}

}