package view.mediator {
	import flash.display.Stage;
	import flash.system.Capabilities;
	
	import model.StorageProxy;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	import view.component.StarlingStage;

	/**
	 * Starling Stage Mediator
	 */
	public class StarlingStageMediator extends Mediator {
		public static const NAME:String = "StarlingStageMediator";
		private var _starlingInstance:Starling;
		public function StarlingStageMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void{
			Starling.multitouchEnabled = true; // for Multitouch Scene
			Starling.handleLostContext = true; // required on Windows, needs more memory
			
			_starlingInstance = new Starling(StarlingStage, stage);
			_starlingInstance.simulateMultitouch = true;
			_starlingInstance.enableErrorChecking = Capabilities.isDebugger;
			_starlingInstance.start();
			
			_starlingInstance.addEventListener(Event.ROOT_CREATED, onStarlingCreatedHandler);
			
		}
		
		private function onStarlingCreatedHandler(e:Event):void{
			viewComponent = Starling.current.root as StarlingStage;
			
			storageProxy.readTest();	
		}
		
		public function get starlingStage():StarlingStage{
			return viewComponent as StarlingStage;
		}
		
		public function get stage():Stage{
			return viewComponent as Stage;
		}
		
		public function get storageProxy():StorageProxy{
			return facade.retrieveProxy(StorageProxy.NAME) as StorageProxy;
		}
		
	}
}
