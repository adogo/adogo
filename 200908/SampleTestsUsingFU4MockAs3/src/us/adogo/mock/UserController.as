package us.adogo.mock
{
   import mx.collections.ArrayCollection;
   
   public class UserController
   {
      public var currentUsers : ArrayCollection;
      
      public function UserController() : void {
         currentUsers = new ArrayCollection();
      }
      
      public function validateUser(user : User, account : Account) : Boolean {
         return account.isValid(user);
      }
      
      public function addUser(user : User) : void {
         user.save();
         currentUsers.addItem(user);
      }
   }
}