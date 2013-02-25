// ************************************************************************ 
// File Name:   PatternMovement.as 
// Purpose:     PatternMovement AI class. Moves object in a set pattern.
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package AI 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import AI.InstructionTypes.Instruction;
	import Entities.Enemies.Enemy;
	
	
    // ********************************************************************
    // Class:	PatternMovement 
    // ********************************************************************
	public class PatternMovement extends AIType 
	{
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		private var m_instructions:Array = new Array();
		private var m_currentInstruction:int = 0;
		
		
		// ****************************************************************
		// Function: 	PatternMovement()
		// Purpose:     Constructor.
		// ****************************************************************
		public function PatternMovement() 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("PatternMovement::PatternMovement() called", 1);
			
			Util.Debug("PatternMovement::PatternMovement() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Process()
		// Purpose:     Process AI for given enemy.
		// Input:		enemy:Enemy - The enemy to run the AI on
		// 				frameTime:Number - Ammount of time that passed
		//					between the last frame and this one, in
		//					seconds
		// ****************************************************************
		public override function Process(enemy:Enemy, frameTime:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("PatternMovement::Process() called: enemy = "+enemy+", frameTime = "+frameTime, 3);
			
			// Process current instruction
			if (m_instructions[m_currentInstruction]) m_instructions[m_currentInstruction].Process(enemy, frameTime);
			
			// If current instruction is done, move to the next instrcution
			if (m_instructions[m_currentInstruction].IsDone()) ++m_currentInstruction;
			
			// If all instructions have been run, loop back to the beginning
			if (m_currentInstruction >= m_instructions.length) 
			{
				m_currentInstruction = 0;
				
				// Reset all instructions
				for each (var instruction:Instruction in m_instructions)
				{
					instruction.Reset();
				}
			}
			
			Util.Debug("PatternMovement::Process() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	AddInstruction()
		// Purpose:     Adds an instruction to the set.
		// Input:		instruction:Instruction - new instruction to be added
		// ****************************************************************
		public function AddInstruction(instruction:Instruction):void 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("PatternMovement::AddInstruction() called: ins = "+instruction, 1);
			
			m_instructions.push(instruction);
			
			Util.Debug("PatternMovement::AddInstruction() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		
		
	}

}