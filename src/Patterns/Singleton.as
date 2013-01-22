// ************************************************************************ 
// File Name:   Input.as 
// Purpose:     Singleton for handling all input 
// Author:      Sarah Herzog  
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Patterns 
{
 
    public class Singleton {
 
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		// Singleton management
        private static var instance:Singleton;
        private static var isOkayToCreate:Boolean=false;
 
		// ****************************************************************
		// Function: 	Singleton()
		// Purpose:     Constructor. Use getInstance() instead.
		// ****************************************************************
        public function Singleton() {
            //If we can't create an instance, throw an error so no instance is created
            if(!isOkayToCreate) throw new Error(this + " is a Singleton. Access using getInstance()");
        }
 
        //With this method we will create and access the instance of the method
		// ****************************************************************
		// Function: 	getInstance()
		// Purpose:     Create and access an instance of the Singleton.
		// Output:		Singleton - a pointer to the instance of the 
		//					Singleton
		// ****************************************************************
        public static function getInstance():Singleton
        {
            //If there's no instance, create it
            if (!instance)
            {
                //Allow the creation of the instance, and after it is created, stop any more from being created
                isOkayToCreate = true;
                instance = new Singleton();
                isOkayToCreate = false;
                trace("Singleton instance created!");
            }
            return instance;
        }
    }
	
}