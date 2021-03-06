package {
import flash.utils.*;
import mx.core.IFlexModuleFactory;
import flash.system.*
import mx.effects.EffectManager;
import mx.core.mx_internal;

[Mixin]
public class _AntTestRunner_FlexInit
{
   public function _AntTestRunner_FlexInit()
   {
       super();
   }
   public static function init(fbs:IFlexModuleFactory):void
   {
      EffectManager.mx_internal::registerEffectTrigger("addedEffect", "added");
      EffectManager.mx_internal::registerEffectTrigger("creationCompleteEffect", "creationComplete");
      EffectManager.mx_internal::registerEffectTrigger("focusInEffect", "focusIn");
      EffectManager.mx_internal::registerEffectTrigger("focusOutEffect", "focusOut");
      EffectManager.mx_internal::registerEffectTrigger("hideEffect", "hide");
      EffectManager.mx_internal::registerEffectTrigger("mouseDownEffect", "mouseDown");
      EffectManager.mx_internal::registerEffectTrigger("mouseUpEffect", "mouseUp");
      EffectManager.mx_internal::registerEffectTrigger("moveEffect", "move");
      EffectManager.mx_internal::registerEffectTrigger("removedEffect", "removed");
      EffectManager.mx_internal::registerEffectTrigger("resizeEffect", "resize");
      EffectManager.mx_internal::registerEffectTrigger("rollOutEffect", "rollOut");
      EffectManager.mx_internal::registerEffectTrigger("rollOverEffect", "rollOver");
      EffectManager.mx_internal::registerEffectTrigger("showEffect", "show");
      var styleNames:Array = ["fontAntiAliasType", "errorColor", "kerning", "backgroundDisabledColor", "modalTransparencyColor", "textRollOverColor", "textIndent", "themeColor", "modalTransparency", "fontThickness", "textAlign", "fontFamily", "textSelectedColor", "fontGridFitType", "letterSpacing", "fontStyle", "dropShadowColor", "fontSize", "disabledColor", "fontWeight", "modalTransparencyBlur", "color", "fontSharpness", "barColor", "modalTransparencyDuration"];

      import mx.styles.StyleManager;

      for (var i:int = 0; i < styleNames.length; i++)
      {
         StyleManager.registerInheritingStyle(styleNames[i]);
      }
   }
}  // FlexInit
}  // package
