// ************************************************************************ 
// File Name:   Game.as 
// Purpose:     Contains game data, update and render functions
// Author:      Sarah Herzog 
// Project:     Coaster 'N Gurney  
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package  
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Entities.Enemies.*;
	import Entities.*;
    import flash.geom.Rectangle;
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
    	private var m_player:Player;
    	private var m_box:Box;
		private var m_bee:Bee;
    	private var m_camera:Camera;
		
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
			m_player = new Player(0, 0, 0);
			m_bee = new Bee(500, 150, 0);
			
			// Send camera to renderer
			m_camera = new Camera(0, 0, 0);
			Renderer.SetCamera(m_camera);
			
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
			m_player.Decelerate(Input.CheckKeyDown(Constants.CONTROL_DECELERATE));
			m_player.Accelerate(Input.CheckKeyDown(Constants.CONTROL_ACCELERATE));	
			m_player.StrafeLeft(Input.CheckKeyDown(Constants.CONTROL_STRAFE_LEFT));		
			m_player.StrafeRight(Input.CheckKeyDown(Constants.CONTROL_STRAFE_RIGHT));
			
			// Check collisions against player
			// TODO: Update for array of enemies
			m_player.CollisionCheck(m_bee);
			
			// TODO: Check collisions against player's bullets
			
			// TODO: Keep player within the screen
			
			// TODO: Manage which enemies are active based on where we are in the level
			
			// Update game objects
			// TODO: Update with actual frame time
			m_player.Update(0.02);
			m_bee.Update(0.02);
			m_camera.Update(0.02);
			
			Util.Debug("Game::Update() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
	}

}