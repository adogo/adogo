package com.anywebcam.mock
{
    import asmock.framework.proxy.IProxyRepository;
    import asmock.framework.proxy.ProxyRepositoryImpl;
    
    import com.anywebcam.mock.proxy.MockInterceptor;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.system.ApplicationDomain;

    public class Mockery extends EventDispatcher
    {
        private var mocksByTarget:Object;
        private var proxyRepository:IProxyRepository;
        private var prepareProxyDispatchers:Array;

        public function Mockery()
        {
            proxyRepository = new ProxyRepositoryImpl();
            prepareProxyDispatchers = [];
            mocksByTarget = {};
        }

        public function prepare(... classes):void
        {
           if(classes.length > 0 && classes[0] is Array) {
              classes = classes[0];
           }
           
            var dispatcher:IEventDispatcher = proxyRepository.prepare(classes, ApplicationDomain.currentDomain);
            dispatcher.addEventListener(Event.COMPLETE, function(event:Event):void
                {
                    dispatchEvent(event)
                });
            prepareProxyDispatchers.push(dispatcher);
        }

        public function nice(classToMock:Class, constructorArgs:Array=null):*
        {
            var interceptor:MockInterceptor = new MockInterceptor();
            var target:* = proxyRepository.create(classToMock, constructorArgs || [], interceptor);
            var mock:Mock = new Mock(target, true);
            interceptor.mock = mock;
            mocksByTarget[target] = mock;
            return target;
        }

        public function strict(classToMock:Class, constructorArgs:Array=null):*
        {
            var interceptor:MockInterceptor = new MockInterceptor();
            var target:* = proxyRepository.create(classToMock, constructorArgs || [], interceptor);
            var mock:Mock = new Mock(target, false);
            interceptor.mock = mock;
            mocksByTarget[target] = mock;
            return target;
        }

        public function mock(target:Object):Mock
        {
            return mocksByTarget[target] as Mock;
        }

        public function verify(... targets):void
        {
            for each (var target:Object in targets)
            {
                var mock:Mock = mocksByTarget[target] as Mock;
                if (mock)
                {
                    mock.verify();
                }
            }
        }
    }
}