// ************************************************************************ 
// File Name:   Collision.as 
// Purpose:     Abstract class for collision detection
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package  
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import flash.utils.getQualifiedClassName;
	
    // ********************************************************************
    // Class:	Collision 
    // ********************************************************************
	public class Collision 
	{
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		// Game unit dimmensions
		protected var width:int;				// game units
		protected var height:int;				// game units
		
		// Game world position and orientation
		protected var position_x:Number;		// game units		
		protected var position_y:Number;		// game units
		protected var angle:Number;				// radians, clockwise, 0 = right
    
		// Color of the object (used for collision outlines)
		protected var green = 0;
		protected var red = 255;
		protected var blue = 0;
		protected var alpha = 100;
		
		// ****************************************************************
		// Function: 	Collision()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				width:Number - width of object
		//				height:Number - height of object
		//				angle:Number - rotation of object
		// ****************************************************************
		public function Collision() 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Collision::Collision() called: x = " + x + ", y = " + y + ", width = " + width + ", height = " + height + ", angle = " + angle, 1);
			
			// Copy in supplied values
			this.width = width;
			this.height = height;
			this.position_x = x;
			this.position_y = y;
			this.angle = angle;
			
			Util.Debug("Collision::Collision() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function:    Render()
		// Purpose:     ABSTRACT - Draws the collision area to the screen
		// ****************************************************************
		public function Render():void {}
    
		// ****************************************************************
		// Function:    DetectCollision()
		// Purpose:     Checks if this Collision is colliding with the   
		//              supplied Collision
		// Input:       col2:Collision - Collision to be checked for 
		//					collision.
		// Output:      Boolean - true if there is a collision, false if 
		//					not
		// ****************************************************************
		public function DetectCollision(col2:Collision):Boolean 
		{
			var col1:Collision = this;
			
			// Both Rectangles
			if (getQualifiedClassName(col1) == "Collision::Rectangle" && getQualifiedClassName(col2) == "Collision::Rectangle")
			{
				
				// Case 1: No rotation
				if (col1.angle == 0 && col2.angle == 0)
				{
					return ( (col1.position_x <= (col2.position_x+col2.width)) && ((col1.position_x+col1.width) >= col2.position_x) &&
						(col1.position_y <= (col2.position_y+col2.height)) && ((col1.position_y+col1.height) >= col2.position_y) );
				}
				
				// Case 2: Rotation
				else {
					;
				}
				
			}
			
			// Both Ovals
			else if (getQualifiedClassName(col1) == "Collision::Oval" && getQualifiedClassName(col2) == "Collision::Oval")
			{
				
				// Case 1: No rotation
				if (col1.angle == 0 && col2.angle == 0)
				{
					// goal radius
					var collision_distance:Number = col1.width + col2.width; 
					// actual distance between objects
					var actual_distance_sqr:Number = Math.pow(col2.position_x-col1.position_x,2) 
											+ Math.pow(col2.position_y - col1.position_y, 2);
					
					return ( actual_distance_sqr <= collision_distance * collision_distance );
					
					return ( (col2.position_y - col1.position_y) / 
				}
				
				// Case 2: Rotation
				// For now, handled the same as we'll deal with only circles
				else {
					;
				}
				
			}
			
			// One Oval, One Rectangle
			else {
				var oval:Collision;
				var rectangle:Collision;
				if (getQualifiedClassName(col1) == "Collision::Rectangle")
				{
					rectangle = col1;
					oval = col2;
				}
				else
				{
					rectangle = col2;
					oval = col1;
				}
				
				// Case 1: No Rectangle Rotation
				if (rectangle.angle == 0 && col2.angle == 0)
				{
					// goal radius
					var collision_distance:Number = col1.width + col2.width; 
					// actual distance between objects
					var actual_distance_sqr:Number = Math.pow(col2.position_x-col1.position_x,2) 
											+ Math.pow(col2.position_y - col1.position_y, 2);
					
					return ( actual_distance_sqr <= collision_distance * collision_distance );
				}
			}
			
			
			return false;
		}
		
	}

}