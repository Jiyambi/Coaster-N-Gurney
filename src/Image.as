// ************************************************************************ 
// File Name:   Image.as 
// Purpose:     Contains image bitmap and renders it to screen
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 
// TODO: Extend to Animation

package  
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Entities.Camera;
    import flash.display.BitmapData;
    import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
    import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	
    // ********************************************************************
    // Class:	Image 
    // ********************************************************************
	public class Image 
	{
		
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// Dimmensions
		protected var width:int;				// game units
		protected var height:int;				// game units
		
		// Position and orientation
		protected var position_x:Number;		// game units		
		protected var position_y:Number;		// game units
		protected var angle:Number;				// radians, clockwise, 0 = right
		
		// Display
		protected var image:BitmapData;
		protected var image_sprite:Sprite;
		
		// ****************************************************************
		// Function: 	Image()
		// Purpose:     Constructor.
		// Input:		x:int - x coordinate for object
		//				y:int - y coordinate for object
		//				width:int - width of object
		//				height:int - height of object
		//				angle:int - rotation of object
		//				texture:Class - texture loaded from file
		// ****************************************************************
		public function Image(x:int, y:int, width:int, height:int, angle:int, texture:Class) 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Image::Image() called: x = " + x + ", y = " + y + ", width = " + width + ", height = " + height + ", angle = " + angle, 1);
			
			// Copy in supplied values
			this.width = width;
			this.height = height;
			this.position_x = x;
			this.position_y = y;
			this.angle = angle;
			
			// Create image to hold sprite
			image_sprite = new Sprite();
			var temp_bitmap:DisplayObject = new texture();
			temp_bitmap.width = width;
			temp_bitmap.height = height;
			image_sprite.addChild(temp_bitmap);
			
			Util.Debug("Image::Image() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Render()
		// Purpose:     Draws to the stage
		// ****************************************************************
		public function Render():void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Image::Render() called", 3);
			
			if (image_sprite)
			{
				// Create a matrix and move it to the body's location
				var matrix:Matrix = new Matrix();
				matrix.translate(-1*width/2, -1*height/2);			// center on origin
				matrix.rotate(angle);								// rotate about origin
				matrix.translate(width/2, height/2);				// translate back to corner on origin
				matrix.scale(width / image_sprite.width,			// scale based on height settings
					height / image_sprite.height);
				matrix.translate(position_x, position_y);			// translate to correct location in scene
				
				// Render the image to this matrix
				Renderer.DrawToBackBuffer(image_sprite, matrix);
			}
			
			Util.Debug("Image::Render() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	SetPosition()
		// Purpose:     Sets x, y position and angle for Image
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				a:Number - rotation of object
		// ****************************************************************
		public function SetPosition(x:Number, y:Number, a:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Image::SetPosition() called: x = " + x + ", y = " + y + ", angle = " + a, 3);
			
			position_x = x;
			position_y = y;
			angle = a;
			
			Util.Debug("Image::SetPosition() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	SetDimmensions()
		// Purpose:     Sets width and height of Image
		// Input:		w:Number - width of object
		//				h:Number - height of object
		// ****************************************************************
		public function SetDimmensions(w:Number, h:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Image::SetDimmensions() called: w = " + w + ", h = " + h, 3);
			
			width = w;
			height = h;
			
			Util.Debug("Image::SetDimmensions() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		
	}

}