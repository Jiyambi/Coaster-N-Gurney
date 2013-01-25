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
			
			if (Constants.DEBUG_MODE) for each (var triangle:Triangle in triangles)
			{
				// Render the triangle
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
			var result:Boolean = true;
			
			// Check and see if these colShapes are nearby
/*			var top1:Number = col1.position_y - 0.5*col1.height;
			var top2:Number = col2.position_y - 0.5*col2.height;
			var bottom1:Number = col1.position_y + 0.5*col1.height;
			var bottom2:Number = col2.position_y + 0.5*col2.height;
			var left1:Number = col1.position_x - 0.5*col1.width;
			var left2:Number = col2.position_x - 0.5*col2.width;
			var right1:Number = col1.position_x + 0.5*col1.width;
			var right2:Number = col2.position_x + 0.5 * col2.width;
			if ( (top1 > bottom2 || bottom1 < top2 || left1 > right2 || right1 < left2 ) )
				result = false;*/
			
			// Check each trangle combination to see if any triangles are colliding
			if (result) 
			{
				result = false;
				for each (var triangle1:Triangle in col1.triangles)
				{
					for each (var triangle2:Triangle in col2.triangles)
					{
						result = result || triangle1.DetectCollision(triangle2);
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
			
			// Update triangles
			for each (var triangle:Triangle in triangles)
			{
				triangle.SetPosition(x, y, a);
			}
			
			// Height and Width will be updated here in sub-classes
			
			super.SetPosition(x, y, a);
			
			Util.Debug("Image::SetPosition() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}