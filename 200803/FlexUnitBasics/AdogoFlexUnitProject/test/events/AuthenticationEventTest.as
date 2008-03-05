package events
{
   import flexunit.framework.TestCase;
   import flexunit.framework.TestSuite;

   public class AuthenticationEventTest extends TestCase
   {
      private var failedEvent : AuthenticationEvent;
      private var passEvent : AuthenticationEvent;
      
      public function AuthenticationEventTest(methodName:String=null) {
         super(methodName);
      }
      
      public static function get suite() : TestSuite {
         var suite : TestSuite = new TestSuite();
         
         suite.addTest(new AuthenticationEventTest("shouldHaveSameTypeAfterClone"));         
         
         return suite;
      }
      
      override public function setUp() : void {
         failedEvent = new AuthenticationEvent(AuthenticationEvent.FAIL);
         passEvent = new AuthenticationEvent(AuthenticationEvent.PASS);
      }
      
      public function shouldHaveSameTypeAfterClone() : void {
         var clonedFailure : AuthenticationEvent = failedEvent.clone() as AuthenticationEvent;
         var clonedSuccess : AuthenticationEvent = passEvent.clone() as AuthenticationEvent;
         
         assertEquals(AuthenticationEvent.FAIL, clonedFailure.type);
         assertEquals(AuthenticationEvent.PASS, clonedSuccess.type);
      }
   }
}