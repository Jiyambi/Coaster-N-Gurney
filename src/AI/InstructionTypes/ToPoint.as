// ************************************************************************ 
// File Name:   ToPoint.as 
// Purpose:     Sends entity to a relative point at a given velocity
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package AI.InstructionTypes 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Entities.Enemy;
	
	
    // ********************************************************************
    // Class:	ToPoint 
    // ********************************************************************
	public class ToPoint extends Instruction 
	{
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		private var relX:Number;
		private var relY:Number;
		private var velX:Number;
		private var velY:Number;
		private var curX:Number;
		private var curY:Number;
		
		
		// ****************************************************************
		// Function: 	ToPoint()
		// Purpose:     Constructor.
		// Input:		relx:Number - Target x value
		//				rely:Number - Target y value
		//				speed:Number - Speed we'll travel at
		// ****************************************************************
		public function ToPoint(relx:Number, rely:Number, speed:Number) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ToPoint::ToPoint() called: relx = "+relx+", rely = "+rely+", speed = "+speed, 1);
			
			// Record target
			relX = relx;
			relY = rely;
			
			// Determine velocity vector
			var magnitude:Number = Math.sqrt(relx * relx + rely * rely);
			velX = speed * relx / magnitude;
			velY = speed * rely / magnitude;
			
			// Initialise current position
			curX = 0;
			curY = 0;
			
			Util.Debug("ToPoint::ToPoint() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		
		// ****************************************************************
		// Function: 	Process()
		// Purpose:     Process Instruction for given enemy.
		// Input:		enemy:Enemy - The enemy to run the AI on
		// 				frameTime:Number - Ammount of time that passed
		//					between the last frame and this one, in
		//					seconds
		// ****************************************************************
		public override function Process(enemy:Enemy, frameTime:Number) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ToPoint::Process() called: enemy = "+enemy+", frameTime = "+frameTime, 3);
			
			// Determine next movement step
			var deltaX:Number = frameTime * velX;
			var deltaY:Number = frameTime * velY;
			
			// Keep us from going too far in either axis
			if (Math.abs(relX - curX) < abs(deltaX)) 
				curX = relX;
			else
				curX += deltaX;
			if (Math.abs(relY - curY) < abs(deltaY)) 
				curY = relY;
			else
				curY += deltaY;
			
			// Check if we've reached our goal
			if (curX == relX && curY == relY)
			{
				// Set state to done
				done = true;
			}
			
			Util.Debug("ToPoint::Process() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		
		// ****************************************************************
		// Function: 	Reset()
		// Purpose:     Resets the instruction so it can be used again.
		// ****************************************************************
		public override function Reset():void 
		{
			done = false;
			curX = 0;
			curY = 0;
		}
		
		
		
	}

}