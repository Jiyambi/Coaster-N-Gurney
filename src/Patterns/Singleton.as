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
        private static var m_instance:Singleton;
        private static var m_isOkayToCreate:Boolean=false;
 
		// ****************************************************************
		// Function: 	Singleton()
		// Purpose:     Constructor. Use getInstance() instead.
		// ****************************************************************
        public function Singleton() {
            //If we can't create an instance, throw an error so no instance is created
            if(!m_isOkayToCreate) throw new Error(this + " is a Singleton. Access using getInstance()");
        }

		// ****************************************************************
		// Function: 	GetInstance()
		// Purpose:     Create and access an instance of the Singleton.
		// Output:		Singleton - a pointer to the instance of the 
		//					Singleton
		// ****************************************************************
        public static function GetInstance():Singleton
        {
            //If there's no instance, create it
            if (!m_instance)
            {
                //Allow the creation of the instance, and after it is created, stop any more from being created
                m_isOkayToCreate = true;
                m_instance = new Singleton();
                m_isOkayToCreate = false;
                trace("Singleton instance created!");
            }
            return m_instance;
        }
    }
	
}
