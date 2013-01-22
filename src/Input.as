// ************************************************************************ 
// File Name:   Input.as 
// Purpose:     Singleton for handling all input 
// Author:      Sarah Herzog  
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package  
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Patterns.Singleton;
	import flash.events.KeyboardEvent;
	
    // ********************************************************************
    // Class:	Input
    // ********************************************************************
	public class Input extends Singleton
	{
 
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		
		// Key press arrays
		private static var keys_down:Array = new Array();
		
		// ****************************************************************
		// Function: 	Input()
		// Purpose:     Constructor. Use getInstance() instead.
		// ****************************************************************
		public function Input() 
		{
			// Set up Input as a Singleton
			super();
		}
 
		// ****************************************************************
		// Function: 	KeyUp()
		// Purpose:     Process a key up event and udpates the keys_down 
		//				array.
		// Input:		e:KeyboardEvent - calling event.
		// ****************************************************************
		public static function KeyUp(e:KeyboardEvent):void
		{
			//position of key in the array
			var key_pos:int = -1;
			for (var i:int = 0; i < keys_down.length; i++)
				if (e.keyCode == keys_down[i])
				{
					//the key is found/was pressed before, so store the position
					key_pos = i;
					break;
				}
			//remove the keycode from keys_down if found
			if(key_pos!=-1)
				keys_down.splice(key_pos, 1);
		}
 
		// ****************************************************************
		// Function: 	KeyDown()
		// Purpose:     Process a key up event and udpates the keys_down 
		//				array.
		// Input:		e:KeyboardEvent - calling event.
		// ****************************************************************
		public static function KeyDown(e:KeyboardEvent):void
		{
			//check to see if the key that is being pressed is already in the array of pressed keys
			var key_down:Boolean = false;
			for (var i:int = 0; i < keys_down.length; i++)
				if (keys_down[i] == e.keyCode)
					key_down = true;
 
			//add the key to the array of pressed keys if it wasn't already in there
			if (!key_down)
				keys_down.push(e.keyCode);
		}
 
		// ****************************************************************
		// Function: 	CheckKeyDown()
		// Purpose:     Checks the keys_down array for the supplied key
		// Input:		keycode:int - The key to check for.
		// Output:		Boolean - true if key is down, else false.
		// ****************************************************************
		public static function CheckKeyDown(keycode:int):Boolean
		{
			var answer:Boolean = false;
			for (var i:int = 0; i < keys_down.length; i++)
				if (keys_down[i] == keycode)
				{
					answer = true;
					break;
				}
			return answer;
		}
		
	}

}