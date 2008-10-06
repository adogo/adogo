package adogo.example
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	import mx.controls.TextArea;
	import mx.core.UIComponent;

	/**
	 * A slightly advanced composite component where a Canvas wraps a TextArea and a handle. As the handle
	 * is dragged, this component changes size, making the TextArea within it bigger as well.
	 * 
	 * NOTE: This is not a production-ready component, it is just for demonstration purposes. Some bugs include
	 * the fact that the mouse gets away from the cursor if absolute positioning is not used, and I'm sure there
	 * are other things wrong with it, such as the fact that many of the internal object properties/styles are
	 * not accessible from the outside.  
	 */ 
	public class ResizableTextArea extends Canvas
	{
		/**
		 * A reference to the child TextArea displayed/resized by this component.
		 */
		private var interiorTextArea : TextArea;

		/**
		 * A basic UIComponent that we will draw in to.
		 */
		private var handle : UIComponent;
		
		/**
		 * The last captured position of the mouse. This is filled with the x and y coordinates accordingly.
		 */  
		private var lastKnownMousePosition : Point;
		
		/**
		 * The text value of the text component.
		 */
		public var text : String;
		
		/**
		 * The size of the handle in pixels (default is 10 pixels).
		 */
		public var handleRadius : int;
		
		public function ResizableTextArea()
		{
			super();
			
			handleRadius = 10;
			
			// NOTE: Don't create any children here - that is what createChildren() is for!
		}
		
		/**
		 * Creates the interior TextArea that this component wraps, along with a very basic
		 * UIComponent that is drawn in to directly to form the handle
		 */ 
		override protected function createChildren() : void
		{
			super.createChildren();
			
			// Create the interior text area, and set its text to the default value given. Also
			// creates a listener for text change events.
			interiorTextArea = new TextArea();
			interiorTextArea.text = this.text;
			interiorTextArea.addEventListener(Event.CHANGE, onTextChange);
			addChild(interiorTextArea);
			
			// Create the interior text area, and set its text to the default value given
			handle = new UIComponent();
			addChild(handle);
			handle.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		/**
		 * Keeps the public text property up to date with the text value in the TextArea.
		 */
		private function onTextChange(event : Event) : void
		{
			// The event target in this case will be the interior TextArea
			text = event.target.text;
		}
		
		/**
		 * When the left mouse button is pressed down over the handle, this function handles the event.
		 * We capture the mouse position at the time of the mouse down event and start listening to
		 * the stage for mouse movement and the mouse button being released (mouse up).
		 */ 
		private function onMouseDown(event : MouseEvent) : void
		{
			lastKnownMousePosition = new Point(event.stageX, event.stageY);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		/**
		 * When the mouse is moved, this function handles the event by doing the following:
		 * 1) Calculates the new position of the mouse
		 * 2) Calculates the change in x and y position between the last mouse move and the current mouse move
		 * 3) Uses the change in x and y to determine the appropriate change in width and height for this component.
		 * 4) Invalidates the component's size to apply the effects of the width and height adjustments. 
		 */ 
		private function onMouseMove(event : MouseEvent) : void
		{
			var changeInXPosition : int = (event.stageX - lastKnownMousePosition.x);
			var changeInYPosition : int = (event.stageY - lastKnownMousePosition.y);
			
			// Update the last known mouse positon, or you end up with cumulative differences, which results
			// in exponential size changes
			lastKnownMousePosition = new Point(event.stageX, event.stageY);
			
			this.width += changeInXPosition;
			this.height += changeInYPosition;

			invalidateSize();
		}
		
		/**
		 * Removes the mouse event listeners on the stage when the mouse is released.
		 */
		private function onMouseUp(event : MouseEvent) : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		/**
		 * Purpose of this method:
		 * 1) To set the size and position of the elements of the component for display.
		 * 2) To draw any visual elements necessary for the component. 
		 * 
		 * unscaledWidth/unscaledHeight: unscaled width and height of the component as determined by the parent container.
		 * Scaling occurs after this method is called.
		 */ 
		override protected function updateDisplayList(unscaledWidth : Number, unscaledHeight : Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			// Set the size of the interior box
			interiorTextArea.x = interiorTextArea.y = 0;
			interiorTextArea.width = (unscaledWidth - handleRadius);
			interiorTextArea.height = (unscaledHeight - handleRadius);
			
			// Draw the circle for the handle
			var halfRadius : int = (handleRadius / 2);
			var graphics : Graphics = handle.graphics;
			graphics.clear();
			graphics.lineStyle(1, 0x000000, 1.0);
			graphics.beginFill(0x00ff00);
			graphics.drawCircle(interiorTextArea.width, interiorTextArea.height, handleRadius);
			graphics.endFill();
		}
	}
}