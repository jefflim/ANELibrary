package model {
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class StageProxy extends Proxy implements IProxy {
		public static const NAME:String = "StageProxy";
		public function StageProxy(data:Object = null) {
			super(NAME, data);
		}
		
		public function get stageWidth():uint{
			return Application.STAGE_WIDTH;
		}
		
		public function get stageHeight():uint{
			return Application.STAGE_HEIGHT;
		}
	}
}
