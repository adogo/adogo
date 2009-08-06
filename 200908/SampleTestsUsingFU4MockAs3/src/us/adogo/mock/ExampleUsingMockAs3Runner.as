package us.adogo.mock
{
   import com.anywebcam.mock.Mockery;
   
   import org.flexunit.assertThat;
   import org.hamcrest.core.not;
   import org.hamcrest.object.equalTo;
   import org.hamcrest.object.hasProperty;
   import org.hamcrest.object.nullValue;
   
   [RunWith("com.anywebcam.mock.runner.MockAs3TestRunner")]
   public class ExampleUsingMockAs3Runner {
      public var mockery : Mockery;
      
      [Mock]
      public var user : User;
      
      private var controller : UserController; 
      
      [Before]
      public function setUp() : void {
         this.controller = new UserController(); 
      }
      
      [Test]
      public function testAddUserWithUsernameAndPasswordOnly() : void {
         //setup mock
         mockery.mock(user).method("save").calls(function () : void {
            user.id = 1;
         }).once;
         
         //populate object properties as you usually would
         user.username = "bobdobbs";
         user.password = "mysecret";
         
         //execute my controller method being tested
         controller.addUser(user);

         //test that the currentUsers went up by one and that its id is 1
         assertThat(controller.currentUsers.length, equalTo(1));
         assertThat(controller.currentUsers.getItemAt(0).id, equalTo(1));
      }
      
      [Test(verify="false")]
      public function testDefaultUserSize() : void {
         assertThat(controller, hasProperty("currentUsers"));
         assertThat(controller.currentUsers, not(nullValue()));
         assertThat(controller.currentUsers.length, equalTo(0));
      }
   }
}