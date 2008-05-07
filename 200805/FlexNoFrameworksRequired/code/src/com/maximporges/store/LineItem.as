package com.maximporges.store
{
	/**
	 * Domain object representing a line item in the shopping cart. A line item is essentially
	 * a reference to a specific product and its quantity. Also contains sufficient business
	 * logic to calculate the line item total, and to modify the quantity of items by a set
	 * amount.
	 */  
	public class LineItem
	{
		public var product : Product;
		public var quantity : int;
		
		public function LineItem(lineItemProduct : Product, lineItemQuantity : int)
		{
			product = lineItemProduct;
			quantity = lineItemQuantity;
		}
		
		/**
		 * Accepts an integer amount by which to increase or decrease the line item quantity.
		 */
		public function incrementQuantity(additionalQuantity : int) : void
		{
			quantity += additionalQuantity;
		}
		
		/**
		 * Calculates the total price of the items in this LineItem. In a more sophisticated
		 * application, the LineItem might collaborate with a PricingStrategy object or similar
		 * to apply discounts on certain items or calculate price differently.
		 */ 
		public function get lineItemTotal() : Number
		{
			return (product.price * quantity);
		}
		
		public function get name() : String
		{
			return product.name;
		}
	}
}