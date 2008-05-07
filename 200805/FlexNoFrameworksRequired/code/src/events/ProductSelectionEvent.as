package events
{
	import com.maximporges.store.Product;
	
	import flash.events.Event;

	/**
	 * Simple event that announces the selection of a product. Holds a reference
	 * to the Product that was selected.
	 */
	public class ProductSelectionEvent extends Event
	{
		public static const PRODUCT_DETAILS : String = "productSelection";
		
		public var product : Product;
		
		public function ProductSelectionEvent(productToDisplay : Product)
		{
			super(PRODUCT_DETAILS, false, false);
			product = productToDisplay;
		}
		
		override public function clone() : Event
		{
			return new ProductSelectionEvent(product);
		}
	}
}