package us.adogo.mock
{
   public class Account
   {
      public var id : Number;
      private var _name : String;
      
      public function Account(name : String) : void {
         this._name = name;
      }
      
      public function get name() : String {
         return _name;
      }
      
      public function isValid(user : User) : Boolean {
         return (_name != null && user != null);
      }
   }
}