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
    import Entities.Player;
    import Entities.Camera;
	// Graphics
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
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
		// Public Data Members 
		// ****************************************************************
		public var bitmap:Bitmap;
		public static var renderer:BitmapData
		
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		// Game objects
    	private var player:Player;
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
			
			// Set up main bitmap (renderer) to be drawn to
			renderer = new BitmapData(stage_width, stage_height, false, 0x000000);
			bitmap = new Bitmap(renderer);
			
			// Create a player at center of screen
			player = new Player(renderer.width / 2 - Constants.PLAYER_WIDTH / 2, renderer.height / 2 - Constants.PLAYER_HEIGHT / 2);
			
			// Send camera to renderer
			camera = new Camera(0, 0, stage_width, stage_height, 0);
			Renderer.SetCamera(camera);
			
			Util.Debug("Game::Game() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Render()
		// Purpose:     Draws to the stage
		// ****************************************************************
		public function Render():void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Game::Render() called", 3);
			
			renderer.lock();
			
			// Clear screen
			renderer.fillRect(new Rectangle(0, 0, renderer.width, renderer.height), 0x000000);
			
			// Draw bodies to screen
			player.Render();
			
			renderer.unlock();
			
			Util.Debug("Game::Render() returned", 3);
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
			
			Util.Debug("Game::Update() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
	}

}