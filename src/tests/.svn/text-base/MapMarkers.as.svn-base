/*
* Licensed under the Apache License, Version 2.0 (the "License"):
*    http://www.apache.org/licenses/LICENSE-2.0
*/
package {
import flash.events.Event;
import flash.geom.Point;
import com.google.maps.MapEvent;
import com.google.maps.Map;
import com.google.maps.overlays.Marker;
import com.google.maps.MapType;
import com.google.maps.LatLng;
import com.google.maps.LatLngBounds;

public class MapMarkers extends Map {

  public function MapMarkers() {
    super();
	this.key = "abcd";
    addEventListener(MapEvent.MAP_READY, onMapReady);
  }

  private function onMapReady(event:MapEvent):void {
    setCenter(new LatLng(37.4419, -122.1419), 13, MapType.NORMAL_MAP_TYPE);

    var bounds:LatLngBounds = getLatLngBounds();
    var southWest:LatLng = bounds.getSouthWest();
    var northEast:LatLng = bounds.getNorthEast();
    var lngSpan:Number = northEast.lng() - southWest.lng();
    var latSpan:Number = northEast.lat() - southWest.lat();
    for (var i:int = 0; i < 10; i++) {
      var newLat:Number = southWest.lat() + (latSpan * Math.random());
      var newLng:Number = southWest.lng() + (lngSpan * Math.random());
      var latlng:LatLng = new LatLng(newLat, newLng);
      addOverlay(new Marker(latlng));
    }
  }
}
}