package com.mrkosima {

	import com.mrkosima.view.components.CollageLayoutView;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Security;

	[SWF(width="800", height="600")]
	public class Collage extends Sprite {

		private var _galleyContext : CollageContext;

		public function Collage() {
			Security.allowDomain("lorempixel.com");
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		private function addedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			_galleyContext = new CollageContext(this);

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var collageLayout:CollageLayoutView = new CollageLayoutView();
			addChild(collageLayout);
		}
	}
}
