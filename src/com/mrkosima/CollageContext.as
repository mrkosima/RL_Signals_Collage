/**
 * user: k.klimashevich
 */
package com.mrkosima {
	import com.mrkosima.controller.AddItemCommand;
	import com.mrkosima.controller.GenerateItemCommand;
	import com.mrkosima.controller.InitializeCollageCommand;
	import com.mrkosima.controller.InitializeCollageCompleteCommand;
	import com.mrkosima.controller.LoadItemsCommand;
	import com.mrkosima.controller.RemoveItemCommand;
	import com.mrkosima.model.CollageModel;
	import com.mrkosima.parser.BitmapDataParser;
	import com.mrkosima.parser.ICollageItemParser;
	import com.mrkosima.service.LoaderManager;
	import com.mrkosima.signals.AllItemsLoadedSignal;
	import com.mrkosima.signals.CollageImageClickedSignal;
	import com.mrkosima.signals.CollagePreventLayoutSignal;
	import com.mrkosima.signals.CollageStartedSignal;
	import com.mrkosima.signals.ImageRemovedSignal;
	import com.mrkosima.signals.ItemAddedSignal;
	import com.mrkosima.signals.ItemLoadedSignal;
	import com.mrkosima.signals.ItemRemovedSignal;
	import com.mrkosima.signals.LoadItemsSignal;
	import com.mrkosima.view.components.CollageImageView;
	import com.mrkosima.view.components.CollageLayoutView;
	import com.mrkosima.view.mediators.CollageImageMediator;
	import com.mrkosima.view.mediators.CollageLayoutMediator;

	import flash.display.DisplayObjectContainer;

	import org.robotlegs.mvcs.SignalContext;

	public class CollageContext extends SignalContext {

		public function CollageContext(contextView : DisplayObjectContainer) {
			super(contextView);
		}

		override public function startup() : void {
			injector.mapSingleton(CollageModel);
			injector.mapSingleton(ItemAddedSignal);
			injector.mapSingleton(ItemRemovedSignal);
			injector.mapSingleton(CollagePreventLayoutSignal);

			signalCommandMap.mapSignalClass(LoadItemsSignal, LoadItemsCommand);
			signalCommandMap.mapSignalClass(ItemLoadedSignal, AddItemCommand);
			signalCommandMap.mapSignalClass(ImageRemovedSignal, GenerateItemCommand);
			signalCommandMap.mapSignalClass(CollageImageClickedSignal, RemoveItemCommand);
			signalCommandMap.mapSignalClass(AllItemsLoadedSignal, InitializeCollageCompleteCommand, true);
			injector.mapSingleton(LoaderManager);
			injector.mapSingletonOf(ICollageItemParser, BitmapDataParser);

			mediatorMap.mapView(CollageLayoutView, CollageLayoutMediator);
			mediatorMap.mapView(CollageImageView, CollageImageMediator);

			signalCommandMap.mapSignalClass(CollageStartedSignal, InitializeCollageCommand, true);
		}
	}
}
