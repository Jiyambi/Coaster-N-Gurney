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
	import flash.geom.Vector3D;
    import flash.display.BitmapData;
    import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
    // ********************************************************************
    // Class:	Collision 
    // ********************************************************************
	public class Triangle extends Image
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// Triangle points
		protected var points:Array = new Array();
		
		// ****************************************************************
		// Function: 	Triangle()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object (rotation center)
		//				y:Number - y coordinate for object (rotation center)
		//				angle:Number - rotation of object
		//				point1:Number - point on the triangle
		//				point2:Number - point on the triangle
		//				point3:Number - point on the triangle
		// ****************************************************************
		public function Triangle(x:Number, y:Number, angle:Number, 
			point1:Point, point2:Point, point3:Point) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Triangle::Triangle() called: x = " + x + ", y = " 
				+ y + ", angle = " + angle + ", point1 = " + point1 
				+ ", point2 = " + point2 + ", point3 = " + point3, 1);
			
			// Set up as Image
			super(x, y, Math.max(point1.x, point2.x, point3.x) - Math.min(point1.x, point2.x, point3.x),
				Math.max(point1.y,point2.y,point3.y)-Math.min(point1.y,point2.y,point3.y), angle, null)
			
			// Push in parent values
			points.push(point1);
			points.push(point2);
			points.push(point3);
			
			Util.Debug("Triangle::Triangle() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function:    RenderColor()
		// Purpose:     Draws the ColShape area to the screen
		// Inputs:		color:uint Color the triangle should be drawn in
		// ****************************************************************
		public function RenderColor(color:uint):void 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Triangle::Render() called: color = " + color, 3);
				
			// Draw sprite with position as origin
			image_sprite = new Sprite();
			image_sprite.graphics.lineStyle(0);
			image_sprite.graphics.beginFill(color,0.5);
			image_sprite.graphics.moveTo(points[0].x, points[0].y);
			image_sprite.graphics.lineTo(points[1].x, points[1].y);
			image_sprite.graphics.lineTo(points[2].x, points[2].y);
			image_sprite.graphics.lineTo(points[0].x, points[0].y);
			image_sprite.graphics.endFill();
			
			// transform sprite to correct location
			var matrix:Matrix = new Matrix();
			matrix.rotate(angle);								// rotate about origin
			matrix.translate(position_x, position_y);			// translate to correct location in scene
			
			// Render the image to this matrix
			Renderer.DrawToBackBuffer(image_sprite, matrix);
			
			Util.Debug("Triangle::Render() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
    
		// ****************************************************************
		// Function:    DetectCollision()
		// Purpose:     Checks if this ColShape is colliding with the   
		//              supplied ColShape
		// Input:       tri2:ColShape - Collision to be checked for 
		//					collision.
		// Output:      Boolean - true if there is a collision, false if 
		//					not
		// ****************************************************************
		public function DetectCollision(tri2:Triangle):Boolean 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Triangle::DetectCollision() called: tri2 = " + tri2, 3);
			
			var tri1:Triangle = this;
			var result:Boolean = false;
			
			// Checks if the supplied point is in the triangle
			function PointInTriangle(p:Point, a:Point, b:Point, c:Point):Boolean
			{
				Util.ChangeDebugLevel(1);
				Util.Debug("Triangle::PointInTriangle() called: p = " + p + ", a = " +a + ", b = " + b + ", c = " + c, 3);
				
				var result:Boolean = true;
				
				var as_x:Number = p.x-a.x;
				var as_y:Number = p.y-a.y;

				var s_ab:Boolean = (b.x-a.x)*as_y-(b.y-a.y)*as_x > 0;

				if(result && (c.x-a.x)*as_y-(c.y-a.y)*as_x > 0 == s_ab) result = false;

				if(result && (c.x-b.x)*(p.y-b.y)-(c.y-b.y)*(p.x-b.x) > 0 != s_ab) result = false;
					
					
				Util.Debug("Triangle::PointInTriangle() returned: result = "+result, 3);
				Util.ChangeDebugLevel( -1);
				
				return result;
			}
			
			// Checks if the supplied line segments intersect
			function LinesIntersect(A1:Point, A2:Point, B1:Point, B2:Point):Boolean
			{
				Util.ChangeDebugLevel(1);
				Util.Debug("Triangle::LinesIntersect() called: A1 = " + A1 + ", A2 = " +A2 + ", B1 = " + B1 + ", B2 = " + B2, 3);
				
				var slopeA:Number;
				var slopeB:Number;
				var constA:Number;
				var constB:Number;
				var intersect:Point = new Point();
				var result:Boolean = true;
				
				// Calculate the slope for each line
				if (A2.x - A1.x == 0) slopeA = Number.MAX_VALUE;
				else slopeA = (A2.y - A1.y) / (A2.x - A1.x);
				if (B2.x - B1.x == 0) slopeB = Number.MAX_VALUE;
				else slopeB = (B2.y - B1.y) / (B2.x - B1.x);
				
				// Parallel line case
				if (slopeA == slopeB)
					result = false;
					
				// Infinite lines DO intersect
				else
				{
					constA = A1.y - slopeA * A1.x;
					constB = B1.y - slopeB * B1.x;
					
					// Determine point of intersection
					intersect.x = (constB - constA) / (slopeA - slopeB);
					intersect.y = slopeA * intersect.x + constA;
					
					// Case where intersection is not on the line segments
					if ( intersect.x > Math.max(A1.x, A2.x) 
						|| intersect.x < Math.min(A1.x, A2.x) 
						|| intersect.x > Math.max(B1.x, B2.x)
						|| intersect.x < Math.min(B1.x, B2.x) )
						result = false;
				}
				
				Util.Debug("Triangle::LinesIntersect() returned: result = "+result, 3);
				Util.ChangeDebugLevel( -1);
				
				return result;
			}
			
			// Loop through the points in each triangle, check if they are inside the other triangle
			// TODO: Apply rotation to triangle
			for each (var point1:Point in tri1.points)
			{
				// Check if the point is in tri2
				point1 = new Point(point1.x + tri1.position_x, point1.y + tri1.position_y);
				result = PointInTriangle(point1, new Point(tri2.points[0].x + tri2.position_x, tri2.points[0].y + tri2.position_y), 
					new Point(tri2.points[1].x + tri2.position_x, tri2.points[1].y + tri2.position_y), 
					new Point(tri2.points[2].x + tri2.position_x, tri2.points[2].y + tri2.position_y))
				if (result) break; // Found a collision, no need to keep checking
			}
			if (!result) for each (var point2:Point in tri2.points)
			{
				// Check if the point is in tri2
				point2 = new Point(point2.x + tri2.position_x, point2.y + tri2.position_y);
				result = PointInTriangle(point2, new Point(tri1.points[0].x + tri1.position_x, tri1.points[0].y + tri1.position_y), 
					new Point(tri1.points[1].x + tri1.position_x, tri1.points[1].y + tri1.position_y), 
					new Point(tri1.points[2].x + tri1.position_x, tri1.points[2].y + tri1.position_y))
				if (result) break; // Found a collision, no need to keep checking
			}
			
			// Now check for line intersections between triangle 1 and triangle 2
			// TODO: Apply rotation to triangle
			if (!result) for each (var point11:Point in tri1.points)
			{
				point11 = new Point(point11.x + tri1.position_x, point11.y + tri1.position_y);
				for each (var point12:Point in tri1.points)
				{
					// If we are looking at a segment between a point and itself, skip this iteration
					point12 = new Point(point12.x + tri1.position_x, point12.y + tri1.position_y);
					if (point11 == point12) continue;
					for each (var point21:Point in tri2.points)
					{
						point21 = new Point(point21.x + tri2.position_x, point21.y + tri2.position_y);
						for each (var point22:Point in tri2.points)
						{
							// If we are looking at a segment between a point and itself, skip this iteration
							point22 = new Point(point22.x + tri2.position_x, point22.y + tri2.position_y);
							if (point21 == point22) continue;
							
							// Check if the two line segments intersect
							result = LinesIntersect(point11, point12, point21, point22);
							if (result) break; // Found a collision, no need to keep checking
						}
						if (result) break; // Found a collision, no need to keep checking
					}
					if (result) break; // Found a collision, no need to keep checking
				}
				if (result) break; // Found a collision, no need to keep checking
			}
						
			Util.Debug("Triangle::DetectCollision() returned: result = "+result, 3);
			Util.ChangeDebugLevel( -1);
			
			return result;
		}
		
	}

}