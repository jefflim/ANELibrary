package view.component {
	
	import starling.events.Event;
	import starling.utils.AssetManager;
	

	public class StarlingStage extends StarlingScene {
		public static const NAME:String = "StarlingStage";
		public static const ASSETS_LOADED:String = NAME + "AssetsLoaded";
		private var _assetManager:AssetManager;

		public function StarlingStage() {
			super();
		}

		override protected function init(e:Event):void {
			super.init(e);
			trace("StarlingStage add to stage");
		}
		
	}
}
