package com.maximporges.store
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	 
	/**
	 * Domain object representing the ShoppingCart. Handles all interactions with the
	 * LineItems and calculation of the total price. This shopping cart implementation
	 * is deliberately simplified to make it easy to demonstrate the principles
	 * associated with it. 
	 * 
	 * In an ideal scenario, both the "lineItems" and "total" member variables would be
	 * read-only by implementing them privately and exposing them through a get
	 * property function, but again, we're keeping it simple.  
	 */
	[Bindable]
	public class ShoppingCart
	{
		/**
		 * Publicly bindable lineItems collection. Views, Controllers, and Mediators might all be
		 * interested in binding to this, but this object doesn't care about them.
		 */
		public var lineItems : ArrayCollection = new ArrayCollection();
		
		/**
		 * Total amount of all the items in the cart. Also publicly exposed for
		 */
		public var total : Number = 0;
		
		/**
		 * Adds an item to the cart. This could result in either a new LineItem
		 * (if the product is not in the cart yet), or a change to the quantity
		 * of a particular item that is already in tne cart.
		 */
		public function addItemToCart(product : Product, quantity : Number = 1) : void
		{
			var lineItemInCart : LineItem = findLineItemInCart(product);
			if (lineItemInCart != null)
			{
				// There's already a LineItem for this Product. Increment product quantity.
				lineItemInCart.incrementQuantity(quantity);
			}
			else
			{
				// This product is not in the cart yet. Make a new LineItem for it.
				addLineItem(product, quantity);
			}

			commitLineItemChange();
		}
		
		/**
		 * Searches for a LineItem in the cart for a particular Product instance.
		 * For faster performance, we could implement a Dictionary mapping
		 * Product ids to LineItems as a cache, but this app is too simple
		 * in its present form to justify this. You could easily implement
		 * this later if you wanted to without affecting the rest of the app.
		 */ 
		private function findLineItemInCart(product : Product) : LineItem
		{
			var lineItem : LineItem = null;
			
			for (var i : int = 0; i < lineItems.length; i++)
			{
				var currentLineItem : LineItem = lineItems[i];
				if (currentLineItem.product.id == product.id)
				{
					lineItem = currentLineItem;
					break;
				}
			}
			
			return lineItem;
		}
		
		/**
		 * Add a new LineItem for a particular Product
		 */
		private function addLineItem(product : Product, quantity : Number):void
		{
			var lineItem : LineItem = new LineItem(product, quantity);
			lineItems.addItem(lineItem);
		}
		
		/**
		 * Commit a change to a LineItem (either a new Product addition or a quantity change).
		 * This is necessary since if we manipulated an item in the ArrayCollection (lineItems)
		 * without changing the collection itself (like we do when incrementing quantity), the
		 * binding change events will not fire. As a result, we specifically ask the lineItems
		 * collection to dispatch a CollectionEvent.COLLECTION_EVENT event to execute bindings
		 * on any observers.
		 * 
		 * Also in this method, we know that any change to the lineItems collection will affect
		 * the total, so we recalculate the total here.
		 */
		private function commitLineItemChange() : void
		{
			lineItems.dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE));
			total = recalculateTotal();
		}
		
		/**
		 * Iterates the LineItems and lets them tell the cart how much their
		 * sum total is.
		 * 
		 * Note that I prefer this sort of approach over pulling the data members 
		 * out of the LineItems and doing the math for multiplying the price and 
		 * quantity in this function. If you are going to have a domain object like
		 * LineItem it might as well do some work relative to its concerns.
		 */
		private function recalculateTotal() : Number
		{
			var newlyCalculatedTotal : Number = 0;
			for (var i : int = 0; i < lineItems.length; i++)
			{
				newlyCalculatedTotal += LineItem(lineItems[i]).lineItemTotal;
			}
			
			return newlyCalculatedTotal;
		}
		
		/**
		 * Very simple... removes a LineItem from the lineItems collection.
		 */
		public function removeLineItem(lineItem : LineItem) : void
		{
			lineItems.removeItemAt(lineItems.getItemIndex(lineItem));
			commitLineItemChange();
		}
	}
}