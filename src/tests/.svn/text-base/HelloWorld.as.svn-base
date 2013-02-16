package {

import flash.events.Event;
import com.google.maps.Map;
import com.google.maps.MapEvent;
import com.google.maps.MapType;
import com.google.maps.LatLng;

public class HelloWorld extends Map {

  public function HelloWorld() {
    super();
	this.key = "ABQIAAAAUZob4Z3xY1adEWLD1eY09BR5SNmuor0qfzJxINiU_8LcmlgcAxQQhBhsniTZMe63ExYOEgXKhRfa5Q";

    addEventListener(MapEvent.MAP_READY, onMapReady);
  }

  private function onMapReady(event:MapEvent):void {
    setCenter(new LatLng(40.736072,-73.992062), 14, MapType.NORMAL_MAP_TYPE);
  }
}

}