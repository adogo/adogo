package org.flexunit.experimental.context
{
    import org.flexunit.internals.AssumptionViolatedException;
    import org.flexunit.internals.runners.ChildRunnerSequencer;
    import org.flexunit.internals.runners.model.EachTestNotifier;
    import org.flexunit.internals.runners.statements.IAsyncStatement;
    import org.flexunit.internals.runners.statements.StatementSequencer;
    import org.flexunit.runner.Description;
    import org.flexunit.runner.IDescription;
    import org.flexunit.runner.IRunner;
    import org.flexunit.runner.notification.IRunNotifier;
    import org.flexunit.runner.notification.StoppedByUserException;
    import org.flexunit.runners.ParentRunner;
    import org.flexunit.token.AsyncTestToken;
    import org.flexunit.token.ChildResult;
    import org.flexunit.utils.ClassNameUtil;

    public class ContextRunner implements IRunner
    {
        private var _contextClass:Class;

        public function ContextRunner(klass:Class)
        {
            super();

            _contextClass = klass;
        }

        public function run(notifier:IRunNotifier, parentToken:AsyncTestToken):void
        {
            var context:Context = new _contextClass() as Context;

            var testNotifier:EachTestNotifier = new EachTestNotifier(notifier, description);

            var token:AsyncTestToken = new AsyncTestToken(ClassNameUtil.getLoggerFriendlyClassName(this));
            token.parentToken = parentToken;
            token.addNotificationMethod(handleRunnerComplete);
            token["eachNotifier"] = testNotifier;

            var resendError:Error;

            try
            {
                var sequencer:StatementSequencer = new StatementSequencer();
                sequencer.addStep(new ChildRunnerSequencer(context.currentContext.contexts, runContext, notifier));
                sequencer.evaluate(token);
            }
            catch (error:AssumptionViolatedException)
            {
                resendError = error;
                testNotifier.fireTestIgnored();
            }
            catch (error:StoppedByUserException)
            {
                resendError = error;
                throw error;
            }
            catch (error:Error)
            {
                resendError = error;
                testNotifier.addFailure(error);
            }

            if (resendError)
            {
                parentToken.sendResult(resendError);
            }
        }

        protected function runContext(child:*, notifier:IRunNotifier, childRunnerToken:AsyncTestToken):void
        {
            trace('runContext', child.description);

            var context:ContextBlock = child as ContextBlock;
            var eachNotifier:EachTestNotifier = makeNotifier(child, notifier);
            var error:Error;

            var token:AsyncTestToken = new AsyncTestToken(ClassNameUtil.getLoggerFriendlyClassName(this));
            token.parentToken = childRunnerToken;
            token.addNotificationMethod(handleContextBlockComplete);
            token["eachNotifier"] = eachNotifier;

            eachNotifier.fireTestStarted();

            try
            {
                var sequencer:StatementSequencer = new StatementSequencer();
                sequencer.addStep(new ChildRunnerSequencer(context.shoulds, runShould, notifier));
                sequencer.addStep(new ChildRunnerSequencer(context.contexts, runContext, notifier));
                sequencer.evaluate(token);
            }
            catch (e:AssumptionViolatedException)
            {
                error = e;
                eachNotifier.addFailedAssumption(e);
            }
            catch (e:Error)
            {
                error = e;
                eachNotifier.addFailure(e);
            }

            if (error)
            {
                eachNotifier.fireTestFinished();
                childRunnerToken.sendResult();
            }
        }

        protected function runShould(child:*, notifier:IRunNotifier, childRunnerToken:AsyncTestToken):void
        {
            trace('runShould', child.description);

            var should:ShouldBlock = child as ShouldBlock;
            var eachNotifier:EachTestNotifier = makeNotifier(child, notifier);
            var error:Error;

            var token:AsyncTestToken = new AsyncTestToken(ClassNameUtil.getLoggerFriendlyClassName(this));
            token.parentToken = childRunnerToken;
            token.addNotificationMethod(handleShouldBlockComplete);
            token["eachNotifier"] = eachNotifier;

            eachNotifier.fireTestStarted();

            try
            {
                // only runs one level deep
                should.parent.befores.forEach(function(closure:Function, i:int, a:Array):void
                    {
                        closure();
                    });

                should.closure();

                // only runs one level deep
                should.parent.afters.forEach(function(closure:Function, i:int, a:Array):void
                    {
                        closure();
                    });
            }
            catch (e:AssumptionViolatedException)
            {
                error = e;
                eachNotifier.addFailedAssumption(e);
            }
            catch (e:Error)
            {
                error = e;
                eachNotifier.addFailure(e);
            }

            //if (error)
            //{
            eachNotifier.fireTestFinished();
            childRunnerToken.sendResult();
            //}
        }

        protected function handleContextBlockComplete(result:ChildResult):void
        {
            trace("handleContextBlockComplete", result, result.error, result.token);

            var error:Error = result.error;
            var token:AsyncTestToken = result.token;
            var eachNotifier:EachTestNotifier = result.token["eachNotifier"];

            if (error is AssumptionViolatedException)
            {
                eachNotifier.fireTestIgnored();
            }
            else if (error)
            {
                eachNotifier.addFailure(error);
            }

            eachNotifier.fireTestFinished();

            token.parentToken.sendResult();
        }

        protected function handleShouldBlockComplete(result:ChildResult):void
        {
            trace("handleShouldBlockComplete", result, result.error, result.token);
            var error:Error = result.error;
            var token:AsyncTestToken = result.token;
            var eachNotifier:EachTestNotifier = result.token["eachNotifier"];

            if (error is AssumptionViolatedException)
            {
                eachNotifier.fireTestIgnored();
            }
            else if (error)
            {
                eachNotifier.addFailure(error);
            }

            eachNotifier.fireTestFinished();

            token.parentToken.sendResult();
        }

        protected function handleRunnerComplete(result:ChildResult):void
        {
            var error:Error = result.error;
            var token:AsyncTestToken = result.token;
            var eachNotifier:EachTestNotifier = result.token["eachNotifier"];

            if (error is AssumptionViolatedException)
            {
                eachNotifier.fireTestIgnored();
            }
            else if (error is StoppedByUserException)
            {
                throw error;
            }
            else if (error)
            {
                eachNotifier.addFailure(error);
            }

            token.parentToken.sendResult();
        }

        protected function makeNotifier(child:*, notifier:IRunNotifier):EachTestNotifier
        {
            var description:IDescription = describeChild(child);
            return new EachTestNotifier(notifier, description);
        }

        protected function describeChild(child:*):IDescription
        {
            var description:String = child.description;
            var next:* = child;
            while ((next = next.parent) != null)
            {
                description = (next.description ? next.description + ", " : "") + description;
            }

            trace("describeChild", child, description);

            return Description.createTestDescription(_contextClass, description);
        }

        public function get description():IDescription
        {
            return new Description("context", null);
        }
    }
}