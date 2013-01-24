// ************************************************************************ 
// File Name:   ColShape.as 
// Purpose:     Abstract class for collision detection
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Collision
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import flash.geom.Point;
	
    // ********************************************************************
    // Class:	Collision 
    // ********************************************************************
	public class ColShape 
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// Game world position, rotation center, and orientation
		protected var position_x:Number;		// game units		
		protected var position_y:Number;		// game units
		protected var rotation_x:Number;		// game units		
		protected var rotation_y:Number;		// game units
		protected var angle:Number;				// radians, clockwise
		
		// Set of triangles making up this ColShape
		protected var triangles:Array = new Array();
		
		// Triangle points
		protected var point1:Point;
		protected var point2:Point;
		protected var point3:Point;
    
		// Color of the object (used for collision outlines)
		protected var green = 0;
		protected var red = 255;
		protected var blue = 0;
		protected var alpha = 100;
		
		// ****************************************************************
		// Function: 	ColShape()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object (rotation center)
		//				y:Number - y coordinate for object (rotation center)
		//				angle:Number - rotation of object
		//				point1:Number - point on the triangle
		//				point2:Number - point on the triangle
		//				point3:Number - point on the triangle
		// ****************************************************************
		public function ColShape(x:Number, y:Number, angle:Number, 
			point1:Point, point2:Point, point3:Point) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ColShape::ColShape() called: x = " + x + ", y = " 
				+ y + ", angle = " + angle + ", point1 = " + point1 
				+ ", point2 = " + point2 + ", point3 = " + point3, 1);
			
			// Copy in supplied values
			this.rotation_x = x;
			this.rotation_y = y;
			this.angle = angle;
			this.point1 = point1;
			this.point2 = point2;
			this.point3 = point3;
			
			Util.Debug("ColShape::ColShape() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function:    Render()
		// Purpose:     ABSTRACT - Draws the ColShape area to the screen
		// ****************************************************************
		public function Render():void {}
    
		// ****************************************************************
		// Function:    DetectCollision()
		// Purpose:     Checks if this ColShape is colliding with the   
		//              supplied ColShape
		// Input:       col2:ColShape - Collision to be checked for 
		//					collision.
		// Output:      Boolean - true if there is a collision, false if 
		//					not
		// ****************************************************************
		public function DetectCollision(col2:ColShape):Boolean 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ColShape::DetectCollision() called: col2 = " + col2, 3);
				
			var col1:ColShape = this;
			var result = false;
			
			// Check each trangle combination to see if any triangles are colliding
			for each (var triangle1:Triangle in col1.triangles)
			{
				for each (var triangle2:Triangle in col2.triangles)
				{
					result = result || triangle1.DetectCollision(triangle2);
				}
			}
			
			// TODO: If there was a collision, set the color for these ColShapes to red
			
			Util.Debug("ColShape::DetectCollision() returned, result = " + result, 3);
			Util.ChangeDebugLevel(-1);
			
			return result;
		}
		
	}

}