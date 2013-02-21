// ************************************************************************ 
// File Name:   Util.as 
// Purpose:     Contains utility functions used throughout the program.
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package  
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Patterns.Singleton;
	import Constants;
	
    // ********************************************************************
    // Class:	Game 
    // ********************************************************************
	public class Util extends Singleton
	{
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		private static var debug_level:int = 0;
		
		// ****************************************************************
		// Function: 	Util()
		// Purpose:     Constructor. Use getInstance() instead.
		// ****************************************************************
		public function Util() 
		{
			// Set up as a Singleton
			super();
		}
 
		// ****************************************************************
		// Function: 	Debug()
		// Purpose:     Process a key up event and udpates the keys_down 
		//				array.
		// Input:		statement:String - calling event.
		//				mode:int - which debug modes should display this
		//					statement
		// ****************************************************************
		public static function Debug(statement:String, mode:int=1):void
		{
			// Set up tabs based on debug level
			var tabs:String = "";
			for (var i:int = 0; i < debug_level; ++i)
			{
				tabs += "\t";
			}
			
			// Print out debug statement based on debug mode
			if (mode <= Constants.DEBUG_MODE)
				trace(tabs+statement);
		}
 
		// ****************************************************************
		// Function: 	ChangeDebugLevel()
		// Purpose:     Sets the tab level for formatting debug statements
		// Input:		level:int - modification to debug level
		// ****************************************************************
		public static function ChangeDebugLevel(level:int):void
		{
			debug_level = Math.max(debug_level + level,0);
		}
		
		
	}

}