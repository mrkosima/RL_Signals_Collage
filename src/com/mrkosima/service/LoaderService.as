/**
 * user: k.klimashevich
 */
package com.mrkosima.service {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * Loader service: loads data by url
	 */
	public class LoaderService {

		private var _loadedSignal : Signal;
		private var _url : String;
		private var _loader : Loader;

		public function loadByUrl(url : String) : void {
			_url = url;
			load();
		}

		public function get loadedSignal() : ISignal {
			if (!_loadedSignal) {
				_loadedSignal = new Signal(Object);
			}
			return _loadedSignal;
		}

		private function load() : void {
			_loader = new Loader();
			addListeners();
			var lc : LoaderContext = new LoaderContext(true);
			lc.checkPolicyFile = true;
			_loader.load(new URLRequest(_url), lc);
		}

		private function addListeners() : void {
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}

		private function removeListeners() : void {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			_loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}

		private function errorHandler(event : Event) : void {
			removeListeners();
			dispatchComplete(null);
		}

		private function loadComplete(event : Event) : void {
			removeListeners();
			dispatchComplete((event.target as LoaderInfo).content);
		}

		private function dispatchComplete(data : Object) : void {
			_loadedSignal.dispatch(_url, data);
		}

	}
}
