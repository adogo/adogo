package {
import mx.managers.SystemManager;
import flash.utils.*;
import flash.system.ApplicationDomain;
import mx.core.IFlexModuleFactory;
import mx.core.IFlexModule;
public class _AntTestRunner_mx_managers_SystemManager extends mx.managers.SystemManager implements IFlexModuleFactory {
  public function _AntTestRunner_mx_managers_SystemManager() {
      super();
}
override public function create(... params):Object
{
  if ((params.length == 0) || (params[0] is String))
  {
    var mainClassName:String = null;
    if (params.length == 0) mainClassName = 'AntTestRunner';
    else mainClassName = String(params[0]);
    var clazz:Class = Class(getDefinitionByName(mainClassName));
    if (clazz != null)
    {
      var inst:Object = new clazz();
      if (inst is IFlexModule)
      {
         (IFlexModule(inst)).moduleFactory = this;
      }
      return inst;
    }
    else return null;
  }
  else return super.create.apply(this, params);
}
  override public function info():Object { return {
"currentDomain": ApplicationDomain.currentDomain,
"creationComplete" : "onCreationComplete()",
"mainClassName" : "AntTestRunner",
"mixins" : ["_AntTestRunner_FlexInit", "_richTextEditorTextAreaStyleStyle", "_alertButtonStyleStyle", "_dataGridStylesStyle", "_headerDragProxyStyleStyle", "_textAreaVScrollBarStyleStyle", "_activeTabStyleStyle", "_ContainerStyle", "_ScrollBarStyle", "_windowStatusStyle", "_headerDateTextStyle", "_textAreaHScrollBarStyleStyle", "_plainStyle", "_activeButtonStyleStyle", "_globalStyle", "_comboDropDownStyle", "_ButtonStyle", "_todayStyleStyle", "_windowStylesStyle", "_ApplicationStyle", "_ToolTipStyle", "_opaquePanelStyle", "_errorTipStyle", "_weekDayStyleStyle", "_dateFieldPopupStyle"]
}; }
}}
