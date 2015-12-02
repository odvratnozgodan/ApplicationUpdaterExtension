package {


	import eu.amodo.extension.ApplicationUpdaterExtension;
	import eu.amodo.extension.events.ApplicationUpdaterEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	public class Main extends Sprite {

	private var _textField:TextField;

    public function Main() {
        _textField = new TextField();
        _textField.text = "Hello, World";
        addChild(_textField);

		Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT;

		addEventListener(Event.ADDED_TO_STAGE, addedToStage_Handler);
		addEventListener(TouchEvent.TOUCH_TAP, touchTap_Handler);

    }

	private function addedToStage_Handler(event:Event):void {
		ApplicationUpdaterExtension.instance.addEventListener(ApplicationUpdaterEvent.INITIALIZED, initialized_Handler);
		ApplicationUpdaterExtension.initialize();
		ApplicationUpdaterExtension.iOSAppID = "123456";
	}

	private function initialized_Handler(event:ApplicationUpdaterEvent):void {
		trace("initialized_Handler():", event.text);
		_textField.text += "\nExtension initialized";
	}

	private function touchTap_Handler(event:TouchEvent):void {
		trace("touchEnd_Handler()");
		trace("ApplicationUpdaterExtension.isInitialized:", ApplicationUpdaterExtension.isInitialized);
		if(ApplicationUpdaterExtension.isInitialized){
			ApplicationUpdaterExtension.checkForUpdate();
		}
	}
}
}
