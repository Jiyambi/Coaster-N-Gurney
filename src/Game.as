// ************************************************************************ 
// File Name:   Game.as 
// Purpose:     Contains game data, update and render functions
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package  
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	// Entities
	import Entities.Bee;
	import Entities.Box;
    import Entities.Player;
    import Entities.Camera;
	// Geometry
    import flash.geom.Rectangle;
	// Timers
    import flash.utils.getTimer;
	
    // ********************************************************************
    // Class:	Game 
    // ********************************************************************
	public class Game
	{
		
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		// Game objects
    	private var player:Player;
    	private var box:Box;
		private var bee:Bee;
    	private var camera:Camera;
		
		// ****************************************************************
		// Function: 	Game()
		// Purpose:     Constructor for a game object. Initializes the 
		//				game.
		// ****************************************************************
		public function Game()
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Game::Game() called", 1);
			
			// Create a player at center of screen
			player = new Player(0, 0, 0);
			bee = new Bee(500, 150, 0);
			
			// Send camera to renderer
			camera = new Camera(0, 0, 0);
			Renderer.SetCamera(camera);
			
			Util.Debug("Game::Game() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Update()
		// Purpose:     Interpret player input, update game objects
		// ****************************************************************
		// TODO: Move game updates into a level class
		public function Update():void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Game::Update() called", 3);
			
			// Interpret player input
			player.Decelerate(Input.CheckKeyDown(Constants.CONTROL_DECELERATE));
			player.Accelerate(Input.CheckKeyDown(Constants.CONTROL_ACCELERATE));	
			player.StrafeLeft(Input.CheckKeyDown(Constants.CONTROL_STRAFE_LEFT));		
			player.StrafeRight(Input.CheckKeyDown(Constants.CONTROL_STRAFE_RIGHT));
			
			// Check collisions against player
			// TODO: Update for array of enemies
			player.CollisionCheck(bee);
			
			// TODO: Check collisions against player's bullets
			
			// TODO: Keep player within the screen
			
			// TODO: Manage which enemies are active based on where we are in the level
			
			// Update game objects
			// TODO: Update with actual frame time
			player.Update(0.02);
			bee.Update(0.02);
			camera.Update(0.02);
			
			Util.Debug("Game::Update() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		
		// ****************************************************************
		// Function: 	LookAt()
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
			//	OR the player is dead
			// AND the vehicle is at the top move speed
			if ((!status || !alive) && velocity_y == Constants.PLAYER_TOP_MOVE_SPEED) 
				// Decelerate by top move speed
				velocity_y -= Constants.PLAYER_TOP_MOVE_SPEED;
				
			Util.Debug("Player::StrafeRight() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}