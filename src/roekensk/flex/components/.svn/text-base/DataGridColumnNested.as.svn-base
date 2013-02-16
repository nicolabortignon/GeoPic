package roekensk.flex.components
{
  import mx.controls.dataGridClasses.DataGridColumn;

  public class DataGridColumnNested extends DataGridColumn
  {
    public function DataGridColumnNested(columnName:String=null)
    {
      super(columnName);
      this.sortable = false;
    }
    
    override public function itemToLabel(data:Object):String
    {
      var fields:Array;
      var attribute:String;
      var label:String;
      
      var dataFieldSplit:String = dataField;
      var currentData:Object = data;
      
      if(dataField.indexOf("@") != -1)
      {
        fields = dataFieldSplit.split("@");
        dataFieldSplit = fields[0];
        attribute = fields[1];
      }
      
      if(dataField.indexOf(".") != -1)
      { 
        fields = dataFieldSplit.split(".");
        
        for each(var f:String in fields)
          currentData = currentData[f];
         
        if(currentData is String)
          return String(currentData);
      }
      else
      {
        if(dataFieldSplit != "")
          currentData = currentData[dataFieldSplit];
      }
      
      if(attribute)
      {
        if(currentData is XML || currentData is XMLList)
          currentData = XML(currentData).attribute(attribute);
        else  
          currentData = currentData[attribute];
      }
      
      try
      {
        label = currentData.toString();
      }
      catch(e:Error)
      {
        label = super.itemToLabel(data);
      }
      
      return label;
    }
  }
}