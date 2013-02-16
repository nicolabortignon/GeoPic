/*
* Licensed under the Apache License, Version 2.0 (the "License"):
*    http://www.apache.org/licenses/LICENSE-2.0
*/
package {
import com.google.maps.controls.ZoomControl;
import com.google.maps.overlays.Polygon;
import com.google.maps.overlays.PolygonOptions;
import com.google.maps.overlays.Polyline;
import com.google.maps.overlays.PolylineOptions;
import com.google.maps.styles.FillStyle;
import com.google.maps.styles.StrokeStyle;
import flash.events.Event;
import flash.text.TextField;
import flash.geom.Point;
import com.google.maps.MapEvent;
import com.google.maps.Map;
import com.google.maps.MapType;
import com.google.maps.LatLng;
import com.google.maps.InfoWindowOptions;

public class MapInfoWindow extends Map {

  public function MapInfoWindow() {
    super();
	this.key = "abcd";
    addEventListener(MapEvent.MAP_READY, onMapReady);
  }

  private function onMapReady(event:MapEvent):void {
    setCenter(new LatLng(37.4419, -122.1419), 13, MapType.NORMAL_MAP_TYPE);
    addControl(new ZoomControl());
    var latlng:LatLng = getCenter();
    var lat:Number = latlng.lat();
    var lon:Number = latlng.lng();
    var latOffset:Number = 0.01;
    var lonOffset:Number = 0.01;
    var polygon:Polygon = new Polygon([
      new LatLng(lat, lon - lonOffset),
      new LatLng(lat + latOffset, lon),
      new LatLng(lat, lon + lonOffset),
            new LatLng(lat - latOffset, lon),
            new LatLng(lat, lon - lonOffset)
      ], new PolygonOptions({ 
      strokeStyle: new StrokeStyle({
        color: 0x0000ff,
        thickness: 4,
        alpha: 0.7}), 
      fillStyle: new FillStyle({
        color: 0x0000ff,
        alpha: 0.7})
      }));
    addOverlay(polygon);
  }
  /*private function onMapReady(event:MapEvent):void {
  setCenter(new LatLng(37.4419, -122.1419), 13, MapType.NORMAL_MAP_TYPE);

  // Polyline overlay.
  var polyline:Polyline = new Polyline([
      new LatLng(37.4419, -122.1419),
      new LatLng(37.4519, -122.1519)
      ], new PolylineOptions({ strokeStyle: new StrokeStyle({
            color: 0xFF0000,
            thickness: 4,
            alpha: 0.7})
  }));
        
  addOverlay(polyline);
}*/
  /*private function onMapReady(event:MapEvent):void {
    setCenter(new LatLng(37.4419, -122.1419), 13, MapType.NORMAL_MAP_TYPE);
    openInfoWindow(getCenter(), new InfoWindowOptions({title: "Hello", content: "World"}));
  }*/}
}
