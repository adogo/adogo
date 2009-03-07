magic 2e0010
Cpool numbers size 3 1 %
Cpool strings count 11 size 121 41 %
Cpool namespaces count 9 size 17 5 %
Cpool nssets count 3 size 15 5 %
Cpool names count 7 size 19 6 %
MethodInfo count 4 size 17 5 %
InstanceInfo size 12 4 %
ClassInfo size 2 0%
ScriptInfo size 7 2 %
MethodBodies size 72 24 %
script0

class amazing.code::BaseClass extends Object
{

  function amazing.code::BaseClass():*	/* disp_id -1*/
  {
    // local_count=1 max_scope=1 max_stack=1 code_len=6
    0       getlocal0     	
    1       pushscope     	
    2       getlocal0     	
    3       constructsuper	(0)
    5       returnvoid    	
  }

  function doSomething():void	/* disp_id 0*/
  {
    // local_count=1 max_scope=1 max_stack=2 code_len=11
    0       getlocal0     	
    1       pushscope     	
    2       findpropstrict	trace
    4       pushstring    	"doSomething() in BaseClass."
    6       callproperty  	trace (1)
    9       pop           	
    10      returnvoid    	
  }

  static function amazing.code::BaseClass$cinit():*	/* disp_id 0*/
  {
    // local_count=1 max_scope=1 max_stack=1 code_len=3
    0       getlocal0     	
    1       pushscope     	
    2       returnvoid    	
  }
}

function script0$init():*	/* disp_id 0*/
{
  // local_count=1 max_scope=2 max_stack=2 code_len=19
  0         getlocal0     	
  1         pushscope     	
  2         getscopeobject	0
  4         findpropstrict	Object
  6         getproperty   	Object
  8         pushscope     	
  9         findpropstrict	Object
  11        getproperty   	Object
  13        newclass      	amazing.code::BaseClass
  15        popscope      	
  16        initproperty  	amazing.code::BaseClass
  18        returnvoid    	
}
OPCODE	SIZE	% OF 39
findpropstrict	6	15%
pushscope     	5	12%
getlocal0     	5	12%
returnvoid    	4	10%
getproperty   	4	10%
callproperty  	3	7%
pushstring    	2	5%
constructsuper	2	5%
newclass      	2	5%
getscopeobject	2	5%
initproperty  	2	5%
popscope      	1	2%
pop           	1	2%
