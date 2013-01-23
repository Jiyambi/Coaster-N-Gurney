// ************************************************************************ 
// File Name:   Camera.as 
// Purpose:     Governs camera location in game world and field of view
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

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
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				width:Number - width of camera view
		//				height:Number - height of camera view
		//				angle:Number - rotation of object
		// ****************************************************************
		public function Camera(x:Number, y:Number, width:Number, height:Number, angle:Number=0) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Camera::Camera() called: x = " + x + ", y = " + y + ", width = " + width + ", height = " + height + ", angle = " + angle, 1);
			
			super(x, y, width, height, angle);
			
			Util.Debug("Camera::Camera() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	GetWidth()
		// Purpose:     Returns width.
		// Output:		return:int - width.
		// ****************************************************************
		public function GetWidth():int
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Camera::GetWidth() called", 3);
			Util.Debug("Camera::GetWidth() returned, result = "+width, 3);
			Util.ChangeDebugLevel( -1);
			
			return width;
		}
		
		// ****************************************************************
		// Function: 	GetHeight()
		// Purpose:     Returns height.
		// Output:		return:int - height.
		// ****************************************************************
		public function GetHeight():int
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Camera::GetHeight() called", 3);
			Util.Debug("Camera::GetHeight() returned, result = "+height, 3);
			Util.ChangeDebugLevel( -1);
			
			return height;
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
			Util.Debug("Camera::GetX() returned, result = "+position_x, 3);
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
			Util.Debug("Camera::GetY() returned, result = "+position_y, 3);
			Util.ChangeDebugLevel( -1);
			
			return position_y;
		}
		
		// ****************************************************************
		// Function: 	GetAngle()
		// Purpose:     Returns angle.
		// Output:		return:Number - angle.
		// ****************************************************************
		public function GetAngle():Number
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Camera::GetAngle() called", 3);
			Util.Debug("Camera::GetAngle() returned, result = "+angle, 3);
			Util.ChangeDebugLevel( -1);
			
			return angle;
		}
		
	}

}