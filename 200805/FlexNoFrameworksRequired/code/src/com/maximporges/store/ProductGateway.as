package com.maximporges.store
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	/**
	 * Gateway wrapping all service interactions and data conversions for Products.
	 * 
	 * The gateway (similar to a DAO) has thorough understanding of the back end 
	 * service implementation, knowing how to invoke it and receive results. 
	 * When results are received, it knows how to unmarshal them in to domain
	 * objects (in this case Products) to return to any code that might
	 * invoke the gateway's operations.
	 */
	public class ProductGateway
	{
		private var _productService : HTTPService;
		
		/**
		 * Constructor instantiates the local service reference and sets
		 * the expected result format.
		 */
		public function ProductGateway()
		{
			_productService = new HTTPService();
			_productService.url = "product-data.xml";
			_productService.resultFormat = "e4x";
		}
		
		/**
		 * Client code invokes this method, passing in an ArrayCollection. The
		 * ArrayCollection is then filled with Products at some point in the
		 * future when the service calls behind the gateway complete.
		 */
		public function fillWithProducts(collectionToFillWithResult : ArrayCollection) : void
		{
			var token : AsyncToken = _productService.send();
			
			// Hold on to a reference to the collection that the caller wants filled with
			// Products, and register this gateway as the responder to all service calls.
			token.collectionToFillWithResult = collectionToFillWithResult;
			token.addResponder(new AsyncResponder(result, fault, token));
		}
		
		/**
		 * Simple private method for unmarshalling XML in to Product objects.
		 */
		private function xmlToProduct(xml : XML) : Product
		{
			var product : Product = new Product();
			product.id = xml.@id;
			product.description = xml.description;
			product.image = xml.image;
			product.name = xml.name;
			product.price = xml.price;
			product.thumbnail = xml.thumbnail;

			return product;
		}
		
		/**
		 * Result handler for calls to load product data from the remote service tier.
		 * Simply iterates the result XML and fills the appropriate collection reference
		 * (stored in the token during the call to fillWithProducts)
		 */
		public function result(event : ResultEvent, token : AsyncToken) : void
		{
			// Retrieve the collection reference associated with this call from the AsyncToken 
			var collectionToFillWithResult : ArrayCollection = token.collectionToFillWithResult;
			
			// Convert XML to domain objects by iterating the XML and using a helper function.
			var response : XML = event.result as XML;
			for each (var productNode : XML in response.product)
			{
				collectionToFillWithResult.addItem(xmlToProduct(productNode));
			}
		}
		
		/**
		 * Completely useless fault handler. You'd obviously do something more appropriate
		 * in a production app, such as log the error or attempt to report it to somebody
		 * who can fix it.
		 */
		public function fault(event : FaultEvent, token : AsyncToken) : void
		{
			Alert.show("fault: " + event.fault.message);
		}
	}
}