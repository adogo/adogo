package adogo.demos
{
	import flash.utils.getQualifiedClassName;
	
	import mx.containers.VBox;
	import mx.utils.StringUtil;

	public class DemonstrateVBoxLifecycle extends VBox
	{
		public function DemonstrateVBoxLifecycle()
		{
			super();
		}

		override protected function createChildren() : void
		{
			trace(getQualifiedClassName(this) + ".createChildren()");

			super.createChildren();
		}
		
		override protected function commitProperties() : void
		{
			trace(getQualifiedClassName(this) + ".commitProperties()");

			super.commitProperties();
		}

		override protected function measure() : void
		{
			trace(getQualifiedClassName(this) + ".measure()");

			super.measure();
		}
		
		override protected function updateDisplayList(unscaledWidth : Number, unscaledHeight : Number):void
		{
			trace(
				StringUtil.substitute(	"{0}.updateDisplayList(unscaledWidth: {1}, unscaledHeight: {2})",
										getQualifiedClassName(this),
										unscaledWidth,
										unscaledHeight)
			);

			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
		/**
		 * layoutChrome() defines the border area around the container for subclasses of the Container class.
		 * 
		 * Usually you will use this method to layout out external elements on/in the border of a container (such
		 * as the edge around a text area, for example). You use createChildren() and the addChild() method to
		 * add children that are going to be within the bounds of the container.
		 * 
		 * Note that if you are drawing a border, you can use the RectangularBorder class, which is added as child
		 * in createChildren(). 
		 * 
		 * For more information, see “Implementing the layoutChrome() method” on page 145.
		 */
		override protected function layoutChrome(unscaledWidth : Number, unscaledHeight : Number) : void
		{
			trace(
				StringUtil.substitute(	"{0}.layoutChrome(unscaledWidth: {1}, unscaledHeight: {2})",
										getQualifiedClassName(this),
										unscaledWidth,
										unscaledHeight)
			);
			
			super.layoutChrome(unscaledWidth, unscaledHeight);
		}
	}
}