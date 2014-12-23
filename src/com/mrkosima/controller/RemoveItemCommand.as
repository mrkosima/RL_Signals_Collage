/**
 * user: k.klimashevich
 */
package com.mrkosima.controller {
	import com.mrkosima.model.CollageModel;
	import com.mrkosima.model.vo.CollageItemVO;

	import org.robotlegs.mvcs.Command;

	public class RemoveItemCommand extends Command {

		[Inject]
		public var collageItem : CollageItemVO;

		[Inject]
		public var model : CollageModel;

		override public function execute() : void {
			model.removeItem(collageItem);
		}
	}
}
