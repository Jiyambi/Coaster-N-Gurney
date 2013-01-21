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
    import Entities.Player;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.geom.Rectangle;
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
    	private var player:Player;
		
		// ****************************************************************
		// Function: 	Game()
		// Purpose:     Constructor for a game object. Initializes the 
		//				game.
		// Input:		stage_width:int - width of the stage
		//				stage_height:int - height of the stage
		// ****************************************************************
		public function Game(stage_width:int, stage_height:int)
		{
			trace("Game() called.");
			
			// Set up main bitmap (renderer) to be drawn to
			renderer = new BitmapData(stage_width, stage_height, false, 0x000000);
			bitmap = new Bitmap(renderer);
			
			// Create a player at center of screen
			player = new Player(renderer.width/2-5, renderer.height/2-10, 10, 20);
			
			trace("Game() returned.");
		}
		
		// ****************************************************************
		// Function: 	Render()
		// Purpose:     Draws to the stage
		// ****************************************************************
		public function Render():void
		{
			renderer.lock();
			
			// Clear screen
			renderer.fillRect(new Rectangle(0, 0, renderer.width, renderer.height), 0x000000);

			// Draw bodies to screen
			player.Render();

			renderer.unlock();
		}
		
		// ****************************************************************
		// Function: 	Update()
		// Purpose:     Updates logic
		// ****************************************************************
		public function Update():void
		{
		}
	}

}