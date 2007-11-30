
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.collections.ArrayCollection;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property domainCategories (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'domainCategories' moved to '_2073243136domainCategories'
	 */

    [Bindable(event="propertyChange")]
    public function get domainCategories():ArrayCollection
    {
        return this._2073243136domainCategories;
    }

    public function set domainCategories(value:ArrayCollection):void
    {
    	var oldValue:Object = this._2073243136domainCategories;
        if (oldValue !== value)
        {
			this._2073243136domainCategories = value;
            dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "domainCategories", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property domainTypes (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'domainTypes' moved to '_94301717domainTypes'
	 */

    [Bindable(event="propertyChange")]
    public function get domainTypes():ArrayCollection
    {
        return this._94301717domainTypes;
    }

    public function set domainTypes(value:ArrayCollection):void
    {
    	var oldValue:Object = this._94301717domainTypes;
        if (oldValue !== value)
        {
			this._94301717domainTypes = value;
            dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "domainTypes", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property typeTopics (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'typeTopics' moved to '_1398767362typeTopics'
	 */

    [Bindable(event="propertyChange")]
    public function get typeTopics():ArrayCollection
    {
        return this._1398767362typeTopics;
    }

    public function set typeTopics(value:ArrayCollection):void
    {
    	var oldValue:Object = this._1398767362typeTopics;
        if (oldValue !== value)
        {
			this._1398767362typeTopics = value;
            dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "typeTopics", oldValue, value));
        }
    }


}
