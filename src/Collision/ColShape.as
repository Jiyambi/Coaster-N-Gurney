// ************************************************************************ 
// File Name:   ColShape.as 
// Purpose:     Abstract class for collision detection
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 
// TODO: haven't checked collision detection yet. Need to get color change working
package Collision
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import flash.geom.Point;
	
    // ********************************************************************
    // Class:	Collision 
    // ********************************************************************
	public class ColShape extends Image
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// Set of triangles making up this ColShape
		protected var triangles:Array = new Array();
		
		// Color of the object (used for collision outlines)
		protected var color:uint = 0x00FF00;
		
		// ****************************************************************
		// Function: 	ColShape()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object (rotation center)
		//				y:Number - y coordinate for object (rotation center)
		//				angle:Number - rotation of object
		// ****************************************************************
		public function ColShape(x:Number, y:Number, angle:Number) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ColShape::ColShape() called: x = " + x + ", y = " 
				+ y + ", angle = " + angle, 1);
			
			// Set up as Image
			super(x, y, 0, 0, angle, null)
			
			// Copy in supplied values
			this.position_x = x;
			this.position_y = y;
			this.angle = angle;
			
			Util.Debug("ColShape::ColShape() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function:    Render()
		// Purpose:     Draws the ColShape area to the screen
		// ****************************************************************
		public override function Render():void 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ColShape::Render() called", 3);
			
			for each (var triangle:Triangle in triangles)
			{
				triangle.RenderColor(color);
			}
			
			Util.Debug("ColShape::Render() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
    
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
			var result:Boolean = false;
			
			// Check each trangle combination to see if any triangles are colliding
			for each (var triangle1:Triangle in col1.triangles)
			{
				for each (var triangle2:Triangle in col2.triangles)
				{
					result = result || triangle1.DetectCollision(triangle2);
				}
			}
			
			// Change color if colliding
			// TODO: Currently will change back to green if ANYTHING is NOT colliding
			// Need to figure out WHAT is colliding and change to green if we are no
			// longer colliding with it.
			if (result)
				color = 0xFF0000;
			else
				color = 0x00FF00;
			
			Util.Debug("ColShape::DetectCollision() returned, result = " + result, 3);
			Util.ChangeDebugLevel(-1);
			
			return result;
		}
		
	}

}