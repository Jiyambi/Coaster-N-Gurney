// ************************************************************************ 
// File Name:   Instruction.as 
// Purpose:     Instruction base class. Contains a single instruction for
//				pattern movement, and a method for processing it.
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
    // Class:	Instruction 
    // ********************************************************************
	public class Instruction 
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		protected var done:Boolean = false;
		
		
		// ****************************************************************
		// Function: 	Instruction()
		// Purpose:     Constructor.
		// ****************************************************************
		public function Instruction() 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Instruction::Instruction() called", 1);
			
			Util.Debug("Instruction::Instruction() returned", 1);
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
		public function Process(enemy:Enemy, frameTime:Number) :void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Instruction::Process() called: enemy = "+enemy+", frameTime = "+frameTime, 3);
			
			// Process this instruction for this frame
			
			// Check if we've reached the endpoint of this instruction
			// If so, set state to done
			
			// (Implemented in sub classes)
			
			Util.Debug("Instruction::Process() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		
		// ****************************************************************
		// Function: 	IsDone()
		// Purpose:     Checks if the instruciton has completed
		// Output:		done:Boolean - completion status of the instruction
		// ****************************************************************
		public function IsDone():Boolean 
		{
			return done;
		}
		
		
		// ****************************************************************
		// Function: 	Reset()
		// Purpose:     Resets the instruction so it can be used again.
		// ****************************************************************
		public function Reset():void 
		{
			done = false;
		}
	}

}