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
	public class ColShape extends Image
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// Set of triangles making up this ColShape
		protected var triangles:Array = new Array();
		
		// Color of the object (used for collision outlines)
		protected var color:uint = 0x00FF00;
		
		// Array of things colliding with this
		protected var colliding:Array = new Array();
		
		// Rectangle bounds of this colshape
		protected var top:Number = 0;
		protected var bottom:Number = 0;
		protected var left:Number = 0;
		protected var right:Number = 0;
		
		// ****************************************************************
		// Function: 	ColShape()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object (rotation center)
		//				y:Number - y coordinate for object (rotation center)
		//				angle:Number - rotation of object
		//				width:int - width of object
		//				height:int - height of object
		// ****************************************************************
		public function ColShape(x:Number, y:Number, angle:Number, width:int, height:int) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ColShape::ColShape() called: x = " + x + ", y = " 
				+ y + ", angle = " + angle+ ", width = " + width+ ", height = " + height, 1);
			
			// Set up as Image
			super(x, y, width, height, angle, null)
			
			Util.Debug("ColShape::ColShape() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function:    CalculateRectangleBoungs()
		// Purpose:     Re-calculates the rectangle bounds
		// ****************************************************************
		protected function CalculateRectangleBoungs():void 
		{
			top = 0;
			bottom = 0;
			left = 0;
			right = 0;
			for each (var triangle:Triangle in triangles)
			{
				top = Math.min(top,triangle.top);
				bottom = Math.max(bottom,triangle.bottom);
				left = Math.min(left,triangle.left);
				right = Math.max(right,triangle.right);
			}
			height = bottom - top;
			width = right - left;
		}
		
		// ****************************************************************
		// Function:    Render()
		// Purpose:     Draws the ColShape area to the screen
		// ****************************************************************
		public override function Render():void 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ColShape::Render() called", 3);
			
			if (Constants.DEBUG_MODE) 
			{
				for each (var triangle:Triangle in triangles)
				{
					// Render the triangle
					triangle.RenderColor(color);
				}
				
				// Render rectangle bound
				//image_sprite = new Sprite();
				//image_sprite.graphics.lineStyle(0);
				//image_sprite.graphics.beginFill(0xfbd685,0.2);
				//image_sprite.graphics.moveTo(left, top);
				//image_sprite.graphics.lineTo(right, top);
				//image_sprite.graphics.lineTo(right, bottom);
				//image_sprite.graphics.lineTo(left, bottom);
				//image_sprite.graphics.endFill();
				//
				// transform sprite to correct location
				//var matrix:Matrix = new Matrix();
				//matrix.translate(position_x, position_y);			// translate to correct location in scene
				//
				//Util.Debug("ColShape::Render() rendering outer rectangle bound at position_x = "+position_x+" and position_y = "+position_y, 3);
				//
				// Render the image to this matrix
				//Renderer.DrawToBackBuffer(image_sprite, matrix);
				
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
			var result:Boolean = true;
			
			// Check and see if these colShapes are within their outer rectangle bound
			if ( col1.top + col1.position_y > col2.bottom + col2.position_y
				|| col1.bottom + col1.position_y < col2.top + col2.position_y
				|| col1.left + col1.position_x > col2.right + col2.position_x
				|| col1.right+col1.position_x < col2.left + col2.position_x )
					result = false;
			
			// Check each trangle combination to see if any triangles are colliding
			if (result) 
			{
				result = false;
				for each (var triangle1:Triangle in col1.triangles)
				{
					for each (var triangle2:Triangle in col2.triangles)
					{
						result = triangle1.DetectCollision(triangle2);
						if (result) break;
					}
					if (result) break;
				}
			}
		
			// Set colliding status for these ColShapes
			col1.SetCollision(col2, result);
			col2.SetCollision(col1, result);
			
			Util.Debug("ColShape::DetectCollision() returned, result = " + result, 3);
			Util.ChangeDebugLevel(-1);
			
			return result;
		}
    
		// ****************************************************************
		// Function:    SetCollision()
		// Purpose:     Checks if this ColShape is colliding with the   
		//              supplied ColShape
		// Input:       col:ColShape - Thing we are colliding with
		// Input:		result:Boolean - whether we are colliding or not
		// ****************************************************************
		public function SetCollision(col:ColShape, result:Boolean):void 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ColShape::SetCollision() called: col = " + col + ", result = " + result, 3);
			
			// Check if the list of things we are colliding with contains col2
			var present:Boolean = false;
			var index:int = -1;
			for (var i:int = 0; i < colliding.length; ++i)
			{
				if (colliding[i] == col) 
				{
					index = i;
					present = true;
				}
			}
			
			// If we are colliding....
			if (result)
			{
				// We are colliding, so set color to red
				color = 0xFF0000;
				
				// If the list of things we are colliding with does not contain col2...
				if ( !present ) colliding.push(col);
			}
			// If we aren't colliding...
			else
			{
				// If there is no collision at all happening...
				if (colliding.length == 0) color = 0x00FF00;
				
				// If this collision was present in the list, remove it
				if (present)
				{
					colliding.splice(index, 1);
				}
			}
			
			Util.Debug("ColShape::SetCollision() returned", 3);
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
			
			// Set overal shape position
			var delta:Number = (a - angle);
			super.SetPosition(x, y, a);
			
			// Update triangles
			for each (var triangle:Triangle in triangles)
			{
				triangle.SetPosition(x, y, a);
			}
			
			// Recalculate rectangle bounds if needed
			if (delta) CalculateRectangleBoungs();
			
			Util.Debug("Image::SetPosition() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}