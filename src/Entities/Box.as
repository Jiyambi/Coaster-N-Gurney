// ************************************************************************ 
// File Name:   Box.as 
// Purpose:     A simple box, for testing with collision and camera
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Entities 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Collision.ColTriangle;
	import flash.geom.Point;
	
    // ********************************************************************
    // Class:	Box 
    // ********************************************************************
	public class Box extends Body
	{
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		[Embed(source = '../../resources/images/box.png')]
		private var tex_box:Class;
		
		// ****************************************************************
		// Function: 	Player()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				angle:Number - rotation of object
		// ****************************************************************
		public function Box(x:Number, y:Number, angle:Number=0)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Box::Box() called: x = " + x + ", y = " + y + ", angle = " + angle, 1);
			
			// Set up Box as a Body
			super(x, y, 100, 100, angle);
			
			// Create image to hold sprite
			image = new Image(x-50, y-50, 100, 100, angle, tex_box);
			layer = Constants.LAYER_OBSTACLES;
			
			// Set up collision
			collision = new ColTriangle(x, y, angle, new Point( -50, 0), new Point(50, 0), new Point(0, 50));
			
			Util.Debug("Box::Box() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}