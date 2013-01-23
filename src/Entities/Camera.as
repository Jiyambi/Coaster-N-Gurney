// ************************************************************************ 
// File Name:   Camera.as 
// Purpose:     Governs camera location in game world and field of view
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 
// TODO: Scaling
// TODO: Fix angle

package Entities 
{
	
    // ********************************************************************
    // Class:	Camera 
    // ********************************************************************
	public class Camera extends Body 
	{
		
		// ****************************************************************
		// Function: 	Camera()
		// Purpose:     Constructor.
		// Input:		x:int - x coordinate for object
		//				y:int - y coordinate for object
		//				angle:int - rotation of object
		// ****************************************************************
		public function Camera(x:int, y:int, width:int, height:int, angle:int=0) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Camera::Camera() called: x = " + x + ", y = " + y + ", width = " + width + ", height = " + height + ", angle = " + angle, 1);
			
			super(x, y, width, height, angle);
			
			Util.Debug("Camera::Camera() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	GetX()
		// Purpose:     Returns position_x.
		// Output:		return:int - position_x.
		// ****************************************************************
		public function GetX():int
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Camera::GetX() called", 3);
			Util.Debug("Camera::Camera() returned, result = "+position_x, 3);
			Util.ChangeDebugLevel( -1);
			
			return position_x;
		}
		
		// ****************************************************************
		// Function: 	GetY()
		// Purpose:     Returns position_y.
		// Output:		return:int - position_y.
		// ****************************************************************
		public function GetY():int
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Camera::GetY() called", 3);
			Util.Debug("Camera::Camera() returned, result = "+position_y, 3);
			Util.ChangeDebugLevel( -1);
			
			return position_y;
		}
		
		// ****************************************************************
		// Function: 	GetAngle()
		// Purpose:     Returns angle.
		// Output:		return:int - angle.
		// ****************************************************************
		public function GetAngle():int
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Camera::Returns() called", 3);
			Util.Debug("Camera::Camera() returned, result = "+angle, 3);
			Util.ChangeDebugLevel( -1);
			
			return angle;
		}
		
	}

}