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
    	private var camera:Camera;
		
		// ****************************************************************
		// Function: 	Game()
		// Purpose:     Constructor for a game object. Initializes the 
		//				game.
		// Input:		stage_width:int - width of the stage
		//				stage_height:int - height of the stage
		// ****************************************************************
		public function Game(stage_width:int, stage_height:int)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Game::Game() called: stage_width = " + stage_width + ", stage_height = " + stage_height, 1);
			
			// Create a player at center of screen
			player = new Player(stage_width/2 - Constants.PLAYER_WIDTH/2, stage_height/2 - Constants.PLAYER_HEIGHT/2,0);
			box = new Box(stage_width/2-200, stage_height/2-50,0);
			
			// Send camera to renderer
			camera = new Camera(0, 0, stage_width, stage_height, 0);
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
				
			// Update game objects
			player.Update(0.02);
			box.Update(0.02);
			camera.Update(0.02);
			
			Util.Debug("Game::Update() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
	}

}