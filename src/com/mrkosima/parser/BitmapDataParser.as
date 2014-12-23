/**
 * user: k.klimashevich
 */
package com.mrkosima.parser {
	import com.mrkosima.model.vo.CollageItemVO;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class BitmapDataParser implements ICollageItemParser {

		public function parse(url : String, data : Object) : CollageItemVO {
			var bitmapData:BitmapData = data is BitmapData ? data as BitmapData : (data is Bitmap ? data.bitmapData : null);
			return new CollageItemVO(url, bitmapData);
		}
	}
}
