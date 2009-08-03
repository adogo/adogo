package us.adogo.context
{
    import org.flexunit.assertThat;
    import org.flexunit.experimental.context.Context;
    import org.hamcrest.core.not;
    import org.hamcrest.object.equalTo;
    
    [RunWith("org.flexunit.experimental.context.ContextRunner")]
    public class ExampleSpec extends Context
    {
        public function ExampleSpec()
        {
            super();
            
            context("when examples are defined", function():void {
                should("pass nicely", function():void {
                    assertThat(true, equalTo(true));
                });
                
                should("fail nicely", function():void {
                    assertThat(true, not(equalTo(true)));
                });
                
                context("when examples are nested", function():void {
                    should("be described properly", function():void {
                        assertThat(true, not(equalTo(true)));
                    });
                });
            });
            
            context("when examples are defined", function():void {
                var value:int;
                
                context("with the same description", function():void {
                    before(function():void {
                        value = 7;
                    });
                    
                    should("work independantly", function():void {
                        assertThat(value, equalTo(7));
                    });
                });
                
                context("with the same description", function():void {
                    before(function():void {
                        value = 8;
                    });
                    
                    should("work independantly", function():void {
                        assertThat(value, not(equalTo(7)));
                    });
                });
            });
        }
    }
}
