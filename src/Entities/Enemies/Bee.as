// ************************************************************************ 
// File Name:   Bee.as 
// Purpose:     Sample enemy, AI is pattern movement
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Entities.Enemies 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import AI.InstructionTypes.Instruction;
	import AI.InstructionTypes.ToPoint;
	import AI.PatternMovement;
	import flash.geom.Point;
	import Collision.ColElipse;
	import flash.utils.getQualifiedClassName;
	import Entities.Body;
	
    // ********************************************************************
    // Class:	Bee 
    // ********************************************************************
	public class Bee extends Enemy
	{
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		[Embed(source = '../../../resources/images/bee.png')]
		private var m_texureAlive:Class;
		
		[Embed(source = '../../../resources/images/bee_explode.png')]
		private var m_textureDead:Class;
		
		
		// ****************************************************************
		// Function: 	Bee()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				angle:Number - rotation of object
		// ****************************************************************
		public function Bee(x:Number, y:Number, angle:Number=0)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Bee::Bee() called: x = " + x + ", y = " + y + ", angle = " + angle, 1);
			
			// Set up Bee as an Enemy
			super(x, y, Constants.BEE_WIDTH, Constants.BEE_HEIGHT, angle);
			
			// Create image to hold sprite
			m_imageAlive = new Image(x, y, Constants.BEE_WIDTH, Constants.BEE_HEIGHT, angle, m_texureAlive);
			m_imageDead = new Image(x, y, Constants.BEE_WIDTH, Constants.BEE_HEIGHT, angle, m_textureDead);
			m_image = m_imageAlive;
			m_layer = Constants.LAYER_ENEMIES;
			
			// Set up collision
			m_collision = new ColElipse(x, y, angle, Constants.BEE_WIDTH*1.10, Constants.BEE_HEIGHT*1.10, 6);
			
			// Set up AI
			var pattern:PatternMovement = new PatternMovement();
			var ins:Instruction = new ToPoint( -300, -300, 300);
			pattern.AddInstruction(ins);
			ins = new ToPoint( -300, 300, 300);
			pattern.AddInstruction(ins);
			m_ai = pattern;
			
			Util.Debug("Bee::Bee() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		
		// ****************************************************************
		// Function: 	CollisionHandler()
		// Purpose:     Perform actions on both bodies for the collision
		//				Bee has kamikaze behaviour for colliison
		//					(kills player and self)
		// Input:		other:Body - Body that collided with this one.
		// ****************************************************************
		protected override function CollisionHandler(other:Body):void 
		{
			// If other is player
			if (getQualifiedClassName(other) == "Entities::Player")
			{
				// Kill player
				other.Kill();
				
				// Enemy is killed in collision
				Kill();
			}
		}
		
	}

}