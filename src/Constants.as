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