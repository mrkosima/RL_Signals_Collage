/**
 * user: k.klimashevich
 */
package com.mrkosima.view.mediators {
	import com.mrkosima.model.CollageModel;
	import com.mrkosima.model.vo.CollageItemVO;
	import com.mrkosima.signals.CollagePreventLayoutSignal;
	import com.mrkosima.signals.CollageStartedSignal;
	import com.mrkosima.signals.ImageRemovedSignal;
	import com.mrkosima.signals.ItemAddedSignal;
	import com.mrkosima.signals.ItemRemovedSignal;
	import com.mrkosima.view.components.CollageLayoutView;

	import org.robotlegs.mvcs.Mediator;

	public class CollageLayoutMediator extends Mediator {

		[Inject]
		public var model : CollageModel;

		[Inject]
		public var itemAddedSignal : ItemAddedSignal;

		[Inject]
		public var itemRemovedSignal : ItemRemovedSignal;

		[Inject]
		public var imageRemovedSignal : ImageRemovedSignal;

		[Inject]
		public var collagePreventLayoutSignal:CollagePreventLayoutSignal;

		[Inject]
		public var collageStarted:CollageStartedSignal;

		[Inject]
		public var view : CollageLayoutView;

		override public function onRegister() : void {
			super.onRegister();
			view.imageRemoved.add(imageRemoved);
			itemAddedSignal.add(itemAdded);
			itemRemovedSignal.add(itemRemoved);
			collagePreventLayoutSignal.add(collagePreventLayout);
			collageStarted.dispatch();
		}

		private function itemAdded(item : CollageItemVO) : void {
			view.addImage(item);
		}

		private function itemRemoved(item : CollageItemVO) : void {
			view.removeImage(item);
		}

		private function imageRemoved() : void {
			imageRemovedSignal.dispatch();
		}

		private function collagePreventLayout(prevent : Boolean) : void {
			view.preventLayout = prevent;
		}
	}
}
