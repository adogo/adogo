package controller
{
	import com.maximporges.store.ProductGateway;
	import com.maximporges.store.ShoppingCart;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	
	/**
	 * Basic Controller wrapping the products list and cart. Also
	 * keeps track of the ProductGateway from the model, and uses
	 * it to fill the list of products exposed by this controller.
	 * 
	 * Clearly, clients of this Controller don't know (or care) about
	 * the ProductGateway, which makes refactoring it out later or 
	 * changing it a simple affair.
	 */
	public class CartController extends EventDispatcher
	{
		[Bindable]
		public var products : ArrayCollection;
		public var cart : ShoppingCart;

		private var _gateway : ProductGateway;
		
		public function CartController()
		{
			products = new ArrayCollection();
			cart = new ShoppingCart();
			_gateway = new ProductGateway();
			
			// Ask the gateway to fill the product collection that this object exposes. 
			_gateway.fillWithProducts(products);
		}
		
		/**
		 * This has not been implemented, but we can imagine that this method in
		 * its full implementation might be handed an OrderRequest as a parameter.
		 * This OrderRequest domain object might wrap CustomerInformation and
		 * PaymentInformation domain objects. In conjunction with the line items
		 * in the ShoppingCart, the Controller might pass all of this through to 
		 * an OrderProcessor object to actually handle validation, submission, and
		 * fulfillment of the order.
		 */  
		public function checkOut() : void
		{
			var message : String = "Running check out logic: " + cart.total;
			mx.controls.Alert.show(message);
		}
	}
}
