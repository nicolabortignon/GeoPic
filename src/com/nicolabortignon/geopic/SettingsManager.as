package com.nicolabortignon.geopic
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	
	public class SettingsManager
	{
		private static var instance:SettingsManager;
		private static var allowInstantiation:Boolean;
		
		public var settingFile:File = File.applicationStorageDirectory.resolvePath("settings.xml");
		public var username:String;
		public var password:String;
		
		
		public function SettingsManager():void {
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}			
			//deleteSettings();
		}
		
		
	
		public static function getInstance():SettingsManager {
			if (instance == null) {
				allowInstantiation = true;
				instance = new SettingsManager();
				allowInstantiation = false;
			}
			return instance;
		}
		
		public function loadData():void{
			var fileStream:FileStream = new FileStream();
			fileStream.open(settingFile, FileMode.READ); 
			var prefsXML:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			
			username =  prefsXML.username;
			password =  prefsXML.password;
		}
		
		public function loadCredentials():Boolean{
			if(!settingFile.exists)
				return false;
			
			loadData();
			return true;
			
			
		}
		
		public function saveData():void{
			var fileStream:FileStream = new FileStream();  
			fileStream.open(settingFile, FileMode.WRITE);
			fileStream.writeUTFBytes(exportData());
			fileStream.close();
		}
		
		public function exportData():XML{
			var s:String  = "<settings>";
			s+= "<username>"+username+"</username>";
			s+= "<password>"+password+"</password>";
			s += "</settings>";			
			var xml:XML = new XML(s);
			if(ApplicationCapabilities.getInstance().debugMode) trace(xml);
			return xml;
		}
		
		public function importData(xml:XML):void{
			trace(xml);
		}
		
		public function deleteSettings():void{
			if(settingFile.exists)
			settingFile.deleteFile();
		}
		
	}
}