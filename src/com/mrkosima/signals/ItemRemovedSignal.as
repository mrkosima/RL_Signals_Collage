/**
 * user: k.klimashevich
 */
package com.mrkosima.signals {
	import com.mrkosima.model.vo.CollageItemVO;

	import org.osflash.signals.Signal;

	public class ItemRemovedSignal extends Signal {

		public function ItemRemovedSignal() {
			super(CollageItemVO);
		}
	}
}
