// ************************************************************************ 
// File Name:   Bee.as 
// Purpose:     Sample enemy, AI is pattern movement
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Entities 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import flash.geom.Point;
	import Collision.ColElipse;
	
    // ********************************************************************
    // Class:	Bee 
    // ********************************************************************
	public class Bee extends Enemy
	{
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		[Embed(source = '../../resources/images/bee.png')]
		private var tex_bee:Class;
		
		
		// ****************************************************************
		// Function: 	Bee()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				angle:Number - rotation of object
		// ****************************************************************
		public function Bee(x:Number, y:Number, angle:Number=0)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Bee::Bee() called: x = " + x + ", y = " + y + ", angle = " + angle, 1);
			
			// Set up Bee as an Enemy
			super(x, y, Constants.BEE_WIDTH, Constants.BEE_HEIGHT, angle-90);
			
			// Create image to hold sprite
			image = new Image(x, y, Constants.BEE_WIDTH, Constants.BEE_HEIGHT, angle-90, tex_bee);
			layer = Constants.LAYER_ENEMIES;
			
			// Set up collision
			collision = new ColElipse(x, y, angle-90, Constants.BEE_WIDTH*1.10, Constants.BEE_HEIGHT*1.10, 6);
			
			Util.Debug("Bee::Bee() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		
		// ****************************************************************
		// TODO: Function: 	Think()
		// Purpose:     Bee uses pattern movement.
		// Input:		frameTime:Number - Ammount of time that passed
		//					between the last frame and this one, in
		//					seconds
		// ****************************************************************
		public override function Think(frameTime:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Bee::Think() called: frameTime = "+frameTime", 3);
			
			Util.Debug("Bee::Think() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}