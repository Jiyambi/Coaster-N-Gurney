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
	
	
    // ********************************************************************
    // Class:	MachineGun 
    // ********************************************************************
	public class MachineGun extends Gun 
	{
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		[Embed(source = '../../../resources/images/MachineGun.png')]
		private var m_texureAlive:Class;
		
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// ****************************************************************
		// Function: 	MachineGun()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				width:Number - width of object
		//				height:Number - height of object
		//				angle:Number - rotation of object
		// ****************************************************************
		public function MachineGun(x:Number, y:Number, width:Number, height:Number, angle:Number=0)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("MachineGun::MachineGun() called: x = " + x + ", y = " + y + ", width = " + width + ", height = " + height + ", angle = " + angle, 1);
			
			// Set up Gun as a Body
			super(x, y, width, height, angle);
			
			// Set up image
			m_image = new Image(x, y, Constants.BEE_WIDTH, Constants.BEE_HEIGHT, angle, m_texureAlive);
			m_layer = Constants.LAYER_ENEMIES;
			
			Util.Debug("MachineGun::MachineGun() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}