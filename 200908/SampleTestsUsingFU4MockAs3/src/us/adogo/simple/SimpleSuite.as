package us.adogo.simple {

   import us.adogo.simple.BasicMathTest;
   import us.adogo.simple.TheoryTest;
   
   [Suite]
   [RunWith("org.flexunit.runners.Suite")]   
   public class SimpleSuite {
      public var t1 : BasicMathTest;
      public var t2 : TheoryTest;
   }
}