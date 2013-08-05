package {
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class ANELibrary extends Application {
		public function ANELibrary() {
			super();

			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		override protected function init(e:Event):void{
			super.init(e);
			ApplicationFacade.getInstance().startup(this);
		}
	}
}
