/**
 * user: k.klimashevich
 */
package com.mrkosima.parser {
	import com.mrkosima.model.vo.CollageItemVO;

	public interface ICollageItemParser {

		function parse(url:String, data:Object):CollageItemVO;
	}
}
