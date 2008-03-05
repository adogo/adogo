package views
{
   import flexunit.framework.TestCase;
   import flexunit.framework.TestSuite;
   
   import model.User;

   public class UserFormTest extends TestCase
   {
      private var form : UserForm;
      private var user : User;
      
      public function UserFormTest(methodName:String=null) {
         super(methodName);
      }
      
      public static function get suite() : TestSuite {
         var suite : TestSuite = new TestSuite();
         
         suite.addTest(new UserFormTest("shouldUpdateWelcomeWhenUserSet"));
         suite.addTest(new UserFormTest("shouldSetTextInputsWhenUserSet"));
         suite.addTest(new UserFormTest("shouldUpdateFieldsWhenUserUpdated"));
         
         return suite;
      }
      
      override public function setUp() : void {
         form  = new UserForm();
         form.initialize();
         
         user = new User();
         user.firstName = "first_name";
         user.lastName = "last_name";
         user.username = "username";
      }
      
      public function shouldUpdateWelcomeWhenUserSet() : void {
         form.user = user;
      
         assertEquals("Welcome first_name last_name!", form.greeting.text); 
      }
      
      public function shouldSetTextInputsWhenUserSet() : void {
         form.user = user;
      
         assertEquals("first_name", form.first_name.text);
         assertEquals("last_name", form.last_name.text);
         assertEquals("username", form.username.text); 
      }
      
      public function shouldUpdateFieldsWhenUserUpdated() : void {
         form.user = user;
      
         assertEquals("Welcome first_name last_name!", form.greeting.text);
         assertEquals("first_name", form.first_name.text);
         assertEquals("last_name", form.last_name.text);
         assertEquals("username", form.username.text);
         
         form.user.firstName = "Daniel"; 
         
         assertEquals("Welcome Daniel last_name!", form.greeting.text);
         assertEquals("Daniel", form.first_name.text);
         assertEquals("last_name", form.last_name.text);
         assertEquals("username", form.username.text);
      }
   }
}