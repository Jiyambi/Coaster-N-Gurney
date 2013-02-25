// ************************************************************************ 
// File Name:   Player.as 
// Purpose:     Interprets input to player actions
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Entities 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Collision.ColElipse;
	import Entities.Guns.Gun;
	import Entities.Guns.MachineGun;
	import flash.geom.Point;
	
    // ********************************************************************
    // Class:	Player 
    // ********************************************************************
	public class Player extends Body
	{
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		[Embed(source = '../../resources/images/player.png')]
		private var m_textureAlive:Class;
		
		[Embed(source = '../../resources/images/bee_explode.png')]
		private var m_textureDead:Class;
		
		// Display
		protected var m_imageDead:Image; 
		protected var m_imageAlive:Image;
		
		// Logic
		protected var m_alive:Boolean = true;
		
		// Gun
		protected var m_gun:Gun;
		
		// ****************************************************************
		// Function: 	Player()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				angle:Number - rotation of object
		// ****************************************************************
		public function Player(x:Number, y:Number, angle:Number=0)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Player::Player() called: x = " + x + ", y = " + y + ", angle = " + angle, 1);
			
			// Set up Player as a Body
			super(x, y, Constants.PLAYER_WIDTH, Constants.PLAYER_HEIGHT, angle);
			
			// Create image to hold sprite
			m_imageAlive = new Image(x, y, Constants.PLAYER_WIDTH, Constants.PLAYER_HEIGHT, angle, m_textureAlive);
			m_imageDead = new Image(x, y, Constants.PLAYER_WIDTH, Constants.PLAYER_HEIGHT, angle, m_textureDead);
			m_image = m_imageAlive;
			m_layer = Constants.LAYER_PLAYER;
			
			// Set up collision
			m_collision = new ColElipse(x, y, angle, Constants.PLAYER_WIDTH * 0.80, Constants.PLAYER_HEIGHT * 0.60, 10);
			
			// Set up gun
			m_gun = new MachineGun(x, y, Constants.PLAYER_WIDTH, Constants.PLAYER_HEIGHT, angle);
			
			Util.Debug("Player::Player() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	StrafeLeft()
		// Purpose:     Sets velocity based on status
		// Input:		status:Boolean - Whether the player is strafng
		// ****************************************************************
		public function StrafeLeft(status:Boolean):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Player::StrafeLeft() called: status = " + status, 3);
			
			// If the player is holding down the strafe key
			// AND the vehicle is not yet at the top move speed
			if (status && m_velocityY > -1*Constants.PLAYER_TOP_MOVE_SPEED) 
				// Accelerate by top move speed
				m_velocityY -= Constants.PLAYER_TOP_MOVE_SPEED;
			
			// If the player is NOT holding down the strafe key 
			//	OR the player is dead
			// AND the vehicle is at the top move speed
			if ((!status || !m_alive) && m_velocityY == -1*Constants.PLAYER_TOP_MOVE_SPEED) 
				// Decelerate by top move speed
				m_velocityY += Constants.PLAYER_TOP_MOVE_SPEED;
				
			Util.Debug("Player::StrafeLeft() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	StrafeRight()
		// Purpose:     Sets velocity based on status
		// Input:		status:Boolean - Whether the player is strafng
		// ****************************************************************
		public function StrafeRight(status:Boolean):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Player::StrafeRight() called: status = " + status, 3);
			
			// If the player is holding down the strafe key
			// AND the vehicle is not yet at the top move speed
			if (status && m_velocityY < Constants.PLAYER_TOP_MOVE_SPEED) 
				// Accelerate by top move speed
				m_velocityY += Constants.PLAYER_TOP_MOVE_SPEED;
			
			// If the player is NOT holding down the strafe key
			//	OR the player is dead
			// AND the vehicle is at the top move speed
			if ((!status || !m_alive) && m_velocityY == Constants.PLAYER_TOP_MOVE_SPEED) 
				// Decelerate by top move speed
				m_velocityY -= Constants.PLAYER_TOP_MOVE_SPEED;
				
			Util.Debug("Player::StrafeRight() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Accelerate()
		// Purpose:     Sets velocity based on status
		// Input:		status:Boolean - Whether the player is accelerating
		// ****************************************************************
		public function Accelerate(status:Boolean):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Player::Accelerate() called: status = " + status, 3);
			
			// If the player is holding down the accelerate key
			// AND the vehicle is not yet at the top move speed
			if (status && m_velocityX < Constants.PLAYER_TOP_MOVE_SPEED) 
				// Accelerate by top move speed
				m_velocityX += Constants.PLAYER_TOP_MOVE_SPEED;
			
			// If the player is NOT holding down the accelerate key
			//	OR the player is dead
			// AND the vehicle is at the top move speed
			if ((!status || !m_alive) && m_velocityX == Constants.PLAYER_TOP_MOVE_SPEED) 
				// Decelerate by top move speed
				m_velocityX -= Constants.PLAYER_TOP_MOVE_SPEED;
				
			Util.Debug("Player::Accelerate() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Decelerate()
		// Purpose:     Sets velocity based on status
		// Input:		status:Boolean - Whether the player is decelerating
		// ****************************************************************
		public function Decelerate(status:Boolean):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Player::Decelerate() called: status = " + status, 3);
			
			// If the player is holding down the decelerate key
			// AND the vehicle is not yet at the top move speed
			if (status && m_velocityX > -1*Constants.PLAYER_TOP_MOVE_SPEED) 
				// Accelerate by top move speed
				m_velocityX -= Constants.PLAYER_TOP_MOVE_SPEED;
			
			// If the player is NOT holding down the decelerate key
			//	OR the player is dead
			// AND the vehicle is at the top move speed
			if ((!status || !m_alive) && m_velocityX == -1*Constants.PLAYER_TOP_MOVE_SPEED) 
				// Decelerate by top move speed
				m_velocityX += Constants.PLAYER_TOP_MOVE_SPEED;
				
			Util.Debug("Player::Decelerate() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		
		// ****************************************************************
		// Function: 	CollisionHandler()
		// Purpose:     Perform actions on both bodies for the collision
		// Input:		other:Body - Body that collided with this one.
		// ****************************************************************
		protected override function CollisionHandler(other:Body):void 
		{
		}
		
		// ****************************************************************
		// Function: 	Kill()
		// Purpose:     Kills enemy, setting it's image and alive state
		// ****************************************************************
		public override function Kill():void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Player::Kill() called", 1);
			
			m_image = m_imageDead;
			m_alive = false;
			m_gun = null;
			
			Util.Debug("Player::Kill() returned", 1);
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
			Util.Debug("Player::Update() called", 3);
			
			// Call Body::Update()
			super.Update(frameTime);
			
			// Set position, then update Gun
			if (m_gun)
			{
				m_gun.SetPosition(m_positionX, m_positionY, m_angle);
				m_gun.Update(frameTime);
			}
			
			Util.Debug("Player::Update() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}