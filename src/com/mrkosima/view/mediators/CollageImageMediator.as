/**
 * user: k.klimashevich
 */
package com.mrkosima.view.mediators {
	import com.mrkosima.model.vo.CollageItemVO;
	import com.mrkosima.signals.CollageImageClickedSignal;
	import com.mrkosima.view.components.CollageImageView;

	import org.robotlegs.mvcs.Mediator;

	public class CollageImageMediator extends Mediator {

		[Inject]
		public var view : CollageImageView;

		[Inject]
		public var collageClicked : CollageImageClickedSignal;

		override public function onRegister() : void {
			super.onRegister();
			view.clickedSignal.add(clicked);
		}

		private function clicked(vo : CollageItemVO) : void {
			collageClicked.dispatch(vo);
		}
	}
}
