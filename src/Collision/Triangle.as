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
	
    // ********************************************************************
    // Class:	Collision 
    // ********************************************************************
	public class Triangle 
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
			
			// Copy in supplied values
			this.position_x = x;
			this.position_y = y;
			this.angle = angle;
			points.push(point1);
			points.push(point2);
			points.push(point3);
			
			Util.Debug("Triangle::Triangle() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function:    Render()
		// Purpose:     Draws the ColShape area to the screen
		// Inputs:		Color the triangle should be drawn in
		// ****************************************************************
		public function Render(color:uint):void 
		{
			// TODO: Triangle collision shape drawn to screen
			// TODO: Get color from parent ColShape
			this.graphics.lineStyle(0);
			this.graphics.beginFill(_color);
			this.graphics.moveTo(position_x+points[0].x, position_y+points[0].y);
			this.graphics.lineTo(position_x+points[1].x, position_y+points[1].y);
			this.graphics.lineTo(position_x+points[2].x, position_y+points[2].y);
			this.graphics.lineTo(position_x+points[0].x, position_y+points[0].y);
			this.graphics.endFill();
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
			var tri1:Triangle = this;
			var result:Boolean = false;
			
			// TODO: Finish triangle collision detection (line intersection)
			
			// Checks if point 1 is on the same side of ab as point 2
			function SameSide(p1:Point, p2:Point, a:Point, b:Point):Boolean
			{
				var ab:Vector3D = new Vector3D((b.subtract(a)).x,(b.subtract(a)).y,0);
				var ap1:Vector3D = new Vector3D((p1.subtract(a)).x,(p1.subtract(a)).y,0);
				var ap2:Vector3D = new Vector3D((p2.subtract(a)).x,(p2.subtract(a)).y,0);
				
				var cp1:Vector3D = ab.crossProduct(ap1);
				var cp2:Vector3D = ab.crossProduct(ap2);
				
				if (cp1.dotProduct(cp2) >= 0) return true;
				else return false;
			}
			
			// Checks if the supplied point is in the triangle
			function PointInTriangle(p:Point, a:Point, b:Point, c:Point):Boolean
			{
				if (SameSide(p,a, b,c) && SameSide(p,b, a,c)
					&& SameSide(p, c, a, b)) return true;
				else return false;
			}
			
			// Checks if the supplied point (that IS on the line) is on the segment
			function PointOnSegment(p:Point, a:Point, b:Point):Boolean
			{
				return ( (min(a.x,b.x) <= p.x <= max(a.x,b.x)) && (min(a.y,b.y) <= p.y <= max(a.y,b.y)) );
			}
			
			// Checks if the supplied line segments intersect
			function LinesIntersect(a1:Point, a2:Point, b1:Point, b2:Point):Boolean
			{
				var aA:Number = a2.y - a1.y;
				var aB:Number = a1.x - a2.x;
				var aC:Number = aA * a1.x - aB * a1.y;
				var bA:Number = b2.y - b1.y;
				var bB:Number = b1.x - b2.x;
				var bC:Number = bA * b1.x - bB * b1.y;
				
				// Check if lines intersect
				var det:Number = aA * bB - bA * aB;
				if (det == 0)
					// Lines are parallel
					return false;
				else
				{
					// Determine intersection point for two infinite lines
					var x:Number = (bB * aC - aB * bC) / det;
					var y:Number = (aA * bC - bA * aC) / det;
					var p:Point = new Point(x, y);
					
					// Determine if point is on both segments
					return ( PointOnSegment(p,a1,a2) && PointOnSegment(p,b1,b2) );
				}
			}
			
			// Loop through the points in each triangle, check if they are inside the other triangle
			for each (var point1:Point in tri1.points)
			{
				// Check if the point is in tri2
				result = result || PointInTriangle(point1, tri2.points[0], tri2.points[1], tri2.points[2])
				if (result) break; // Found a collision, no need to keep checking
			}
			if (!result) for each (var point1:Point in tri2.points)
			{
				// Check if the point is in tri2
				result = result || PointInTriangle(point1, tri1.points[0], tri1.points[1], tri1.points[2])
				if (result) break; // Found a collision, no need to keep checking
			}
			
			// Now check for line intersections between triangle 1 and triangle 2
			if (!result) for each (var point11:Point in tri1.points)
			{
				for each (var point12:Point in tri1.points)
				{
					// If we are looking at a segment between a point and itself, skip this iteration
					if (point11 == point12) continue;
					for each (var point21:Point in tri2.points)
					{
						for each (var point22:Point in tri2.points)
						{
							// If we are looking at a segment between a point and itself, skip this iteration
							if (point21 == point22) continue;
							
							// Check if the two line segments intersect
							result = result || LinesIntersect(point11, point12, point21, point22);
							if (result) break; // Found a collision, no need to keep checking
						}
						if (result) break; // Found a collision, no need to keep checking
					}
					if (result) break; // Found a collision, no need to keep checking
				}
				if (result) break; // Found a collision, no need to keep checking
			}
						
			return result;
		}
		
	}

}