// ************************************************************************ 
// File Name:   ColRectangle.as 
// Purpose:     Rectangle collision object
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
	public class ColRectangle extends ColShape
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// ****************************************************************
		// Function: 	ColRectangle()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object (rotation center)
		//				y:Number - y coordinate for object (rotation center)
		//				angle:Number - rotation of object
		//				width:Number - width of the object
		//				height:Number - height of the object
		// ****************************************************************
		public function ColRectangle(x:Number, y:Number, angle:Number, 
			width:Number, height:Number) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ColRectangle::ColRectangle() called: x = " + x + ", y = " 
				+ y + ", angle = " + angle + ", width = " + width 
				+ ", height = " + height, 1);
				
			// Set up ColShape
			super(x, y, angle, width, height);
			
			// Set up triangles
			var upper_left:Point = new Point(- 0.5 * width, - 0.5 * height);
			var upper_right:Point = new Point(0.5 * width, - 0.5 * height);
			var lower_left:Point = new Point(- 0.5 * width, 0.5 * height);
			var lower_right:Point = new Point(0.5 * width, 0.5 * height);
			triangles.push(new Triangle(x, y, angle, upper_left, upper_right, lower_right));
			triangles.push(new Triangle(x, y, angle, lower_right, lower_left, upper_left));
			
			CalculateRectangleBoungs();
			
			Util.Debug("ColRectangle::ColRectangle() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}