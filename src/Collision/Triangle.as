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
		protected var m_points:Array = new Array();
		
		// ****************************************************************
		// Public Data Members 
		// ****************************************************************
		
		// Bounding box
		public var m_top:Number;
		public var m_bottom:Number;
		public var m_left:Number;
		public var m_right:Number;
		
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
			m_points.push(point1);
			m_points.push(point2);
			m_points.push(point3);
			
			// Move points based on angle
			if (angle)  
			{
				var cos_delta:Number = Math.cos(angle);
				var sin_delta:Number = Math.sin(angle);
				for (var i:int = 0; i < m_points.length; ++i)
				{
					var new_point:Point = new Point();
					new_point.x = m_points[i].x * cos_delta - m_points[i].y * sin_delta;
					new_point.y = m_points[i].x * sin_delta + m_points[i].y * cos_delta;
					m_points[i] = new_point;
				}
			}
			
			// Recalculate top, bottom, left, right
			m_top = Math.min(m_points[0].y, m_points[1].y, m_points[2].y);
			m_bottom = Math.max(m_points[0].y, m_points[1].y, m_points[2].y);
			m_left = Math.min(m_points[0].x, m_points[1].x, m_points[2].x);
			m_right = Math.max(m_points[0].x, m_points[1].x, m_points[2].x);
			m_height = m_bottom - m_top;
			m_width = m_right - m_left;
			
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
			m_imageSprite = new Sprite();
			m_imageSprite.graphics.lineStyle(0);
			m_imageSprite.graphics.beginFill(color,0.5);
			m_imageSprite.graphics.moveTo(m_points[0].x, m_points[0].y);
			m_imageSprite.graphics.lineTo(m_points[1].x, m_points[1].y);
			m_imageSprite.graphics.lineTo(m_points[2].x, m_points[2].y);
			m_imageSprite.graphics.lineTo(m_points[0].x, m_points[0].y);
			m_imageSprite.graphics.endFill();
			
			// Draw background square
			m_imageSprite.graphics.lineStyle(0);
			m_imageSprite.graphics.beginFill(0xFFFFFF,0.2);
			m_imageSprite.graphics.moveTo(m_left, m_top);
			m_imageSprite.graphics.lineTo(m_right, m_top);
			m_imageSprite.graphics.lineTo(m_right, m_bottom);
			m_imageSprite.graphics.lineTo(m_left, m_bottom);
			m_imageSprite.graphics.endFill();
			
			// transform sprite to correct location
			var matrix:Matrix = new Matrix();
			matrix.translate(m_positionX, m_positionY);			// translate to correct location in scene
			
			// Render the image to this matrix
			Renderer.DrawToBackBuffer(m_imageSprite, matrix);
			
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
			Util.Debug("Triangle::SetPosition() called: x = " + x + ", y = " + y + ", angle = " + a, 3);
			
			var delta:Number = (a - m_angle);
			
			// Recalculate point locations
			if (delta) 
			{
				for (var i:int = 0; i < m_points.length; ++i)
				{
					var new_point:Point = new Point();
					var cos_delta:Number = Math.cos(delta);
					var sin_delta:Number = Math.sin(delta);
					new_point.x = m_points[i].x * cos_delta - m_points[i].y * sin_delta;
					new_point.y = m_points[i].x * sin_delta + m_points[i].y * cos_delta;
					m_points[i] = new_point;
				}
				
				// Recalculate top, bottom, left, right
				m_top = Math.min(m_points[0].y, m_points[1].y, m_points[2].y);
				m_bottom = Math.max(m_points[0].y, m_points[1].y, m_points[2].y);
				m_left = Math.min(m_points[0].x, m_points[1].x, m_points[2].x);
				m_right = Math.max(m_points[0].x, m_points[1].x, m_points[2].x);
				
				// Recalculate hieght and width
				m_height = m_bottom - m_top;
				m_width = m_right - m_left;
			}
			
			super.SetPosition(x, y, a);
			
			Util.Debug("Triangle::SetPosition() returned", 3);
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
			var result:Boolean = true;
			
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
			
			var tri1_position:Point = new Point(tri1.m_positionX, tri1.m_positionY);
			var tri2_position:Point = new Point(tri2.m_positionX, tri2.m_positionY);
			
			// Check and see if these colShapes are within their outer rectangle bound
			if ( tri1.m_top + tri1.m_positionY > tri2.m_bottom + tri2.m_positionY
				|| tri1.m_bottom + tri1.m_positionY < tri2.m_top + tri2.m_positionY
				|| tri1.m_left + tri1.m_positionX > tri2.m_right + tri2.m_positionX
				|| tri1.m_right + tri1.m_positionX < tri2.m_left + tri2.m_positionX )
					result = false;
			
			if (result)
			{
				// Change to a default of false
				result = false;
				
				// In the case where one triangle is inside the other completely, just check ONE point for each triangle
				// Check if the point is in tri2
				var point1:Point = tri1.m_points[0].add(tri1_position);
				result = PointInTriangle(point1, tri2.m_points[0].add(tri2_position), tri2.m_points[1].add(tri2_position), tri2.m_points[2].add(tri2_position))
				// Check if the point is in tri2
				if (!result)
				{
					var point2:Point = tri2.m_points[0].add(tri2_position);
					result = PointInTriangle(point2, tri1.m_points[0].add(tri1_position), tri1.m_points[1].add(tri1_position), tri1.m_points[2].add(tri1_position))
				}
			
				// Now check for line intersections between triangle 1 and triangle 2
				if (!result) result = LinesIntersect(tri1.m_points[0].add(tri1_position), tri1.m_points[1].add(tri1_position), tri2.m_points[0].add(tri2_position), tri2.m_points[1].add(tri2_position));
				if (!result) result = LinesIntersect(tri1.m_points[0].add(tri1_position), tri1.m_points[1].add(tri1_position), tri2.m_points[1].add(tri2_position), tri2.m_points[2].add(tri2_position));
				if (!result) result = LinesIntersect(tri1.m_points[0].add(tri1_position), tri1.m_points[1].add(tri1_position), tri2.m_points[0].add(tri2_position), tri2.m_points[2].add(tri2_position));
				if (!result) result = LinesIntersect(tri1.m_points[2].add(tri1_position), tri1.m_points[1].add(tri1_position), tri2.m_points[0].add(tri2_position), tri2.m_points[1].add(tri2_position));
				if (!result) result = LinesIntersect(tri1.m_points[2].add(tri1_position), tri1.m_points[1].add(tri1_position), tri2.m_points[1].add(tri2_position), tri2.m_points[2].add(tri2_position));
				if (!result) result = LinesIntersect(tri1.m_points[2].add(tri1_position), tri1.m_points[1].add(tri1_position), tri2.m_points[0].add(tri2_position), tri2.m_points[2].add(tri2_position));
				if (!result) result = LinesIntersect(tri1.m_points[0].add(tri1_position), tri1.m_points[2].add(tri1_position), tri2.m_points[0].add(tri2_position), tri2.m_points[1].add(tri2_position));
				if (!result) result = LinesIntersect(tri1.m_points[0].add(tri1_position), tri1.m_points[2].add(tri1_position), tri2.m_points[1].add(tri2_position), tri2.m_points[2].add(tri2_position));
				if (!result) result = LinesIntersect(tri1.m_points[0].add(tri1_position), tri1.m_points[2].add(tri1_position), tri2.m_points[0].add(tri2_position), tri2.m_points[2].add(tri2_position));
				
			}
			
			Util.Debug("Triangle::DetectCollision() returned: result = "+result, 3);
			Util.ChangeDebugLevel( -1);
			
			return result;
		}
		
		
	}

}