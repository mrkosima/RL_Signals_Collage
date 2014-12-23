/**
 * user: k.klimashevich
 */
package com.mrkosima.controller {
	import com.mrkosima.signals.LoadItemsSignal;
	import com.mrkosima.utils.CollageHelper;

	import org.robotlegs.mvcs.Command;

	public class GenerateItemCommand extends Command {

		[Inject]
		public var loadItems : LoadItemsSignal;

		override public function execute() : void {
			loadItems.dispatch([CollageHelper.generateImageUrl()]);
		}
	}
}
