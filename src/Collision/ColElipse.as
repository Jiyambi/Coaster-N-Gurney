// ************************************************************************ 
// File Name:   ColElipse.as 
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
	public class ColElipse extends ColShape
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// ****************************************************************
		// Function: 	ColElipse()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object (rotation center)
		//				y:Number - y coordinate for object (rotation center)
		//				angle:Number - rotation of object
		//				width:Number - width of the object
		//				height:Number - height of the object
		//				resolution:Number - resolution of the object
		// ****************************************************************
		public function ColElipse(x:Number, y:Number, angle:Number, 
			width:Number, height:Number, resolution:Number) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ColElipse::ColElipse() called: x = " + x + ", y = " 
				+ y + ", angle = " + angle + ", width = " + width 
				+ ", height = " + height+", resolution = "+resolution, 1);
			
			// Set up ColShape
			super(x, y, angle, width, height);
			
			// Error if res < 3
			if (resolution < 3)
				throw new Error("ColEclipse res must be equal to or greater than 3.");
			
			// Set up triangles
			var inner_point:Point = new Point(0, 0);
			var t:Number, point1:Point, point2:Point;
			for (var i:int = 0; i < resolution; ++i)
			{
				t = 2 * Math.PI * (i / resolution);
				point1 = new Point(0.5*width*Math.cos(t), 0.5*height*Math.sin(t));
				t = 2 * Math.PI * ((i+1) / resolution);
				point2 = new Point(0.5*width * Math.cos(t), 0.5*height * Math.sin(t));
				m_triangles.push(new Triangle(x, y, angle, inner_point, point1, point2));
			}
			
			// Calculate bounding box
			CalculateRectangleBounds();
			
			Util.Debug("ColElipse::ColElipse() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		
	}

}