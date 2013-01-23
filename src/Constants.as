// ************************************************************************ 
// File Name:   Constants.as 
// Purpose:     Constant data used by the rest of the game.
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package  
{
	public class Constants 
	{
		// ****************************************************************
		// Debugging
		// ****************************************************************
		public static const DEBUG_MODE:int = 1;
		
		// ****************************************************************
		// Keycodes (Don't Touch)
		// ****************************************************************
		private static const KEYCODE_LEFT:int = 37;
		private static const KEYCODE_UP:int = 38;
		private static const KEYCODE_RIGHT:int = 39;
		private static const KEYCODE_SPACE:int = 32;
		private static const KEYCODE_DOWN:int = 40;
		private static const KEYCODE_W:int = 87;
		private static const KEYCODE_A:int = 65;
		private static const KEYCODE_S:int = 83;
		private static const KEYCODE_D:int = 68;
		
		// ****************************************************************
		// Graphics Layers 
		// ****************************************************************
		public static const LAYER_GROUND:int = 0;
		public static const LAYER_BACKGROUND:int = 1;
		public static const LAYER_PLAYER:int = 2;
		public static const LAYER_BOSSEENEMY:int = 3;
		public static const LAYER_ENEMIES:int = 4;
		public static const LAYER_POWERUPS:int = 5;
		public static const LAYER_FOREGROUND:int = 6;
		public static const LAYER_INTERFACE:int = 7;
		public static const LAYER_MENU:int = 8;
		
		// ****************************************************************
		// Player Constants 
		// ****************************************************************
		public static const PLAYER_WIDTH:int = 139;
		public static const PLAYER_HEIGHT:int = 125;
		public static const PLAYER_TOP_MOVE_SPEED:int = 300;
		
		// ****************************************************************
		// Controls 
		// ****************************************************************
		public static const CONTROL_DECELERATE:int = KEYCODE_A;
		public static const CONTROL_ACCELERATE:int = KEYCODE_D;
		public static const CONTROL_STRAFE_LEFT:int = KEYCODE_W;
		public static const CONTROL_STRAFE_RIGHT:int = KEYCODE_S;
		
		// ****************************************************************
		// Function: 	Constants()
		// Purpose:     Constructor.
		// ****************************************************************
		public function Constants() 
		{	
		}
	}

}