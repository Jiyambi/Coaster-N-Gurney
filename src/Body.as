// ************************************************************************ 
// File Name:   Body.as 
// Purpose:     Base game object class. Includes physics, collision, and
//				drawing for basic game object.
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package  
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
    // ********************************************************************
    // Class:	Body 
    // ********************************************************************
	public class Body 
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// Game unit dimmensions
		protected var width:int;				// game units
		protected var height:int;				// game units
		
		// Game world position and orientation
		protected var position_x:Number;		// game units		
		protected var position_y:Number;		// game units
		protected var angle:Number;				// radians, clockwise, 0 = right
		
		// Game world velocities
		protected var velocity_x:Number;		// game units / second
		protected var velocity_y:Number;		// game units / second
		public var velocity_angle:Number;	// radians / second, clockwise
		
		// Display
		protected var visible:Boolean = true;
		protected var image:Image;
		// TODO: Change to array of images, for complex models. Most only use one.
		protected var layer:int;
	 
		// ****************************************************************
		// Function: 	Body()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				width:Number - width of object
		//				height:Number - height of object
		//				angle:Number - rotation of object
		// ****************************************************************
		public function Body(x:Number, y:Number, width:Number, height:Number, angle:Number=0)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::Body() called: x = " + x + ", y = " + y + ", width = " + width + ", height = " + height + ", angle = " + angle, 1);
			
			// Copy in supplied values
			this.width = width;
			this.height = height;
			this.position_x = x;
			this.position_y = y;
			this.angle = angle;
			
			// Velocities set to 0 at start
			velocity_x = 0;
			velocity_y = 0;
			velocity_angle = 0;
			
			Util.Debug("Body::Body() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Render()
		// Purpose:     Draws to the stage
		// ****************************************************************
		public function Render():void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::Render() called", 3);
			
			Util.Debug("Body::Render() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Update()
		// Purpose:     Updates logic
		// Input:		frameTime:Number - Ammount of time that passed
		//					between the last frame and this one, in
		//					seconds
		// ****************************************************************
		public function Update(frameTime:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::Update() called", 3);
			
			// Update position and orientation based on velocities
			position_x += velocity_x * frameTime;
			position_y += velocity_y * frameTime;
			angle += velocity_angle * frameTime;
			
			// Bounds check orientation
			if (angle > 2 * Math.PI)
				angle -= 2 * Math.PI;
			if (angle < 0)
				angle += 2 * Math.PI;
			
			// Image setup
			if (image)
			{
				image.SetPosition(position_x, position_y, angle);
				Renderer.AddToRenderQueue(image, layer);
			}
			
			Util.Debug("Body::Update() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}