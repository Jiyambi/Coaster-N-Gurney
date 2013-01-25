// ************************************************************************ 
// File Name:   ColTriangle.as 
// Purpose:     Triangle collision object
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
	public class ColTriangle extends ColShape
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// ****************************************************************
		// Function: 	ColTriangle()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object (rotation center)
		//				y:Number - y coordinate for object (rotation center)
		//				angle:Number - rotation of object
		//				point1:Number - point on the triangle
		//				point2:Number - point on the triangle
		//				point3:Number - point on the triangle
		// ****************************************************************
		public function ColTriangle(x:Number, y:Number, angle:Number, 
			point1:Point, point2:Point, point3:Point) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ColShape::ColShape() called: x = " + x + ", y = " 
				+ y + ", angle = " + angle + ", point1 = " + point1 
				+ ", point2 = " + point2 + ", point3 = " + point3, 1);
				
			// Set up ColShape
			super(x, y, angle, (2*Math.max(Math.abs(x-point1.x), Math.abs(x-point2.x), Math.abs(x-point3.x))), 
				(2*Math.max(Math.abs(y-point1.y),Math.abs(y-point2.y),Math.abs(y-point3.y))));
			
			// Set up triangle
			triangles.push(new Triangle(x, y, angle, point1, point2, point3));
			
			Util.Debug("ColShape::ColShape() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	SetPosition()
		// Purpose:     Sets x, y position and angle for Triangle
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				a:Number - rotation of object
		// ****************************************************************
		public override function SetPosition(x:Number, y:Number, a:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Image::SetPosition() called: x = " + x + ", y = " + y + ", angle = " + a, 3);
			
			for each (var triangle:Triangle in triangles)
			{
				triangle.SetPosition(x, y, a);
			}
			
			var delta:Number = (a - angle);
			
			if (delta)
			{
				width = triangles[0].GetWidth();
				height = triangles[0].GetHeight();
			}
			
			Util.Debug("Image::SetPosition() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}