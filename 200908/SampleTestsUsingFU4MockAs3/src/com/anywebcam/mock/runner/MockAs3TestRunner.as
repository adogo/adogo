package com.anywebcam.mock.runner
{
   import com.anywebcam.mock.Mockery;
   
   import flash.utils.Dictionary;
   
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
               var mockType : String = field.getMetaData("Mock", "type") || "nice";
               if(["nice", "strict"].indexOf(mockType) == -1) {
                  throw new InitializationError("Property '" + field.name + "' must declare a mock type of either 'nice' or 'strict'; '" + mockType + "' is NOT a valid type.");
               } 
               
               var injectable : String = field.getMetaData("Mock", "inject") || "true";
               if(["true", "false"].indexOf(injectable) == -1) {
                  throw new InitializationError("Property '" + field.name + "' must declare the attribute inject as either 'true' or 'false'; '" + injectable + "' is NOT valid.");
               }
               
               if(injectable == "true") {
                  var constructorParamLength : Number = new Klass(field.type).constructor.parameterTypes.length;
                  if(constructorParamLength != 0) {
                     throw new InitializationError("Cannot inject mock of type '" + field.type 
                        + "' into property '" + field.name 
                        + "'; constructor arguments are required!  Please set inject='false' and manually create the mock in the [Before] for this test class.");
                  }
               }
               
               var property : Dictionary = new Dictionary(true);
               property["name"] = field.name;
               property["klass"] = field.type;
               property["type"] = mockType;
               property["inject"] = (injectable == "true");
               
               injectionConfig.push(property);
            }
         }
         
         return injectionConfig; 
      }
      
      /**
       * Overriden from parent to implement hook to run mock preparation before [BeforeClass] 
       */
      protected override function classBlock(notifier : IRunNotifier) : IAsyncStatement {
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
       * Overriden from parent to implement hook to run mockery and mock injection before [Before] and verify after [After]
       */
      protected override function methodBlock(method : FrameworkMethod) : IAsyncStatement {
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
			//inject mockery and mocks before any befores executes
			sequencer.addStep(new InjectMockery(mockery, mockeryFieldName, test));
			sequencer.addStep(new InjectMocks(this.mockery, propertyNamesToInject, test));
			
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