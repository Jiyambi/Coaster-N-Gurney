// ************************************************************************ 
// File Name:   AIType.as 
// Purpose:     Base AI class. Interface for AI objects.
	//Base game object class. Includes physics, collision, and
//				drawing for basic game object.
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package AI 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	
	
    // ********************************************************************
    // Class:	AIType 
    // ********************************************************************
	public class AIType 
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// ****************************************************************
		// Function: 	AIType()
		// Purpose:     Constructor.
		// Input:		
		// ****************************************************************
		public function AIType() 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("AIType::AIType() called", 1);
			
			Util.Debug("AIType::AIType() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}