/**
 * user: k.klimashevich
 */
package com.mrkosima.controller {
	import com.mrkosima.service.LoaderManager;

	import org.robotlegs.mvcs.Command;

	public class LoadItemsCommand extends Command {

		[Inject]
		public var items : Array;

		[Inject]
		public var loaderManager : LoaderManager;

		override public function execute() : void {
			loaderManager.loadByUrl(items);
		}
	}
}
