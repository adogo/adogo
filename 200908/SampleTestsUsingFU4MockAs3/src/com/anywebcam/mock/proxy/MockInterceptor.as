package com.anywebcam.mock.proxy
{
    import asmock.framework.proxy.IInterceptor;
    import asmock.framework.proxy.IInvocation;

    import com.anywebcam.mock.Mock;

    public class MockInterceptor implements IInterceptor
    {
        public var mock:Mock;

        public function MockInterceptor()
        {
            super();
        }

        public function intercept(invocation:IInvocation):void
        {
            if (invocation.property)
            {
                if (invocation.method.name == 'get')
                {
                    invocation.returnValue = mock[invocation.property.name];
                }
                else
                {
                    mock[invocation.property.name] = invocation.arguments[0];
                    invocation.returnValue = null;
                }
            }
            else
            {
                invocation.returnValue = mock.invokeMethod(invocation.method.name, invocation.arguments);
            }
        }
    }
}