magic 2e0010
Cpool numbers size 3 0 %
Cpool strings count 15 size 155 37 %
Cpool namespaces count 12 size 23 5 %
Cpool nssets count 5 size 37 8 %
Cpool names count 14 size 39 9 %
MethodInfo count 4 size 17 4 %
InstanceInfo size 17 4 %
ClassInfo size 2 0%
ScriptInfo size 7 1 %
MethodBodies size 108 26 %
script0

class amazing.code::SubClass extends amazing.code::BaseClass
{

  function amazing.code::SubClass():*	/* disp_id -1*/
  {
    // local_count=1 max_scope=1 max_stack=2 code_len=14
    0       getlocal0     	
    1       pushscope     	
    2       getlocal0     	
    3       constructsuper	(0)
    5       getlocal0     	
    6       findpropstrict	Dictionary
    8       constructprop 	Dictionary (0)
    11      initproperty  	closures
    13      returnvoid    	
  }
  var closures:flash.utils::Dictionary	/* slot_id 0 */

  function doSomething():void	/* disp_id 0*/
  {
    // local_count=2 max_scope=1 max_stack=3 code_len=33
    0       getlocal0     	
    1       pushscope     	
    2       getlocal0     	
    3       getproperty   	closures
    5       pushstring    	"doSomething"
    7       getproperty   	null
    9       convert_b     	
    10      iffalse       	L1

    14      getlocal0     	
    15      getproperty   	closures
    17      pushstring    	"doSomething"
    19      getproperty   	null
    21      getlocal0     	
    22      getlocal1     	
    23      callproperty  	apply (2)
    26      pop           	
    
    L1: 
    27      getlocal0     	
    28      callsuper     	doSomething (0)
    31      pop           	
    32      returnvoid    	
  }

  static function amazing.code::SubClass$cinit():*	/* disp_id 0*/
  {
    // local_count=1 max_scope=1 max_stack=1 code_len=3
    0       getlocal0     	
    1       pushscope     	
    2       returnvoid    	
  }
}

function script0$init():*	/* disp_id 0*/
{
  // local_count=1 max_scope=3 max_stack=2 code_len=25
  0         getlocal0     	
  1         pushscope     	
  2         getscopeobject	0
  4         findpropstrict	Object
  6         getproperty   	Object
  8         pushscope     	
  9         findpropstrict	amazing.code::BaseClass
  11        getproperty   	amazing.code::BaseClass
  13        pushscope     	
  14        findpropstrict	BaseClass
  16        getproperty   	BaseClass
  18        newclass      	amazing.code::SubClass
  20        popscope      	
  21        popscope      	
  22        initproperty  	amazing.code::SubClass
  24        returnvoid    	
}
OPCODE	SIZE	% OF 75
getproperty   	14	18%
getlocal0     	10	13%
findpropstrict	8	10%
pushscope     	6	8%
iffalse       	4	5%
pushstring    	4	5%
returnvoid    	4	5%
initproperty  	4	5%
callsuper     	3	4%
callproperty  	3	4%
constructprop 	3	4%
popscope      	2	2%
pop           	2	2%
constructsuper	2	2%
newclass      	2	2%
getscopeobject	2	2%
convert_b     	1	1%
getlocal1     	1	1%
