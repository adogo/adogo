package views
{
   import events.AuthenticationEvent;
   
   import flash.events.MouseEvent;
   
   import flexunit.framework.TestCase;
   import flexunit.framework.TestSuite;
   
   import model.User;
   
   import nvc.StubAuthenticationNvc;
   
   import views.Main;
   
   public class MainTest extends TestCase
   {
      private var form : Main;
      
      public function MainTest(methodName:String=null) {
         super(methodName);
      }
      
      public static function get suite() : TestSuite {
         var suite : TestSuite = new TestSuite();
         
         suite.addTest(new MainTest("shouldCallAuthenticationNvcWhenLoginClicked"));
         suite.addTest(new MainTest("shouldShowErrorMessageIfAuthenticationFailed"));
         suite.addTest(new MainTest("shouldBindNvcUserToUserForm"));
         suite.addTest(new MainTest("shouldHavePasswordTextInputSetToPassword"));
         suite.addTest(new MainTest("shouldSwitchStackToSiteWhenAutenticationPasses"));
         
         return suite;
      }
      
      override public function setUp() : void {
         form = new Main();
         form.creationPolicy = "all";
         form.initialize();
      }
      
      public function shouldCallAuthenticationNvcWhenLoginClicked() : void {
         var stub : StubAuthenticationNvc = new StubAuthenticationNvc();
         
         form = new Main();
         form.authenticationNvc = stub;
         
         
         form.loginButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         
         assertTrue(stub.authenticateCalled);
      }
      
      public function shouldShowErrorMessageIfAuthenticationFailed() : void
      {
         assertFalse(form.loginError.visible);
         
         form.authenticationNvc.failedAuthentication = true;
         
         assertTrue(form.loginError.visible);
      }
      
      public function shouldBindNvcUserToUserForm() : void
      {
         var user : User = new User();
         
         form.authenticationNvc.user = user;
         
         assertStrictlyEquals(user, form.userForm.user);
      }
      
      public function shouldHavePasswordTextInputSetToPassword() : void
      {
         assertTrue(form.password.displayAsPassword);
      }
      
      public function shouldSwitchStackToSiteWhenAutenticationPasses() : void
      {
         assertEquals(form.login, form.stack.selectedChild);
         
         form.authenticationNvc.dispatchEvent(new AuthenticationEvent(AuthenticationEvent.PASS));
         
         assertEquals(form.site, form.stack.selectedChild);
      }
   }
}
