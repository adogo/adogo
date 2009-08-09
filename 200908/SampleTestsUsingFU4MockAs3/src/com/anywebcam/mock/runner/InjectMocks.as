package com.anywebcam.mock.runner
{
   import com.anywebcam.mock.Mockery;
   
   import flash.utils.Dictionary;
   
   import org.flexunit.internals.runners.statements.IAsyncStatement;
   import org.flexunit.token.AsyncTestToken;
   
   public class InjectMocks implements IAsyncStatement {
      private var mockery : Mockery;

      [ArrayElementType("Dictionary")]
      private var propertyNamesToInject : Array;
      
      private var target : Object;
      
      public function InjectMocks(mockery : Mockery, propertyNamesToInject : Array, target : Object) {
         this.mockery = mockery;
         this.propertyNamesToInject = propertyNamesToInject;
         this.target = target;
      }
      
      public function evaluate(parentToken : AsyncTestToken) : void {
         //find properties on target, inject using nice/strict and casting as klass
         for each(var property : Dictionary in propertyNamesToInject) {
            if(property["inject"]) {
               var mock : Object = null;
               
               if(property["type"] == "strict") {
                  mock = mockery.strict(property["klass"]);
               }
               else {
                  mock = mockery.nice(property["klass"]); 
               }
               
               target[property["name"]] = mock as property["klass"];
            }
         }
         
         parentToken.sendResult(null);
      }

   }
}