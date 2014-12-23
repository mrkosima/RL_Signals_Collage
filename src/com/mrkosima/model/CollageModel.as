/**
 * user: k.klimashevich
 */
package com.mrkosima.model {
	import com.mrkosima.model.vo.CollageItemVO;
	import com.mrkosima.signals.ItemAddedSignal;
	import com.mrkosima.signals.ItemRemovedSignal;

	public class CollageModel {

		[Inject]
		public var itemAddedSignal : ItemAddedSignal;

		[Inject]
		public var itemRemovedSignal : ItemRemovedSignal;

		private var _items : Vector.<CollageItemVO>;

		public function CollageModel() {
			_items = new <CollageItemVO>[];
		}

		public function addItem(item : CollageItemVO) : void {
			_items.push(item);
			itemAddedSignal.dispatch(item);
		}

		public function removeItem(item : CollageItemVO) : void {
			var itemIndex : int = _items.indexOf(item);
			if (itemIndex >= 0) {
				_items.splice(itemIndex, 1);
				itemRemovedSignal.dispatch(item);
			}
		}
	}
}
