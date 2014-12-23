/**
 * user: k.klimashevich
 */
package com.mrkosima.controller {
	import com.mrkosima.signals.CollagePreventLayoutSignal;
	import com.mrkosima.signals.LoadItemsSignal;
	import com.mrkosima.utils.CollageHelper;

	import org.robotlegs.mvcs.Command;

	public class InitializeCollageCommand extends Command {

		[Inject]
		public var loadItems : LoadItemsSignal;

		[Inject]
		public var preventUpdateLayout : CollagePreventLayoutSignal;

		override public function execute() : void {
			preventUpdateLayout.dispatch(true);
			var arr : Array = [];
			for (var i : int = 0; i < 20; i++) {
				arr.push(CollageHelper.generateImageUrl());
			}
			loadItems.dispatch(arr);
		}
	}
}
