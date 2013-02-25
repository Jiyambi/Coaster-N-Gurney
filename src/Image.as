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
		protected var m_width:int;				// game units
		protected var m_height:int;				// game units
		
		// Position and orientation
		protected var m_positionX:Number;		// game units		
		protected var m_positionY:Number;		// game units
		protected var m_angle:Number;				// radians, clockwise, 0 = right
		
		// Display
		protected var m_image:BitmapData;
		protected var m_imageSprite:Sprite;
		
		// ****************************************************************
		// Getter Functions 
		// ****************************************************************
		public function GetWidth():Number { return m_width; }
		public function GetHeight():Number { return m_height; }
		
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
			this.m_width = width;
			this.m_height = height;
			this.m_positionX = x;
			this.m_positionY = y;
			this.m_angle = angle;
			
			// Create image to hold sprite
			if (texture)
			{
				m_imageSprite = new Sprite();
				var temp_bitmap:DisplayObject = new texture();
				temp_bitmap.width = width;
				temp_bitmap.height = height;
				m_imageSprite.addChild(temp_bitmap);
			}
			
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
			
			if (m_imageSprite)
			{
				// Create a matrix and move it to the body's location
				var matrix:Matrix = new Matrix();
				matrix.translate(-1*m_width/2, -1*m_height/2);			// center on origin
				matrix.rotate(m_angle);								// rotate about origin
				matrix.translate(m_width/2, m_height/2);				// translate back to corner on origin
				matrix.scale(m_width / m_imageSprite.width,			// scale based on height settings
					m_height / m_imageSprite.height);
				matrix.translate(m_positionX, m_positionY);			// translate to correct location in scene
				
				// Render the image to this matrix
				Renderer.DrawToBackBuffer(m_imageSprite, matrix);
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
			
			m_positionX = x;
			m_positionY = y;
			m_angle = a;
			
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
			
			m_width = w;
			m_height = h;
			
			Util.Debug("Image::SetDimmensions() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		
	}

}