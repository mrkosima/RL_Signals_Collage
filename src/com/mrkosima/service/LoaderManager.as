/**
 * user: k.klimashevich
 */
package com.mrkosima.service {
	import com.mrkosima.parser.ICollageItemParser;
	import com.mrkosima.signals.AllItemsLoadedSignal;
	import com.mrkosima.signals.ItemLoadedSignal;

	public class LoaderManager {

		private static const MAX_CONNECTIONS : int = 2;

		[Inject]
		public var parser : ICollageItemParser;

		[Inject]
		public var itemLoaded : ItemLoadedSignal;

		[Inject]
		public var allItemsLoaded : AllItemsLoadedSignal;

		private var _pendingUrls : Array;
		private var _currentLoadings : int;

		public function LoaderManager() {
			initialize();
		}

		public function loadByUrl(urls : Array) : void {
			_pendingUrls = _pendingUrls.concat(urls);
			checkLoadAvailable();
		}

		private function initialize() : void {
			_pendingUrls = [];
			_currentLoadings = 0;
		}

		private function checkLoadAvailable() : void {
			if (_pendingUrls.length == 0 || _currentLoadings == MAX_CONNECTIONS) {
				return;
			}
			_currentLoadings++;
			var loaderService : LoaderService = new LoaderService();
			loaderService.loadedSignal.add(loaderComplete);
			loaderService.loadByUrl(_pendingUrls.shift());
			checkLoadAvailable();
		}

		public function loaderComplete(url : String, data : Object) : void {
			itemLoaded.dispatch(parser.parse(url, data));
			_currentLoadings--;
			if (_pendingUrls.length == 0 && _currentLoadings == 0) {
				allItemsLoaded.dispatch();
			}
			checkLoadAvailable();
		}

	}
}
