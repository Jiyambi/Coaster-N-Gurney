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
	import Collision.ColRectangle;
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
		private var m_textureAlive:Class;
		
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
			m_image = new Image(x-50, y-50, 100, 100, angle, m_textureAlive);
			m_layer = Constants.LAYER_OBSTACLES;
			
			// Set up collision
			m_collision = new ColRectangle(x, y, angle, 100, 100);
			
			Util.Debug("Box::Box() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}