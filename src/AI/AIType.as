// ************************************************************************ 
// File Name:   AIType.as 
// Purpose:     Interface for all AI types.
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package AI 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Entities.Enemy;
	
    // ********************************************************************
    // Interface:	AIType 
    // ********************************************************************
	public interface AIType 
	{
		
		// ****************************************************************
		// Function: 	Process()
		// Purpose:     Process AI for given enemy.
		// Input:		enemy:Enemy - The enemy to run the AI on
		// 				frameTime:Number - Ammount of time that passed
		//					between the last frame and this one, in
		//					seconds
		// ****************************************************************
		public function Process(enemy:Enemy, frameTime:Number) 
		{
		}
		
		
	}

}