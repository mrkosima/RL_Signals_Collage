/**
 * user: k.klimashevich
 */
package com.mrkosima.utils {
	import flash.geom.Rectangle;

	/**
	 * This is collage helper.
	 */
	public class CollageHelper {

		private static const IMAGE_URL_PREFIX : String = "http://lorempixel.com/";
		private static const MAX_ROTATION_ANGLE : Number = 15;

		private static const MAX_WIDTH : int = 400;
		private static const MIN_WIDTH : int = 200;

		private static const MAX_HEIGHT : int = 400;
		private static const MIN_HEIGHT : int = 200;

		public static function generateImageUrl() : String {
			return IMAGE_URL_PREFIX + generateIntInRange(MIN_WIDTH, MAX_WIDTH) + "/" + generateIntInRange(MIN_HEIGHT, MAX_HEIGHT) + "/";
		}

		private static function generateIntInRange(min : int, max : int) : int {
			return int(Math.random() * (max - min) + min);
		}

		/**
		 * Generates random angle in range [-MAX_ROTATION_ANGLE, MAX_ROTATION_ANGLE]
		 * @return angle
		 */
		public static function getRandomImageRotation() : Number {
			return (Math.random() - 0.5) * 2 * MAX_ROTATION_ANGLE;
		}

		/**
		 * Creates a rectangle instance with expanded size to every side
		 * @param x - rect x point
		 * @param y - rect y point
		 * @param width - rect width
		 * @param height - rect height
		 * @param size - size of expansion
		 * @return Rectangle instance
		 */
		public static function createExpandedRect(x : Number, y : Number, width : Number, height : Number, size : Number) : Rectangle {
			return new Rectangle(x - size, y - size, width + size * 2, height + size * 2);
		}

		/**
		 * Random sort function - for shuffling
		 */
		public static function randomSortFunction(a : Object, b : Object) : int {
			return Math.random() > 0.5 ? 1 : -1;
		}


	}
}
