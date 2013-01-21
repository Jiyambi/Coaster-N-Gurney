// ************************************************************************ 
// File Name:   Body.as 
// Purpose:     Base game object class. Includes physics, collision, and
//				drawing for basic game object.
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package  
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.Point;
	
    // ********************************************************************
    // Class:	Body 
    // ********************************************************************
	public class Body 
	{
		
		// ****************************************************************
		// Public Data Members 
		// ****************************************************************
		public var x:Number;
		public var y:Number;
		public var width:int;
		public var height:int;
		public var angle:Number;

		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		protected var image:BitmapData;
		protected var image_sprite:Sprite;
	 
		// ****************************************************************
		// Function: 	Body()
		// Purpose:     Constructor.
		// Input:		x:int - x coordinate for object
		//				y:int - y coordinate for object
		//				width:int - width of object
		//				height:int - height of object
		//				angle:int - rotation of object
		// ****************************************************************
		public function Body(x:int, y:int, width:int, height:int, angle:int=0)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.angle = angle;
		}
		
		// ****************************************************************
		// Function: 	Render()
		// Purpose:     Draws to the stage
		// ****************************************************************
		public function Render():void
		{
		}
		
		// ****************************************************************
		// Function: 	Update()
		// Purpose:     Updates logic
		// ****************************************************************
		public function Update():void
		{
		}
		
	}

}