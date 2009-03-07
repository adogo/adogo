package awesome.code;

import org.junit.Test;

import amazing.code.AwesomeClass;


public class AspectExampleTest
{
   @Test
   public void runAspects() throws InterruptedException
   {
      AwesomeClass awesome = new AwesomeClass();
      System.out.println("Actual call to add(1, 2): " + awesome.add(1, 2));
      System.out.println();
      
      System.out.println("Actual call to divide(5, 6): " + awesome.divide(5.0, 6.0));
      System.out.println();
      
      System.out.println("Actual call to multiply(3, 4): " + awesome.multiply(3.0, 4.0));
      System.out.println();
   }
}
