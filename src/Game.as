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
			//box = new Box(200, 0, 0);
			//box.velocity_angle = 0.5;
			bee = new Bee(200, 0, 0);
			
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
		public function Update():void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Game::Update() called", 3);
			
			// Interpret player input
			player.Decelerate(Input.CheckKeyDown(Constants.CONTROL_DECELERATE));
			player.Accelerate(Input.CheckKeyDown(Constants.CONTROL_ACCELERATE));	
			player.StrafeLeft(Input.CheckKeyDown(Constants.CONTROL_STRAFE_LEFT));		
			player.StrafeRight(Input.CheckKeyDown(Constants.CONTROL_STRAFE_RIGHT));
			
			// Check collision
			//player.collision.DetectCollision(box.collision);
			player.collision.DetectCollision(bee.collision);
			
			// Update game objects
			player.Update(0.02);
			//box.Update(0.02);
			bee.Update(0.02);
			camera.Update(0.02);
			
			Util.Debug("Game::Update() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
	}

}