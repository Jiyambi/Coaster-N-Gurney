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
		protected var m_mouseX:Number = 0;
		protected var m_mouseY:Number = 0;
		
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
			
			// Image set up in sub classes
			
			Util.Debug("Gun::Gun() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	SetMouseLocation()
		// Purpose:     Sets the gun look at coordinates
		// Input:		mouseX:Number - mouse X coordinate
		//				mouseY:Number - mouse Y coordinate
		// ****************************************************************
		public function SetMouseLocation(mouseX:Number, mouseY:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Gun::SetMouseLocation() called: mouseX = " + mouseX +", mouseY = " + mouseY, 3);
			
			// Make sure we are actually changing mouse coordinates
			if (mouseX != m_mouseX || mouseY != m_mouseY)
			{
				
				// Record new mouse location
				m_mouseX = mouseX;
				m_mouseY = mouseY;
				
				// Update look-at for this new coordinate
				LookAt(mouseX, mouseY);
			}
				
			Util.Debug("Gun::SetMouseLocation() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	LookAt()
		// Purpose:     Sets the gun look at coordinates
		// Input:		targetX:Number - look at X coordinate
		//				targetY:Number - look at Y coordinate
		// ****************************************************************
		public function LookAt(targetX:Number, targetY:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Gun::LookAt() called: targetX = " + targetX +", targetY = " + targetY, 3);
			
			// Determine angle between this and mouse location
			// angle 0 means pointing to the right
			
			// Determine relative cartesian coordinate of target
			var relX:Number = targetX - position_x;
			var relY:Number = targetY - position_y;
			
			// Determine angle from relative coordinates
			// Angle 0 means pointing to the right
			var newAngle:Number = Math.sqrt(relX * relX + relY * relY);
			
			// Update body and image angle
			SetPosition(position_x, position_y, newAngle);
				
			Util.Debug("Gun::LookAt() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		
		
	}

}