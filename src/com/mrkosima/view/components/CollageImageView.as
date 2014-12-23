/**
 * user: k.klimashevich
 */
package com.mrkosima.view.components {
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import com.mrkosima.model.vo.CollageItemVO;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class CollageImageView extends Sprite {

		private static const BORDER_SIZE : int = 10;

		private var _centeredContainer : Sprite;
		private var _image : Bitmap;

		private var _vo : CollageItemVO;

		private var _clickedSignal : Signal;

		private var _mouseOver : Boolean;

		private var _enabled : Boolean;

		public function CollageImageView(vo : CollageItemVO) {
			_vo = vo;
			initialize();
		}

		private function initialize() : void {
			_centeredContainer = new Sprite();
			addChild(_centeredContainer);

			drawGraphicsRect(0x727272, 0);
			drawGraphicsRect(0xeeeeee, 1);

			_image = new Bitmap();
			_centeredContainer.addChild(_image);
			_image.x = _image.y = BORDER_SIZE;
			_image.bitmapData = _vo.bitmapData;

			_centeredContainer.x = -_centeredContainer.width / 2;
			_centeredContainer.y = -_centeredContainer.height / 2;
			_image.alpha = 0.9;
			scaleX = scaleY = 0.95;
			_enabled = true;
		}

		public function get clickedSignal() : ISignal {
			if (!_clickedSignal) {
				_clickedSignal = new Signal();
			}
			return _clickedSignal;
		}

		private function mouseClickHandler(event : MouseEvent) : void {
			clickedSignal.dispatch(_vo);
		}

		private function drawGraphicsRect(color : uint, padding : int) : void {
			if (padding > BORDER_SIZE) {
				return;
			}
			_centeredContainer.graphics.beginFill(color);
			_centeredContainer.graphics.drawRect(padding, padding, _vo.bitmapData.width + (BORDER_SIZE - padding) * 2, _vo.bitmapData.height + (BORDER_SIZE - padding) * 2);
			_centeredContainer.graphics.endFill();
		}

		private function mouseOverHandlerHandler(event : MouseEvent) : void {
			mouseOver = event.type == MouseEvent.ROLL_OVER;
		}

		public function get dataWidth() : Number {
			return _vo.bitmapData.width;
		}

		public function get dataHeight() : Number {
			return _vo.bitmapData.height;
		}

		private function set mouseOver(value : Boolean) : void {
			if (_mouseOver == value) {
				return;
			}
			_mouseOver = value;
			updateOverState();
		}

		private function updateOverState() : void {
			TweenMax.killTweensOf(this);
			if (_mouseOver) {
				TweenMax.to(this, 0.5, {scaleX : 1, scaleY : 1, ease : Sine.easeOut});
				TweenMax.to(_image, 0.5, {alpha : 1, ease : Sine.easeOut});
			} else {
				TweenMax.to(this, 0.5, {scaleX : 0.95, scaleY : 0.95, ease : Sine.easeIn});
				TweenMax.to(_image, 0.5, {alpha : 0.9, ease : Sine.easeIn});
			}
		}

		public function set enabled(value : Boolean) : void {
			if (_enabled == value) {
				return;
			}
			_enabled = value;
			if (_enabled) {
				addListeners();
			} else {
				removeListeners();
			}
		}

		private function addListeners() : void {
			addEventListener(MouseEvent.ROLL_OVER, mouseOverHandlerHandler);
			addEventListener(MouseEvent.ROLL_OUT, mouseOverHandlerHandler);
			addEventListener(MouseEvent.CLICK, mouseClickHandler);
		}

		private function removeListeners() : void {
			removeEventListener(MouseEvent.ROLL_OVER, mouseOverHandlerHandler);
			removeEventListener(MouseEvent.ROLL_OUT, mouseOverHandlerHandler);
			removeEventListener(MouseEvent.CLICK, mouseClickHandler);
		}

		public function destroy() : void {
			TweenMax.killTweensOf(this);
			removeListeners();
			_image = null;
		}
	}
}
