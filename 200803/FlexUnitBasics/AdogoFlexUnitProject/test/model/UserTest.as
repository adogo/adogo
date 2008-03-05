package model
{
   import flexunit.framework.TestCase;
   import flexunit.framework.TestSuite;

   public class UserTest extends TestCase
   {
      private var user : User;
      
      public function UserTest(methodName:String=null) {
         super(methodName);
      }
      
      public static function get suite() : TestSuite {
         var suite : TestSuite = new TestSuite();
         
         suite.addTest(new UserTest("shouldHavePublicPropertyForFirstName"));
         suite.addTest(new UserTest("shouldHavePublicPropertyForLastName"));
         suite.addTest(new UserTest("shouldHavePublicPropertyForUsername"));         
         
         return suite;
      }
      
      override public function setUp() : void {
         user = new User();
         user.firstName = "Daniel";
         user.lastName = "Roop";
         user.username = "daniel";
      }
      
      public function shouldHavePublicPropertyForFirstName() : void {
         var user : User = new User();
         
         user.firstName = "first_name";

         assertEquals("first_name", user.firstName);
      }
      
      public function shouldHavePublicPropertyForLastName() : void {
         var user : User = new User();
         
         user.lastName = "last_name";

         assertEquals("last_name", user.lastName);
      }
      
      public function shouldHavePublicPropertyForUsername() : void {
         var user : User = new User();
         
         user.username = "username";

         assertEquals("username", user.username);
      }
   }
}