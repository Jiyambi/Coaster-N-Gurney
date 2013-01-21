// ************************************************************************ 
// File Name:   Player.as 
// Purpose:     Player class, 
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Entities 
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
    // ********************************************************************
    // Class:	Body 
    // ********************************************************************
	public class Player extends Body
	{
		
		// ****************************************************************
		// Function: 	Player()
		// Purpose:     Constructor.
		// Input:		x:int - x coordinate for object
		//				y:int - y coordinate for object
		//				width:int - width of object
		//				height:int - height of object
		//				angle:int - rotation of object
		// ****************************************************************
		public function Player(x:int, y:int, width:int, height:int, angle:int=0)
		{
			// Set up Player as a Body
			super(x, y, width, height);
			
			// TODO: Replace with image from file
			// Create image to hold sprite
			image_sprite = new Sprite();
			image_sprite.graphics.lineStyle(.1, 0xFFFFFF);
 
			//create the ship drawing
			image_sprite.graphics.moveTo(0, height);
			image_sprite.graphics.lineTo(width / 2, 0);
			image_sprite.graphics.lineTo(width, height);
 
			//draw the line across
			image_sprite.graphics.moveTo((7*height/8 -height)/(-height/(width/2)), 7*height/8 );
			image_sprite.graphics.lineTo((7*height/8 -height)/(height/(width/2))+width, 7*height/8);
		}
		
		// ****************************************************************
		// Function: 	Render()
		// Purpose:     Draws to the stage
		// ****************************************************************
		override public function Render():void
		{
			// Crete a matrix and move it to the body's location
			var matrix:Matrix = new Matrix();
			matrix.translate(x, y);
 
			// Render the image to this matrix
			Game.renderer.draw(image_sprite, matrix);
		}
		
	}

}