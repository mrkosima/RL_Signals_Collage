/**
 * user: k.klimashevich
 */
package com.mrkosima.signals {
	import com.mrkosima.model.vo.CollageItemVO;

	import org.osflash.signals.Signal;

	public class ItemLoadedSignal extends Signal {

		public function ItemLoadedSignal() {
			super(CollageItemVO);
		}

	}
}
