package view.component {
	import starling.display.Sprite;
	import starling.events.Event;

	public class StarlingScene extends Sprite {
		public function StarlingScene() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(e:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		protected function destroy(e:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
}
