
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;


class BindableProperty
    implements flash.events.IEventDispatcher
{
	/**
	 * generated bindable wrapper for property freebaseServiceManager (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'freebaseServiceManager' moved to '_783040555freebaseServiceManager'
	 */

    [Bindable(event="propertyChange")]
    public function get freebaseServiceManager():FreebaseServiceManager
    {
        return this._783040555freebaseServiceManager;
    }

    public function set freebaseServiceManager(value:FreebaseServiceManager):void
    {
    	var oldValue:Object = this._783040555freebaseServiceManager;
        if (oldValue !== value)
        {
			this._783040555freebaseServiceManager = value;
            dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "freebaseServiceManager", oldValue, value));
        }
    }


    //    IEventDispatcher implementation
    //
    private var _bindingEventDispatcher:flash.events.EventDispatcher =
        new flash.events.EventDispatcher(flash.events.IEventDispatcher(this));

    public function addEventListener(type:String, listener:Function,
                                     useCapture:Boolean = false,
                                     priority:int = 0,
                                     weakRef:Boolean = false):void
    {
        _bindingEventDispatcher.addEventListener(type, listener, useCapture,
                                                 priority, weakRef);
    }

    public function dispatchEvent(event:flash.events.Event):Boolean
    {
        return _bindingEventDispatcher.dispatchEvent(event);
    }

    public function hasEventListener(type:String):Boolean
    {
        return _bindingEventDispatcher.hasEventListener(type);
    }

    public function removeEventListener(type:String,
                                        listener:Function,
                                        useCapture:Boolean = false):void
    {
        _bindingEventDispatcher.removeEventListener(type, listener, useCapture);
    }

    public function willTrigger(type:String):Boolean
    {
        return _bindingEventDispatcher.willTrigger(type);
    }
}
