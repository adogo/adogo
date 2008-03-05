package
{
   import events.AuthenticationEventTest;
   
   import flexunit.framework.TestSuite;
   
   import model.UserTest;
   
   import nvc.AuthenticationNvcTest;
   
   import views.UserFormTest;
   
   import views.MainTest;
   
   public class AllTests
   {
      public static function get suite() : TestSuite {
         var ts:TestSuite = new TestSuite();
         
         ts.addTest(AuthenticationEventTest.suite);
         ts.addTest(UserTest.suite);
         ts.addTest(AuthenticationNvcTest.suite);
         ts.addTest(UserFormTest.suite);
         ts.addTest(MainTest.suite);
         
         return ts;
      }
   }
}