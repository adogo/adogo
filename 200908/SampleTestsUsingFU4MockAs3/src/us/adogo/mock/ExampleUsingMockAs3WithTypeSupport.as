package us.adogo.mock
{
   import com.anywebcam.mock.Mockery;
   
   import flash.events.Event;
   
   import org.flexunit.assertThat;
   import org.flexunit.async.Async;
   import org.hamcrest.object.equalTo;
   
   public class ExampleUsingMockAs3WithTypeSupport
   {
      private var mockery : Mockery;
      private var user : User;
      private var controller : UserController; 

      [Before(async,timeout=5000)]
      public function prepare():void
      {
          mockery = new Mockery();
          mockery.prepare(User);
          
          controller = new UserController();
          
          Async.proceedOnEvent(this, mockery, Event.COMPLETE, 5000);
      }
      
      [Test]
      public function testAddUserWithUsernameAndPasswordOnly():void
      {
         //setup mock
         user = mockery.nice(User) as User;
         mockery.mock(user).method("save").calls(function () : void {
            user.id = 1;
         }).once;
         
         //populate object properties as you usually would
         user.username = "bobdobbs";
         user.password = "mysecret";
         
         //execute my controller method being tested
         controller.addUser(user);

         //verify that the user had save called on it once
         mockery.verify(user);
         
         //test that the currentUsers went up by one and that its id is 1
         assertThat(controller.currentUsers.length, equalTo(1));
         assertThat(controller.currentUsers.getItemAt(0).id, equalTo(1));
      }
   }
}