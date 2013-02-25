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
	import Entities.Enemies.Enemy;
	
	
    // ********************************************************************
    // Class:	ToPoint 
    // ********************************************************************
	public class ToPoint extends Instruction 
	{
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		private var m_targetX:Number;
		private var m_targetY:Number;
		private var m_velocityX:Number;
		private var m_velocityY:Number;
		private var m_positionX:Number;
		private var m_positionY:Number;
		
		
		// ****************************************************************
		// Function: 	ToPoint()
		// Purpose:     Constructor.
		// Input:		targetX:Number - Target x value
		//				targetY:Number - Target y value
		//				speed:Number - Speed we'll travel at
		// ****************************************************************
		public function ToPoint(targetX:Number, targetY:Number, speed:Number) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ToPoint::ToPoint() called: targetX = "+targetX+", targetY = "+targetY+", speed = "+speed, 1);
			
			// Record target
			m_targetX = targetX;
			m_targetY = targetY;
			
			// Determine velocity vector
			var magnitude:Number = Math.sqrt(targetX * targetX + targetY * targetY);
			m_velocityX = speed * targetX / magnitude;
			m_velocityY = speed * targetY / magnitude;
			
			// Initialise current position
			m_positionX = 0;
			m_positionY = 0;
			
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
		public override function Process(enemy:Enemy, frameTime:Number) :void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("ToPoint::Process() called: enemy = "+enemy+", frameTime = "+frameTime, 3);
			
			// Determine next movement step
			var deltaX:Number = frameTime * m_velocityX;
			var deltaY:Number = frameTime * m_velocityY;
			
			// Keep us from going too far in either axis
			if (Math.abs(m_targetX - m_positionX) < Math.abs(deltaX)) 
				deltaX = m_targetX - m_positionX;
			if (Math.abs(m_targetY - m_positionY) < Math.abs(deltaY)) 
				deltaY = m_targetY - m_positionY;
				
			// Increment the enemy's position
			enemy.IncrementPosition(deltaX, deltaY, 0);
			m_positionX += deltaX;
			m_positionY += deltaY;
			
			// Check if we've reached our goal
			if (m_positionX == m_targetX && m_positionY == m_targetY)
			{
				// Set state to done
				m_done = true;
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
			m_done = false;
			m_positionX = 0;
			m_positionY = 0;
		}
		
		
		
	}

}