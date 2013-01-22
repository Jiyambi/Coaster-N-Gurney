// ************************************************************************ 
// File Name:   Player.as 
// Purpose:     Player class, 
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Entities 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
    // ********************************************************************
    // Class:	Body 
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
		// Input:		x:int - x coordinate for object
		//				y:int - y coordinate for object
		//				angle:int - rotation of object
		// ****************************************************************
		public function Player(x:int, y:int, angle:int=0)
		{
			// Set up Player as a Body
			super(x, y, Constants.PLAYER_WIDTH, Constants.PLAYER_HEIGHT);
			
			// Create image to hold sprite
			image_sprite = new Sprite();
			var temp_bitmap:DisplayObject = new tex_player();
			temp_bitmap.width = Constants.PLAYER_WIDTH;
			temp_bitmap.height = Constants.PLAYER_HEIGHT;
			image_sprite.addChild(temp_bitmap);
		}
		
		// ****************************************************************
		// Function: 	StrafeLeft()
		// Purpose:     Sets velocity based on status
		// Input:		status:Boolean - Whether the player is strafng
		// ****************************************************************
		public function StrafeLeft(status:Boolean):void
		{
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
		}
		
		// ****************************************************************
		// Function: 	StrafeRight()
		// Purpose:     Sets velocity based on status
		// Input:		status:Boolean - Whether the player is strafng
		// ****************************************************************
		public function StrafeRight(status:Boolean):void
		{
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
		}
		
		// ****************************************************************
		// Function: 	Accelerate()
		// Purpose:     Sets velocity based on status
		// Input:		status:Boolean - Whether the player is accelerating
		// ****************************************************************
		public function Accelerate(status:Boolean):void
		{
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
		}
		
		// ****************************************************************
		// Function: 	Decelerate()
		// Purpose:     Sets velocity based on status
		// Input:		status:Boolean - Whether the player is decelerating
		// ****************************************************************
		public function Decelerate(status:Boolean):void
		{
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
		}
		
	}

}