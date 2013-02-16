package roekensk.display.objects 
{
	import roekensk.utils.Math2;
	import roekensk.utils.StringUtils;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Information 
	{
		public var _name:String;
		public var _value:Object;
		public var _formattedValue:String;
		public var _units:String;
		
		public function Information(name:String,value:Object,units:String = "") 
		{
			this._name = name;
			this._value = value;
			this._units = units;
			
			if (StringUtils.isNumeric(""+this._value)) {
				var nr:Number = new Number(""+this._value);
				_formattedValue = ""+Math2.roundDecimal(nr,2);
			} else {
				_formattedValue = ""+nr;
			}
			_formattedValue += " " + this._units;
			
		}
		
		public function toString():String {
			return this._name + ": " + this._formattedValue;
		}
	}
	
}