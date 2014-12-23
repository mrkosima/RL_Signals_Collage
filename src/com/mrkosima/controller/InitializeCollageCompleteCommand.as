/**
 * user: k.klimashevich
 */
package com.mrkosima.controller {
	import com.mrkosima.signals.CollagePreventLayoutSignal;

	import org.robotlegs.mvcs.Command;

	public class InitializeCollageCompleteCommand extends Command {

		[Inject]
		public var preventUpdateLayout : CollagePreventLayoutSignal;

		override public function execute() : void {
			preventUpdateLayout.dispatch(false);
		}
	}
}
