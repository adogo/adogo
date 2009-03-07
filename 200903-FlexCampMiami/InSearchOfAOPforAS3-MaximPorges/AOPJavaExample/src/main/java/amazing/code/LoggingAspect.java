package amazing.code;

import org.apache.commons.lang.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;


@Aspect
public class LoggingAspect
{
//   @Around("call(* AwesomeClass.div*(..))")
//   @Around("call(* AwesomeClass.add(..))")
   @Around("call(* AwesomeClass.*(Double, Double))")
//   @Around("call(* AwesomeClass.*(..))")
   public Object logMethodAccess(ProceedingJoinPoint joinPoint) throws Throwable
   {
      System.out.println(">>> A call is being made to " + joinPoint.getSignature() + " with arguments " + StringUtils.join(joinPoint.getArgs(), ", "));
      long startTime = System.currentTimeMillis();
      try
      {
         return joinPoint.proceed();
      }
      finally
      {
         System.out.println(">>> Call to " + joinPoint.getSignature() + " took " + (System.currentTimeMillis() - startTime) + " ms");
      }
   }
}
