/**
 * user: k.klimashevich
 */
package com.mrkosima.signals {
	import com.mrkosima.model.vo.CollageItemVO;

	import org.osflash.signals.Signal;

	public class ItemAddedSignal extends Signal {

		public function ItemAddedSignal() {
			super(CollageItemVO);
		}
	}
}
