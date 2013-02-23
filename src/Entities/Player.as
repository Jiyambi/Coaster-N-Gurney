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
		private var tex_player:Class;
		
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
			image = new Image(x, y, Constants.PLAYER_WIDTH, Constants.PLAYER_HEIGHT, angle, tex_player);
			layer = Constants.LAYER_PLAYER;
			
			// Set up collision
			collision = new ColElipse(x, y, angle, Constants.PLAYER_WIDTH*0.80, Constants.PLAYER_HEIGHT*0.60, 10);
			
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
			if (status && velocity_y > -1*Constants.PLAYER_TOP_MOVE_SPEED) 
				// Accelerate by top move speed
				velocity_y -= Constants.PLAYER_TOP_MOVE_SPEED;
			
			// If the player is NOT holding down the strafe key
			// AND the vehicle is at the top move speed
			if (!status && velocity_y == -1*Constants.PLAYER_TOP_MOVE_SPEED) 
				// Decelerate by top move speed
				velocity_y += Constants.PLAYER_TOP_MOVE_SPEED;
				
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
			if (status && velocity_y < Constants.PLAYER_TOP_MOVE_SPEED) 
				// Accelerate by top move speed
				velocity_y += Constants.PLAYER_TOP_MOVE_SPEED;
			
			// If the player is NOT holding down the strafe key
			// AND the vehicle is at the top move speed
			if (!status && velocity_y == Constants.PLAYER_TOP_MOVE_SPEED) 
				// Decelerate by top move speed
				velocity_y -= Constants.PLAYER_TOP_MOVE_SPEED;
				
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
			if (status && velocity_x < Constants.PLAYER_TOP_MOVE_SPEED) 
				// Accelerate by top move speed
				velocity_x += Constants.PLAYER_TOP_MOVE_SPEED;
			
			// If the player is NOT holding down the accelerate key
			// AND the vehicle is at the top move speed
			if (!status && velocity_x == Constants.PLAYER_TOP_MOVE_SPEED) 
				// Decelerate by top move speed
				velocity_x -= Constants.PLAYER_TOP_MOVE_SPEED;
				
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
			if (status && velocity_x > -1*Constants.PLAYER_TOP_MOVE_SPEED) 
				// Accelerate by top move speed
				velocity_x -= Constants.PLAYER_TOP_MOVE_SPEED;
			
			// If the player is NOT holding down the decelerate key
			// AND the vehicle is at the top move speed
			if (!status && velocity_x == -1*Constants.PLAYER_TOP_MOVE_SPEED) 
				// Decelerate by top move speed
				velocity_x += Constants.PLAYER_TOP_MOVE_SPEED;
				
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
		
	}

}