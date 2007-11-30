package 
{

import flash.display.Sprite;
import mx.core.IFlexModuleFactory;
import mx.core.mx_internal;
import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;

[ExcludeClass]

public class _comboDropDownStyle
{

    public static function init(fbs:IFlexModuleFactory):void
    {
        var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".comboDropDown");
    
        if (!style)
        {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".comboDropDown", style, false);
        }
    
        if (style.defaultFactory == null)
        {
            style.defaultFactory = function():void
            {
                this.shadowDirection = "center";
                this.fontWeight = "normal";
                this.dropShadowEnabled = true;
                this.backgroundColor = 0xffffff;
                this.shadowDistance = 1;
                this.cornerRadius = 0;
                this.borderThickness = 0;
            };
        }
    }
}

}
