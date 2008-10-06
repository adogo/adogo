package adogo.demos
{
	import mx.core.UIComponent;
	import mx.utils.StringUtil;

	public class DemonstrateUIComponentLifecycle extends UIComponent
	{
		public function DemonstrateUIComponentLifecycle()
		{
			super();
		}
			
		/**
		 * createChildren() Creates any child components of the component. For example, the ComboBox control contains
		 * a TextInput control and a Button control as child components.
		 * 
		 * For more information, see “Implementing the createChildren() method” on page 137.
		 */
		override protected function createChildren() : void
		{
			trace("DemonstrateUIComponentLifecycle.createChildren()");

			super.createChildren();
		}
		
		/**
		 * commitProperties() commits any changes to component properties, either to make the changes occur at the 
		 * same time or to ensure that properties are set in a specific order.
		 * 
		 * commitProperties() is usually called indirectly from setters that affect the visual display of a component,
		 * via a direct call to invalidateProperties() and invalidateDisplayList(). For example, if you set the value
		 * of a button label to a new value, the setter would call invalidateProperties() and invalidateDisplayList()
		 * to tell the Flex framework that (some time later, when Flex is ready to draw), please call my commitProperties()
		 * method so that I can act on the setting of my label.
		 * 
		 * The purpose of this is to make sure that if multiple setter calls come in to an object to set multiple properties
		 * that affect its layout, those changes will all be acted upon at once when commitProperties() is called. This
		 * optimizes the performance of the UIComponents.  
		 * 
		 * For more information, see “Implementing the commitProperties() method” on page 138.
		 */ 
		override protected function commitProperties() : void
		{
			trace("DemonstrateUIComponentLifecycle.commitProperties()");

			super.commitProperties();
		}
		
		/**
		 * measure() Sets the default size and default minimum size of the component.
		 * 
		 * Calls to invalidateSize() result in measure() being called when Flex is ready to draw. measure()
		 * sets the default size of the component; the parent of the UIComponent will eventually call updateDisplayList()
		 * with the actual width/height, which may be different from the default width and height.
		 * 
		 * As a result, measure() is a good place to set default widths/heights of the entire component. You would want to
		 * implement measure() if you have overriden a component (such as a subclass of Container) and have added some
		 * elements to the component that you know will affect its default sizing.  
		 * 
		 * For more information, see “Implementing the measure() method” on page 142.
		 */ 
		override protected function measure() : void
		{
			trace("DemonstrateUIComponentLifecycle.measure()");

			super.measure();
		}
		
		/**
		 * updateDisplayList() sizes and positions the children of the component on the screen based on all
		 * previous property and style settings, and draws any skins or graphic elements used by the component.
		 * The parent container for the component determines the size of the component itself, which it
		 * communicates to this component by passing in the unscaledWidth and unscaledHeight to this method.
		 * 
		 * For more information,see “Implementing the updateDisplayList() method” on page 146.
		 */
		override protected function updateDisplayList(unscaledWidth : Number, unscaledHeight : Number):void
		{
			trace(
				StringUtil.substitute(	"DemonstrateUIComponentLifecycle.updateDisplayList(unscaledWidth: {0}, unscaledHeight: {1})"
										, unscaledWidth
										, unscaledHeight)
			);			

			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
	}
}