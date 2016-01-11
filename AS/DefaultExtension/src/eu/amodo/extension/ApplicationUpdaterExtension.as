/**
 * Created by revolucija on 25/11/15.
 */
package eu.amodo.extension {
	import eu.amodo.extension.events.ApplicationUpdaterEvent;

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class ApplicationUpdaterExtension extends EventDispatcher {

		private var extContext:ExtensionContext;
		private static var _instance:ApplicationUpdaterExtension;

		private static var _isInitialized:Boolean = false;
		private static var _enabled:Boolean=false;
		private static var _suported:Boolean = true;

		public function ApplicationUpdaterExtension(enforcer:SingletonEnforcer) {
			//
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
			//
		}

		public static function dispose():void{
			//
		}

		public static function checkForUpdate(requiredChecks:Number = 5):void{

		}

		public static function checkForUpdateDaily():void{
			//
		}

		public static function checkForUpdateWeekly():void{
			//
		}

		public static function get iOSAppID():String{
			return "";
		}

		public static function set iOSAppID(appID:String):void{
			//
		}

		//----------------------------------------
		//
		// Private methods
		//
		//----------------------------------------

		private function init():void {
			//
		}

		private function checkForUpdateExtension(requiredChecks:Number = 5):void{
			//
		}

		private function checkForUpdateDailyExtension():void{
			//
		}

		private function checkForUpdateWeeklyExtension():void{
			//
		}

		/**
		 * Cleans up the instance of the native extension.
		 */
		private function disposeExtension():void {
			//
		}

		private function onStatus( event:StatusEvent ):void {
			//
		}

		private function message(str:String):void{
			//
		}

		private function appInitialized():void{
			//
		}


	}
}

class SingletonEnforcer {

}