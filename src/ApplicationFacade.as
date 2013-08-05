package {
	import flash.display.DisplayObject;
	
	import controller.StartupCommand;
	
	import org.puremvc.as3.patterns.facade.Facade;

	public class ApplicationFacade extends Facade {
		private static var _instance:ApplicationFacade;

		public function ApplicationFacade() {
			super();
		}

		override protected function initializeController():void{
			super.initializeController();
			registerCommand(ApplicationNotification.START_UP, StartupCommand);
		}
		
		public static function getInstance():ApplicationFacade {
			return _instance ? _instance : new ApplicationFacade();
		}

		public function startup($app:DisplayObject):void {
			sendNotification(ApplicationNotification.START_UP, $app);
		}
	}
}
