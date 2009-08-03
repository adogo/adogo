package org.flexunit.experimental.context
{

    public class Context
    {
        public var currentContext:ContextBlock;

        public function Context()
        {
            super();

            currentContext = new ContextBlock();
        }

        public function context(description:String, closure:Function):void
        {
            var parentContext:ContextBlock = currentContext;
            currentContext = new ContextBlock();
            currentContext.parent = parentContext;
            currentContext.description = description;
            currentContext.closure = closure;
            parentContext.contexts.push(currentContext);
            currentContext.closure();
            currentContext = parentContext;
        }

        public function should(description:String, closure:Function):void
        {
            var shouldBlock:ShouldBlock = new ShouldBlock();
            shouldBlock.description = description;
            shouldBlock.closure = closure;
            shouldBlock.parent = currentContext;
            currentContext.shoulds.push(shouldBlock);
        }

        public function before(closure:Function):void
        {
            currentContext.befores.push(closure);
        }

        public function after(closure:Function):void
        {
            currentContext.afters.push(closure);
        }
    }
}
