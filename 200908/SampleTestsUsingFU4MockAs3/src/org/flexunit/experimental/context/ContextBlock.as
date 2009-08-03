package org.flexunit.experimental.context
{

    public class ContextBlock
    {
        public var parent:ContextBlock;
        public var befores:Array;
        public var afters:Array;
        public var contexts:Array;
        public var shoulds:Array;

        public var description:String;
        public var closure:Function;

        public function ContextBlock()
        {
            super();
            befores = [];
            afters = [];
            contexts = [];
            shoulds = [];
        }
    }
}