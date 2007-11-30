
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import flexunit.junit.JUnitTestRunner;
import mx.controls.Label;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property status (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'status' moved to '_892481550status'
	 */

    [Bindable(event="propertyChange")]
    public function get status():mx.controls.Label
    {
        return this._892481550status;
    }

    public function set status(value:mx.controls.Label):void
    {
    	var oldValue:Object = this._892481550status;
        if (oldValue !== value)
        {
			this._892481550status = value;
            dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "status", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property runner (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'runner' moved to '_919806160runner'
	 */

    [Bindable(event="propertyChange")]
    private function get runner():JUnitTestRunner
    {
        return this._919806160runner;
    }

    private function set runner(value:JUnitTestRunner):void
    {
    	var oldValue:Object = this._919806160runner;
        if (oldValue !== value)
        {
			this._919806160runner = value;
            dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "runner", oldValue, value));
        }
    }


}
