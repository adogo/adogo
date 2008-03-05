package nvc
{
   import events.AuthenticationEvent;
   
   import flexunit.framework.TestCase;
   import flexunit.framework.TestSuite;

   public class AuthenticationNvcTest extends TestCase
   {
      public function AuthenticationNvcTest(methodName:String=null) {
         super(methodName);
      }
      
      public static function get suite() : TestSuite {
         var suite : TestSuite = new TestSuite();
         
         suite.addTest(new AuthenticationNvcTest("shouldInitializeWithAuthenticatedSetToFalse"));
         suite.addTest(new AuthenticationNvcTest("shouldInitializeWithFailedAuthenticationSetToFalse"));
         suite.addTest(new AuthenticationNvcTest("shouldInitializeWithUserSetToNull"));
         suite.addTest(new AuthenticationNvcTest("shouldAuthenticateForUserDanielPasswordPassword"));
         suite.addTest(new AuthenticationNvcTest("shouldFailAuthenticationForAnyUserOtherThanDaniel"));
         suite.addTest(new AuthenticationNvcTest("shouldFailAuthenticationForAnyPasswordOtherThanPassword"));
         suite.addTest(new AuthenticationNvcTest("shouldSetUserIfAuthenticated"));
         suite.addTest(new AuthenticationNvcTest("shouldNotSetUserIfFailedAuthenticated"));
         suite.addTest(new AuthenticationNvcTest("shouldDispatchAuthenticationEventFailWhenAuthenticationFails"));
         suite.addTest(new AuthenticationNvcTest("shouldDispatchAuthenticationEventPassWhenAuthenticationSucceeds"));
         
         return suite;
      }
      
      override public function setUp() : void {
      }
      
      public function shouldInitializeWithAuthenticatedSetToFalse() : void {
         var authenticationNvc : AuthenticationNvc = new AuthenticationNvc();
         
         assertFalse(authenticationNvc.authenticated);
      }

      public function shouldInitializeWithFailedAuthenticationSetToFalse() : void {
         var authenticationNvc : AuthenticationNvc = new AuthenticationNvc();
         
         assertFalse(authenticationNvc.failedAuthentication);
      }
      
      public function shouldInitializeWithUserSetToNull() : void {
         var authenticationNvc : AuthenticationNvc = new AuthenticationNvc();
         
         assertNull(authenticationNvc.user);
      }
      
      public function shouldAuthenticateForUserDanielPasswordPassword() : void {
         var authenticationNvc : AuthenticationNvc = new AuthenticationNvc();
         authenticationNvc.authenticate("daniel", "password");
         
         assertTrue(authenticationNvc.authenticated);
         assertFalse(authenticationNvc.failedAuthentication);
      }
      
      public function shouldFailAuthenticationForAnyUserOtherThanDaniel() : void {
         var authenticationNvc : AuthenticationNvc = new AuthenticationNvc();
         authenticationNvc.authenticate("test", "password");
         
         assertFalse(authenticationNvc.authenticated);         
         assertTrue(authenticationNvc.failedAuthentication);
      }
      
      public function shouldFailAuthenticationForAnyPasswordOtherThanPassword() : void {
         var authenticationNvc : AuthenticationNvc = new AuthenticationNvc();
         authenticationNvc.authenticate("daniel", "test");
         
         assertFalse(authenticationNvc.authenticated);      
         assertTrue(authenticationNvc.failedAuthentication);   
      }
      
      public function shouldSetUserIfAuthenticated() : void {
         var authenticationNvc : AuthenticationNvc = new AuthenticationNvc();
         authenticationNvc.authenticate("daniel", "password");
         
         assertNotNull(authenticationNvc.user);
         assertEquals("daniel", authenticationNvc.user.username);
         assertEquals("Daniel", authenticationNvc.user.firstName);
         assertEquals("Roop", authenticationNvc.user.lastName);
      }
      
      public function shouldNotSetUserIfFailedAuthenticated() : void {
         var authenticationNvc : AuthenticationNvc = new AuthenticationNvc();
         authenticationNvc.authenticate("daniel", "test");
         
         assertNull(authenticationNvc.user);
      }
      
      public function shouldDispatchAuthenticationEventFailWhenAuthenticationFails() : void {
         var authenticationNvc : AuthenticationNvc = new AuthenticationNvc();
         var eventFired : Boolean = false;
         
         authenticationNvc.addEventListener(AuthenticationEvent.FAIL, function (event : AuthenticationEvent) : void {
            eventFired = true;
         });
         
         authenticationNvc.addEventListener(AuthenticationEvent.PASS, function (event : AuthenticationEvent) : void {
            fail("Pass Event Listener shold not be called");
         });
         
         authenticationNvc.authenticate("daniel", "test");
         
         assertTrue(eventFired);
      }
      
      public function shouldDispatchAuthenticationEventPassWhenAuthenticationSucceeds() : void {
         var authenticationNvc : AuthenticationNvc = new AuthenticationNvc();
         var eventFired : Boolean = false;
         
         authenticationNvc.addEventListener(AuthenticationEvent.PASS, function (event : AuthenticationEvent) : void {
            eventFired = true;
         });
         
         authenticationNvc.addEventListener(AuthenticationEvent.FAIL, function (event : AuthenticationEvent) : void {
            fail("Fail Event Listener shold not be called");
         });
         
         authenticationNvc.authenticate("daniel", "password");
         
         assertTrue(eventFired);
      }
   }
}