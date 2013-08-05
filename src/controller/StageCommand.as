package controller {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import model.StageProxy;
	import model.StorageProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediator.StageMediator;

	public class StageCommand extends SimpleCommand {
		public function StageCommand() {
			super();
		}
		
		override public function execute($note:INotification):void{
			switch($note.getName()){
				case ApplicationNotification.START_UP:
					prepareProxy();
					
					var $stage:Stage = ($note.getBody() as DisplayObject).stage;
					facade.registerMediator(new StageMediator($stage));
					break;
			}
		}
		
		private function prepareProxy():void{
			facade.registerProxy(new StageProxy());
			facade.registerProxy(new StorageProxy());
		}
		
	}
}
