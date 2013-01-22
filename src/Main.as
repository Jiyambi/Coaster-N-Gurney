// ************************************************************************ 
// File Name:   Main.as 
// Purpose:     Wrapper for the program. 
// Author:      Sarah Herzog  
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 
	
package 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
    // ********************************************************************
    // Class:	Main
    // ********************************************************************
	public class Main extends Sprite 
	{
		
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		private var game:Game;
		
		// ****************************************************************
		// Function: 	Main()
		// Purpose:     Constructor
		// ****************************************************************
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		// ****************************************************************
		// Function: 	init()
		// Purpose:     Initialization.
		// Input:		e:Event - triggering event
		// ****************************************************************
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			// Create the game object, passing in the swf width and height
			game = new Game(stage.stageWidth, stage.stageHeight);

			// Add the game bitmap to the Main.as Sprite to make it visible
			addChild(game.bitmap);

			// Create the main game loop
			addEventListener(Event.ENTER_FRAME, Run);
			
			// Add keylisteners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, Input.KeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, Input.KeyUp);
		}
		
		// ****************************************************************
		// Function: 	Run()
		// Purpose:     Main game loop, calls game drawing and logic.
		// Input:		e:Event - triggering event
		// ****************************************************************
		private function Run(e:Event):void
		{
			game.Update();
			game.Render();
		}
		
	}
	
}