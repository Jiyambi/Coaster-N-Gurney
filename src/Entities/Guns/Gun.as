// ************************************************************************ 
// File Name:   Gun.as 
// Purpose:     Base class for all guns
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Entities.Guns 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Entities.Body;
	
	
    // ********************************************************************
    // Class:	Gun 
    // ********************************************************************
	public class Gun extends Body
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// ****************************************************************
		// Function: 	Gun()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				width:Number - width of object
		//				height:Number - height of object
		//				angle:Number - rotation of object
		// ****************************************************************
		public function Gun(x:Number, y:Number, width:Number, height:Number, angle:Number=0)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Gun::Gun() called: x = " + x + ", y = " + y + ", width = " + width + ", height = " + height + ", angle = " + angle, 1);
			
			// Set up Gun as a Body
			super(x, y, width, height, angle);
			
			// Image set up in base class
			
			Util.Debug("Gun::Gun() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		
		
	}

}