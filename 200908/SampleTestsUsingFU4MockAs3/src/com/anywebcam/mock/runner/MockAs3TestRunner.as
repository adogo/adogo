package com.anywebcam.mock.runner
{
   import com.anywebcam.mock.Mockery;
   
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   import flex.lang.reflect.Field;
   import flex.lang.reflect.Klass;
   
   import org.flexunit.internals.runners.InitializationError;
   import org.flexunit.internals.runners.statements.Fail;
   import org.flexunit.internals.runners.statements.IAsyncStatement;
   import org.flexunit.internals.runners.statements.StatementSequencer;
   import org.flexunit.runner.notification.IRunNotifier;
   import org.flexunit.runners.BlockFlexUnit4ClassRunner;
   import org.flexunit.runners.model.FrameworkMethod;
   
   public class MockAs3TestRunner extends BlockFlexUnit4ClassRunner
   {
      private var mockery : Mockery;
      private var mockeryFieldName : String;
            
      [ArrayElementType("Dictionary")]
      private var propertyNamesToInject : Array = [];
      
      public function MockAs3TestRunner(testClass : Class)
		{
			super(testClass);
			
			this.mockery = new Mockery();
			this.mockeryFieldName = findMockeryField(testClass);
			this.propertyNamesToInject = findMocksToPrepareAndInject(testClass);
		}

      /**
       * Used to find the field name of the property of type mockery 
       */
      private function findMockeryField(testClass : Class) : String {
         //need to check for feild of type com.anywebcam.mock.Mockery
         var klass : Klass = new Klass(testClass);
         var mockeries : Array = klass.fields.filter(function (field : Field, index : int, source : Array) : Boolean {
               return field.type == Mockery;
            });
         
         //if none or more than 1, throw InitializationError
         if(mockeries.length != 1) {
            throw new InitializationError("Test class must have ONE property of type com.anywebcam.mock.Mockery!");
         }
         
         return mockeries[0].name;
      }
      
      /**
       * Builds a configuration for all injectable properties 
       */
      private function findMocksToPrepareAndInject(testClass : Class) : Array {
         //build config maps in propertyNamesToInject
         var klass : Klass = new Klass(testClass);
         var injectionConfig : Array = [];
         
         for each(var field : Field in klass.fields) {
            if(field.hasMetaData("Mock")) {
               /*if(!field.isProperty) {
                  throw new InitializationError(field.name + " must be acessible as a property to use [Mock] metadata.");
               }*/
               
               var mockType : String = field.getMetaData("Mock", "type");
               if(["nice", "strict"].indexOf(mockType) == -1 && mockType != null) {
                  throw new InitializationError(field.name + " must declare a mock type of either 'nice' or 'strict'; '" + mockType + "' is NOT a valid option.");
               } 
               
               var property : Dictionary = new Dictionary(true);
               property["name"] = field.name;
               property["klass"] = field.type;
               property["type"] = mockType || "nice";
               
               injectionConfig.push(property);
            }
         }
         
         return injectionConfig; 
      }
      
      /**
       * Overriden from parent to implement hook to run mock preparation before [BeforeClass] 
       */
      protected override function classBlock(notifier : IRunNotifier) : IAsyncStatement {
         if(propertyNamesToInject.length == 0) {
            return super.classBlock(notifier);
         }
         
         //build array of all class types to prepare
         var classes : Array = this.propertyNamesToInject.map(function(property : Dictionary, index : int, source : Array) : Class {
               return property["klass"] as Class;
            });

         //create sequence where mockery is injected and classes are prepared 
         var sequencer:StatementSequencer = new StatementSequencer();
			sequencer.addStep(new PrepareMockery(this.mockery, classes));
			sequencer.addStep(super.classBlock(notifier));

			return sequencer;
      }
      
      /**
       * Overriden from parent to implement hook to run mock injection before [Before] and verify after [After]
       */
      protected override function methodBlock(method : FrameworkMethod) : IAsyncStatement {
         if(propertyNamesToInject.length == 0) {
            return super.methodBlock(method);
         }
         
         //copy/paste of methodBlock from parent
         //we need a shared instance of the test class to inject the properties, so we can't call super since it doesn't provide a handle
         var test : Object = null;
			
			try {
				test = createTest();
			} 
			catch (e : Error) {
				trace(e.getStackTrace());
				return new Fail(e);
			}
			
			var sequencer:StatementSequencer = new StatementSequencer();
			//inject mocks before any befores executes
			sequencer.addStep(new InjectMocks(this.mockery, this.mockeryFieldName, propertyNamesToInject, test));
			
			//flow from base class
			sequencer.addStep(withBefores(method, test));
			sequencer.addStep(withDecoration(method, test ));
			sequencer.addStep(withAfters(method, test));

         //verify mocks after all afters executes
         var propertiesToVerify : Array = this.propertyNamesToInject.map(function(property : Dictionary, index : int, source : Array) : String {
               return property["name"] as String;
            });
         sequencer.addStep(new VerifyMocks(method, this.mockery, propertiesToVerify, test));
         
         return sequencer;
      }
   }
}