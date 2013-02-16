package tests 
{
	import alducente.services.WebService;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class WebServicesTest extends Sprite
	{
		
		private var ws:WebService = new WebService();
		
		public function WebServicesTest() 
		{
			
			trace("test");
			ws.addEventListener(Event.CONNECT, onConnect);
			
			ws.connect("http://gisdata.usgs.gov/XmlWebServices/TNM_Elevation_service.asmx?WSDL");
			
			
			//elevation_service.asmx/getElevation?X_Value="+lng+"&Y_Value="+lat+"&Elevation_Units=meters&Source_Layer=-1&Elevation_Only=1
		}
		
		public function onConnect(e:Event):void {
			trace("connect");
			ws.getElevation(done,"4.522445","50.810392","meters",-1,1);
		}
		
		/*
		 <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <soap:Body>
    <getElevationResponse xmlns="http://gisdata.usgs.gov/XMLWebServices2/">
      <getElevationResult>
        <USGS_Elevation_Web_Service_Query>
          <Elevation_Query x="4.522445" y="50.810392">
            <Data_Source>SRTM.C_1TO19_3</Data_Source>
            <Data_ID>SRTM.C_1TO19_3</Data_ID>
            <Elevation>99</Elevation>
            <Units>METERS</Units>
          </Elevation_Query>
        </USGS_Elevation_Web_Service_Query>
      </getElevationResult>
    </getElevationResponse>
  </soap:Body>
</soap:Envelope>
		
		*/
		public function done(serviceResponse:XML):void {
			var soap:Namespace = serviceResponse.namespace();
	
			var b:XML = new XML(serviceResponse.soap::Body[0]);
			
			var serv:Namespace = new Namespace("http://gisdata.usgs.gov/XMLWebServices2/");
			
			//b = new XML(b.serv::getElevationResponse[0].serv::getElevationResult[0]);
			
			trace(b.serv::getElevationResponse[0].serv::getElevationResult[0].USGS_Elevation_Web_Service_Query.Elevation_Query.Elevation);
			//.serv::getElevationResult[0].serv::USGS_Elevation_Web_Service_Query.serv::Elevation_Query);
			//trace("elevation: "+b.serv::Elevation);
			
			trace("fini");
		}
	}
	/*
	 <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <soap:Body>
    <GetUserResponse xmlns="http://tempuri.org/">
      <GetUserResult>&lt;ROOT&gt;&lt;User&gt;&lt;LastName&gt;Illeperuma&lt;/LastName&gt;&lt;FirstName&gt;Parakrama&lt;/FirstName&gt;&lt;Email&gt;parakramai@live.com&lt;/Email&gt;&lt;Language&gt;EN&lt;/Language&gt;&lt;OptIn&gt;&lt;/OptIn&gt;&lt;Price1&gt;2&lt;/Price1&gt;&lt;Price2&gt;4&lt;/Price2&gt;&lt;Price3&gt;1&lt;/Price3&gt;&lt;/User&gt;&lt;/ROOT&gt;</GetUserResult>
    </GetUserResponse>
  </soap:Body>
</soap:Envelope>

function done(serviceResponse:XML):void {
	var soap:Namespace = serviceResponse.namespace();
	var body:XML = serviceResponse.soap::Body[0];
	
	var resNameSpace:Namespace = new Namespace("http://tempuri.org/");
	var result:XML = body.resNameSpace::GetUserResponse[0];
	var resultData:String = result.children()[0].toString();
	var xmldata:XML = XML(resultData);
	
	trace("LastName: "+xmldata..LastName)
}

	
	
	*/
}