package view.mediator {
	import flash.display.Stage;
	
	
	import model.StageProxy;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * Flash Stage Mediator
	 */
	public class StageMediator extends Mediator {
		public static const NAME:String = "StageMediator";
		public function StageMediator(viewComponent:Stage) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void{
			// START PAGE HERE
			facade.registerMediator(new StarlingStageMediator(stage));
		}
		
		
		public function get stage():Stage{
			return viewComponent as Stage;
		}
		
		public function get stageProxy():StageProxy{
			return facade.retrieveProxy(StageProxy.NAME) as StageProxy;
		}
	}
}
