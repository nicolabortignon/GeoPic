package roekensk.geo.objects
{
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class TimeStamp 
	{
		public var raw:String;
		
		public var zone:Number = 0;
		public var day:Number; // day of month
		public var month:Number;
		public var year:Number;
		public var hours:Number;
		public var minutes:Number;
		public var seconds:Number;
		
		public var totalSeconds:Number;
		
		public function TimeStamp(_raw:String) 
		{
			this.raw = _raw;
			splitToPieces();
		}
		public function splitToPieces():void {
			// example : 2008-09-19T06:28:11Z            //^\ d{4 } . { 1 }\ d{2 } . { 1 }\ d{2 } . { 1 }\ d{2 } . { 1 }\ d{2 } . { 1 }\ d{2 } . { 1 } $;
			var reg:RegExp = new RegExp("[^\d]");
			var dateTime:Array = raw.split("T");
			var date:Array = dateTime[0].split("-");
			var time:Array = dateTime[1].replace("Z","").split(":");
			
			year = parseInt(date[0]);
			
			month = parseInt(date[1]);
			day = parseInt(date[2]);
			hours = parseInt(time[0]);
			minutes = parseInt(time[1]);
			seconds = parseInt(time[2]);
			
			totalSeconds = (hours * 3600) + (minutes * 60) + seconds;
		}
		
	}
	
}