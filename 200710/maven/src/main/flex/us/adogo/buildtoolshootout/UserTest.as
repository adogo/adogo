package us.adogo.buildtoolshootout
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import us.adogo.buildtoolshootout.User;
	public class UserTest extends TestCase
	{
		public function UserTest( methodName:String )
		{
   			super( methodName );
        }

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
   			ts.addTest( new UserTest( "testGetName" ) );
   			return ts;
   		}
   		
		public function testGetName() : void
		{
			var user:User = new User();
			user.first_name = "Brian";
			user.last_name = "LeGros";
		
			assertEquals("Brian LeGros", user.getName());
		}
   }
}