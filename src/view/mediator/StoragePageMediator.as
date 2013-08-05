package view.mediator {
	
	import model.StorageProxy;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.component.StoragePage;

	public class StoragePageMediator extends Mediator implements IMediator {
		public static const NAME:String = "StoragePageMediator";
		public function StoragePageMediator(viewComponent:StoragePage) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void{
			
		}
		
		override public function listNotificationInterests():Array{
			return [
				];
		}
		
		override public function handleNotification($note:INotification):void{
			
		}
		
		private function get storageProxy():StorageProxy{
			return facade.retrieveProxy(StorageProxy.NAME) as StorageProxy;
		}
		
	}
}
