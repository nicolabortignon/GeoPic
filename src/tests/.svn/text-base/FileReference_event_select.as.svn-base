package tests {
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.FileReference;
    import flash.net.URLRequest;

    public class FileReference_event_select extends Sprite {
        private var uploadURL:URLRequest;
        private var file:FileReference;

        public function FileReference_event_select() {
            uploadURL = new URLRequest();
            uploadURL.url = "http://www.blabla.com/yourUploadHandlerScript.cfm";
            file = new FileReference();
            file.addEventListener(Event.SELECT, selectHandler);
            file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            file.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            file.addEventListener(Event.COMPLETE, completeHandler);
            file.browse();
        }

        private function selectHandler(event:Event):void {
            var file:FileReference = FileReference(event.target);
            trace("selectHandler: name=" + file.name + " URL=" + uploadURL.url);
            file.upload(uploadURL);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            var file:FileReference = FileReference(event.target);
            trace("progressHandler: name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }

        private function completeHandler(event:Event):void {
            trace("completeHandler: " + event);
        }
    }
}