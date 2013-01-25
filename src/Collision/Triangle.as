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
			super(x, y, (2*Math.max(Math.abs(x-point1.x), Math.abs(x-point2.x), Math.abs(x-point3.x))), 
				(2*Math.max(Math.abs(y-point1.y),Math.abs(y-point2.y),Math.abs(y-point3.y))), angle, null);
			
			// Push in point values
			points.push(point1);
			points.push(point2);
			points.push(point3);
			
			// Move points based on angle
			if (angle) for (var i:int = 0; i < points.length; ++i)
			{
				var new_point:Point = new Point();
				var cos_delta:Number = Math.cos(angle);
				var sin_delta:Number = Math.sin(angle);
				new_point.x = points[i].x * cos_delta - points[i].y * sin_delta;
				new_point.y = points[i].x * sin_delta + points[i].y * cos_delta;
				points[i] = new_point;
			}
			
			// Recalculate width and height
			if (angle)
			{
				width = 2 * Math.max(Math.abs(x - points[0].x), Math.abs(x - points[1].x), Math.abs(x - points[2].x));
				height = 2 * Math.max(Math.abs(y - points[0].y), Math.abs(y - points[1].y), Math.abs(y - points[2].y));
			}
			
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
			matrix.translate(position_x, position_y);			// translate to correct location in scene
			
			// Render the image to this matrix
			Renderer.DrawToBackBuffer(image_sprite, matrix);
			
			Util.Debug("Triangle::Render() returned", 3);
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
			
			var delta:Number = (a - angle);
			
			// Recalculate point locations
			if (delta) for (var i:int = 0; i < points.length; ++i)
			{
				var new_point:Point = new Point();
				var cos_delta:Number = Math.cos(delta);
				var sin_delta:Number = Math.sin(delta);
				new_point.x = points[i].x * cos_delta - points[i].y * sin_delta;
				new_point.y = points[i].x * sin_delta + points[i].y * cos_delta;
				points[i] = new_point;
			}
			
			// Recalculate width and height
			if (delta)
			{
				width = 2 * Math.max(Math.abs(x - points[0].x), Math.abs(x - points[1].x), Math.abs(x - points[2].x));
				height = 2 * Math.max(Math.abs(y - points[0].y), Math.abs(y - points[1].y), Math.abs(y - points[2].y));
			}
			
			super.SetPosition(x, y, a);
			
			Util.Debug("Image::SetPosition() returned", 3);
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
			
			// In the case where one triangle is inside the other completely, just check ONE point for each triangle
			// Check if the point is in tri2
/*			var point1:Point = tri1.points[0]
			point1 = new Point(point1.x + tri1.position_x, point1.y + tri1.position_y);
			result = PointInTriangle(point1, new Point(tri2.points[0].x + tri2.position_x, tri2.points[0].y + tri2.position_y), 
				new Point(tri2.points[1].x + tri2.position_x, tri2.points[1].y + tri2.position_y), 
				new Point(tri1.points[2].x + tri1.position_x, tri1.points[2].y + tri1.position_y))
			// Check if the point is in tri2
			if (!result)
			{
				var point2:Point = tri1.points[0]
				point2 = new Point(point2.x + tri2.position_x, point2.y + tri2.position_y);
				result = PointInTriangle(point2, new Point(tri1.points[0].x + tri1.position_x, tri1.points[0].y + tri1.position_y), 
					new Point(tri1.points[1].x + tri1.position_x, tri1.points[1].y + tri1.position_y), 
					new Point(tri1.points[2].x + tri1.position_x, tri1.points[2].y + tri1.position_y))
			}*/
			
			// Now check for line intersections between triangle 1 and triangle 2
			var tri1_position = new Point(tri1.position_x, tri1.position_y);
			var tri2_position = new Point(tri2.position_x, tri2.position_y);
			
			if (!result) result = LinesIntersect(tri1.points[0].add(tri1_position), tri1.points[1].add(tri1_position), tri2.points[0].add(tri2_position), tri2.points[1].add(tri2_position));
			if (!result) result = LinesIntersect(tri1.points[0].add(tri1_position), tri1.points[1].add(tri1_position), tri2.points[1].add(tri2_position), tri2.points[2].add(tri2_position));
			if (!result) result = LinesIntersect(tri1.points[0].add(tri1_position), tri1.points[1].add(tri1_position), tri2.points[0].add(tri2_position), tri2.points[2].add(tri2_position));
			if (!result) result = LinesIntersect(tri1.points[2].add(tri1_position), tri1.points[1].add(tri1_position), tri2.points[0].add(tri2_position), tri2.points[1].add(tri2_position));
			if (!result) result = LinesIntersect(tri1.points[2].add(tri1_position), tri1.points[1].add(tri1_position), tri2.points[1].add(tri2_position), tri2.points[2].add(tri2_position));
			if (!result) result = LinesIntersect(tri1.points[2].add(tri1_position), tri1.points[1].add(tri1_position), tri2.points[0].add(tri2_position), tri2.points[2].add(tri2_position));
			if (!result) result = LinesIntersect(tri1.points[0].add(tri1_position), tri1.points[2].add(tri1_position), tri2.points[0].add(tri2_position), tri2.points[1].add(tri2_position));
			if (!result) result = LinesIntersect(tri1.points[0].add(tri1_position), tri1.points[2].add(tri1_position), tri2.points[1].add(tri2_position), tri2.points[2].add(tri2_position));
			if (!result) result = LinesIntersect(tri1.points[0].add(tri1_position), tri1.points[2].add(tri1_position), tri2.points[0].add(tri2_position), tri2.points[2].add(tri2_position));
			
			Util.Debug("Triangle::DetectCollision() returned: result = "+result, 3);
			Util.ChangeDebugLevel( -1);
			
			return result;
		}
		
		
	}

}