// ************************************************************************ 
// File Name:   Enemy.as 
// Purpose:     Base class for all enemies
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Entities.Enemies 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import AI.AIType;
	import AI.InstructionTypes.Instruction;
	import flash.geom.Point;
	import Entities.Body
	
    // ********************************************************************
    // Class:	Enemy 
    // ********************************************************************
	public class Enemy extends Body
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		// Display
		protected var m_imageDead:Image; 
		protected var m_imageAlive:Image;
		
		// Logic
		protected var m_alive:Boolean = true;
		protected var m_active:Boolean = true;
		protected var m_ai:AIType;
		
		// ****************************************************************
		// Function: 	Enemy()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				width:Number - width of object
		//				height:Number - height of object
		//				angle:Number - rotation of object
		// ****************************************************************
		public function Enemy(x:Number, y:Number, width:Number, height:Number, angle:Number=0)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Enemy::Enemy() called: x = " + x + ", y = " + y + ", width = " + width + ", height = " + height + ", angle = " + angle, 1);
			
			// Set up Enemy as a Body
			super(x, y, width, height, angle);
			
			// Image and Collision set up in base class
			
			Util.Debug("Enemy::Enemy() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		
		// ****************************************************************
		// Function: 	Think()
		// Purpose:     Processess the Enemy's AI.
		// Input:		frameTime:Number - Ammount of time that passed
		//					between the last frame and this one, in
		//					seconds
		// ****************************************************************
		public function Think(frameTime:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Enemy::Think() called: frameTime = "+frameTime, 3);
			
			if(m_ai && m_alive) m_ai.Process(this, frameTime);
			
			Util.Debug("Enemy::Think() returned", 3);
			Util.ChangeDebugLevel(-1);
		
		}
		
		
		// ****************************************************************
		// Function: 	Update()
		// Purpose:     Updates logic
		// Input:		frameTime:Number - Ammount of time that passed
		//					between the last frame and this one, in
		//					seconds
		// ****************************************************************
		public override function Update(frameTime:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Enemy::Update() called: frameTime = "+frameTime, 3);
			
			// Provess the enemy AI
			Think(frameTime);
			
			// Call entity update function
			super.Update(frameTime);
			
			Util.Debug("Body::Update() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Kill()
		// Purpose:     Kills enemy, setting it's image and alive state
		// ****************************************************************
		public override function Kill():void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Enemy::Kill() called", 1);
			
			m_image = m_imageDead;
			m_alive = false;
			
			Util.Debug("Enemy::Kill() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Revive()
		// Purpose:     Kills enemy, setting it's image and alive state
		// ****************************************************************
		public function Revive():void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Enemy::Revive() called", 1);
			
			m_image = m_imageAlive;
			m_alive = true;
			
			Util.Debug("Enemy::Revive() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}