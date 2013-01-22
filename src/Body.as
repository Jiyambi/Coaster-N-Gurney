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
		// Public Data Members 
		// ****************************************************************
		
		// Dimmensions
		// TODO: Game unit dimmensions?
		public var width:int;			// pixels
		public var height:int;			// pixels
		
		// Game world position and orientation
		public var position_x:Number;	// game units		
		public var position_y:Number;	// game units
		public var angle:Number;		// radians, clockwise, 0 = right
		
		// Game world velocities
		public var velocity_x:Number;		// game units / second
		public var velocity_y:Number;		// game units / second
		public var velocity_angle:Number;	// radians / second, clockwise

		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		protected var image:BitmapData;
		protected var image_sprite:Sprite;
	 
		// ****************************************************************
		// Function: 	Body()
		// Purpose:     Constructor.
		// Input:		x:int - x coordinate for object
		//				y:int - y coordinate for object
		//				width:int - width of object
		//				height:int - height of object
		//				angle:int - rotation of object
		// ****************************************************************
		public function Body(x:int, y:int, width:int, height:int, angle:int=0)
		{
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
		}
		
		// ****************************************************************
		// Function: 	Render()
		// Purpose:     Draws to the stage
		// ****************************************************************
		public function Render():void
		{
			if (image_sprite)
			{
				// Crete a matrix and move it to the body's location
				var matrix:Matrix = new Matrix();
				matrix.translate(-1*width/2, -1*height/2);
				matrix.rotate(angle);
				matrix.translate(position_x+width/2, position_y+height/2);
	 
				// Render the image to this matrix
				Game.renderer.draw(image_sprite, matrix);
			}
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
			// Update position and orientation based on velocities
			position_x += velocity_x * frameTime;
			position_y += velocity_y * frameTime;
			angle += velocity_angle * frameTime;
			
			// Bounds check orientation
			if (angle > 2 * Math.PI)
				angle -= 2 * Math.PI;
			if (angle < 0)
				angle += 2 * Math.PI;
		}
		
	}

}