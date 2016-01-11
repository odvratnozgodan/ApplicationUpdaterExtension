/**
 * Created by revolucija on 25/11/15.
 */
package eu.amodo.extension {
	import eu.amodo.extension.events.ApplicationUpdaterEvent;

	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;

	public class ApplicationUpdaterExtension extends EventDispatcher {

		private var extContext:ExtensionContext;
		private static var _instance:ApplicationUpdaterExtension;

		private static var _isInitialized:Boolean = false;
		private static var _enabled:Boolean=false;
		private static var _suported:Boolean = true;
		private static var _iOSAppID:String = "";


		public function ApplicationUpdaterExtension(enforcer:SingletonEnforcer) {
			extContext = ExtensionContext.createExtensionContext( "eu.amodo.extensions.applicationupdater", null );

			if ( !extContext ) {
				throw new Error( "ApplicationUpdater native extension is not supported on this platform." );
			}

			extContext.addEventListener( StatusEvent.STATUS, onStatus );
		}

		//----------------------------------------
		//
		// Public methods
		//
		//----------------------------------------


		public static function get instance():ApplicationUpdaterExtension {
			if ( !_instance ) {
				_instance = new ApplicationUpdaterExtension( new SingletonEnforcer() );
				_instance.init();
			}
			return _instance;
		}

		public static function get enabled():Boolean
		{
			return _enabled;
		}

		public static function get isInitialized():Boolean{
			return _isInitialized;
		}

		public static function get suported():Boolean
		{
			return _suported;
		}

		public static function initialize():void{
			ApplicationUpdaterExtension.instance;
		}

		public static function dispose():void{
			ApplicationUpdaterExtension.instance.disposeExtension();
		}

		public static function checkForUpdate(requiredChecks:int = 5):void{
			ApplicationUpdaterExtension.instance.checkForUpdateExtension(requiredChecks);
		}

		public static function checkForUpdateDaily():void{
			ApplicationUpdaterExtension.instance.checkForUpdateDailyExtension();
		}

		public static function checkForUpdateWeekly():void{
			ApplicationUpdaterExtension.instance.checkForUpdateWeeklyExtension();
		}

		public static function get iOSAppID():String{
			return _iOSAppID;
		}

		public static function set iOSAppID(appID:String):void{
			_iOSAppID = appID;
		}

		//----------------------------------------
		//
		// Private methods
		//
		//----------------------------------------

		private function init():void {
			extContext.call( "init");
		}

		private function checkForUpdateExtension(requiredChecks:int = 5):void{
			if(Capabilities.manufacturer.indexOf("Android") != -1){
				extContext.call( "checkForUpdate", requiredChecks);
			}else{
				if(_iOSAppID != ""){
					extContext.call( "checkForUpdate", _iOSAppID);
				}else{
					throw new Error("To check for iOS update you have to set the iOSAppID");
				}
			}
		}

		private function checkForUpdateDailyExtension():void{
			if(Capabilities.manufacturer.indexOf("Android") != -1){
				throw new Error("This method can only be used on iOS.");
			}else{
				if(_iOSAppID != ""){
					extContext.call( "checkForUpdateDaily", _iOSAppID);
				}else{
					throw new Error("To set the update interval you have to set the iOSAppID");
				}
			}
		}

		private function checkForUpdateWeeklyExtension():void{
			if(Capabilities.manufacturer.indexOf("Android") != -1){
				throw new Error("This method can only be used on iOS.");
			}else{
				if(_iOSAppID != ""){
					extContext.call( "checkForUpdateWeekly", _iOSAppID);
				}else{
					throw new Error("To set the update interval you have to set the iOSAppID");
				}
			}
		}

		/**
		 * Cleans up the instance of the native extension.
		 */
		private function disposeExtension():void {
			extContext.call( "disposeExtension" );
			extContext.dispose();
			_isInitialized = false;
		}

		private function onStatus( event:StatusEvent ):void {
			if(event.code == "message"){
				message(event.level);
			}else if(event.code == "appReady"){
				appInitialized();
			}
		}

		private function message(str:String):void{
			var msgEvent:ApplicationUpdaterEvent = new ApplicationUpdaterEvent(ApplicationUpdaterEvent.MESSAGE);
			msgEvent.text = str;
			dispatchEvent(msgEvent);
		}

		private function appInitialized():void{
			_isInitialized = true;
			var initEvent:ApplicationUpdaterEvent = new ApplicationUpdaterEvent(ApplicationUpdaterEvent.INITIALIZED);
			initEvent.text = "Extension ready.";
			dispatchEvent(initEvent);
		}


	}
}

class SingletonEnforcer {

}