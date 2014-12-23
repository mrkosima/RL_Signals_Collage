/**
 * user: k.klimashevich
 */
package com.mrkosima.view.components {
	import com.greensock.TweenMax;
	import com.greensock.easing.SineInOut;
	import com.mrkosima.model.vo.CollageItemVO;
	import com.mrkosima.utils.CollageHelper;
	import com.mrkosima.utils.CollageHelper;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import org.osflash.signals.Signal;

	public class CollageLayoutView extends Sprite {

		private static const IMAGES_OVERLAP : Number = 10;

		public var imageRemoved : Signal;

		private var _imageVoMap : Dictionary;
		private var _images : Vector.<CollageImageView>;
		private var _preventLayout : Boolean;

		private var _resizeDelayCall : TweenMax;

		public function CollageLayoutView() {
			imageRemoved = new Signal();
			_imageVoMap = new Dictionary();
			_images = new <CollageImageView>[];
			_preventLayout = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		private function addedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
		}

		/**
		 * use TweenMax delay for update only after resize complete
		 * @param event
		 */
		private function stageResizeHandler(event : Event) : void {
			if (_resizeDelayCall) {
				_resizeDelayCall.kill();
			}
			_resizeDelayCall = TweenMax.delayedCall(1, updateLayout);
		}

		public function addImage(vo : CollageItemVO) : void {
			var image : CollageImageView = new CollageImageView(vo);
			image.x = stage.stageWidth / 2;
			image.y = stage.stageHeight / 2;
			_imageVoMap[vo] = image;
			_images.push(image);
			addChild(image);
			showImage(image);
			updateLayout();
		}

		public function removeImage(vo : CollageItemVO) : void {
			var image : CollageImageView = _imageVoMap[vo] as CollageImageView;
			if (image) {
				hideImage(image);
				delete _imageVoMap[vo];
				_images.splice(_images.indexOf(image), 1);
			}
		}

		public function set preventLayout(value : Boolean) : void {
			if (_preventLayout == value) {
				return;
			}
			_preventLayout = value;
			updateLayout();
		}

		private function showImage(image : CollageImageView) : void {
			image.alpha = 0;
			image.enabled = false;
			TweenMax.to(image, 0.5, {alpha : 1, rotation:CollageHelper.getRandomImageRotation(), onComplete : function () : void {
				image.enabled = true;
			}});
		}

		private function hideImage(image : CollageImageView) : void {
			image.enabled = false;
			TweenMax.to(image, 0.5, {alpha : 0, onComplete : imageHideComplete, onCompleteParams : [image]});
		}

		private function imageHideComplete(image : CollageImageView) : void {
			image.destroy();
			removeChild(image);
			imageRemoved.dispatch();
		}

		private function updateLayout() : void {
			if (_preventLayout) {
				return;
			}
			var stageWidth : Number = stage.stageWidth;
			var stageHeight : Number = stage.stageHeight;
			packImages(shuffledCopy(_images), new Rectangle(0, 0, stageWidth, stageHeight), stageWidth > stageHeight);
		}

		/**
		 * This is lightweight algorithm of binary tree packing.
		 * It can be improved by scaling images for fitting to it's "rectangle"
		 */
		private static function packImages(images : Vector.<CollageImageView>, rect : Rectangle, vertical : Boolean) : void {
			var imageView : CollageImageView;
			var imageCount : int = images.length;
			if (imageCount >= 2) {
				var images1 : Vector.<CollageImageView> = (new <CollageImageView>[]).concat(images);
				var images2 : Vector.<CollageImageView> = images1.splice(0, Math.floor(imageCount / 2));
				var totalSize1 : Number = 0;
				var totalSize2 : Number = 0;
				for each (imageView in images1) {
					totalSize1 += vertical ? imageView.dataWidth : imageView.dataHeight;
				}
				for each (imageView in images2) {
					totalSize2 += vertical ? imageView.dataHeight : imageView.dataWidth;
				}
				var ratio1 : Number = totalSize1 / (totalSize1 + totalSize2);
				var ratio2 : Number = totalSize2 / (totalSize1 + totalSize2);
				var newRect1 : Rectangle;
				var newRect2 : Rectangle;
				if (vertical) {
					newRect1 = CollageHelper.createExpandedRect(rect.x, rect.y, rect.width * ratio1, rect.height, IMAGES_OVERLAP);
					newRect2 = CollageHelper.createExpandedRect(rect.x + rect.width * ratio1, rect.y, rect.width * ratio2, rect.height, IMAGES_OVERLAP);
				} else {
					newRect1 = CollageHelper.createExpandedRect(rect.x, rect.y, rect.width, rect.height * ratio1, IMAGES_OVERLAP);
					newRect2 = CollageHelper.createExpandedRect(rect.x, rect.y + rect.height * ratio1, rect.width, rect.height * ratio2, IMAGES_OVERLAP);
				}
				packImages(images1, newRect1, !vertical);
				packImages(images2, newRect2, !vertical);

			} else if (images.length == 1) {
				imageView = images.pop();
				var targetX : Number = int(rect.x + rect.width / 2);
				var targetY : Number = int(rect.y + rect.height / 2);
				TweenMax.to(imageView, 1, {x : targetX, y : targetY, rotation : CollageHelper.getRandomImageRotation(), ease : SineInOut.ease});
			}
		}

		private static function shuffledCopy(images : Vector.<CollageImageView>) : Vector.<CollageImageView> {
			var copy : Vector.<CollageImageView> = (new <CollageImageView>[]).concat(images);
			copy.sort(CollageHelper.randomSortFunction);
			return copy;
		}

	}
}
