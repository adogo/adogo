package adogo.demos
{
	import mx.utils.StringUtil;

	public class MeasuredCustomComponent extends DemonstrateVBoxLifecycle
	{
		public function MeasuredCustomComponent()
		{
			super();
		}
		
		/**
		 * Example of implementing measure() by setting an explicit default width/height across the board.
		 * This will force the parent to treat the default sizing of this component to 100px wide by 100 px
		 * high.
		 */ 
		override protected function measure() : void
		{
			super.measure();

			trace(
				StringUtil.substitute(
					"MeasuredCustomComponent.measure(): ===> measuredHeight: {0}, measuredWidth: {1}, measuredMinHeight: {2}, measuredMinWidth: {3}",
					measuredHeight,
					measuredWidth,
					measuredMinHeight,
					measuredMinWidth)
			); 

			// Tell Flex we're 100 pixels wide and high
			measuredHeight = measuredWidth = measuredMinHeight = measuredMinWidth = 100;
		}
	}
}