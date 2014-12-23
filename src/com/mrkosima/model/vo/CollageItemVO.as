/**
 * user: k.klimashevich
 */
package com.mrkosima.model.vo {
	import flash.display.BitmapData;

	public class CollageItemVO {

		private var _url : String;

		private var _bitmapData : BitmapData;

		public function CollageItemVO(url : String, bitmapData : BitmapData) {
			_url = url;
			_bitmapData = bitmapData;
		}

		public function get url() : String {
			return _url;
		}

		public function get bitmapData() : BitmapData {
			return _bitmapData;
		}

	}
}
