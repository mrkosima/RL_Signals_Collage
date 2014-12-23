/**
 * user: k.klimashevich
 */
package com.mrkosima.signals {
	import com.mrkosima.model.vo.CollageItemVO;

	import org.osflash.signals.Signal;

	public class CollageImageClickedSignal extends Signal {
		public function CollageImageClickedSignal() {
			super(CollageItemVO);
		}
	}
}
