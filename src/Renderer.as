// ************************************************************************ 
// File Name:   Renderer.as 
// Purpose:     Renderer position, field of view, and movement.
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package  
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Entities.Camera;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.geom.Point;
	import flash.geom.Matrix;
	
    // ********************************************************************
    // Class:	Renderer
    // ********************************************************************
	public class Renderer
	{
		// ****************************************************************
		// Public Data Members 
		// ****************************************************************
		// Renderer
		public var m_bitmap:Bitmap;
		
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		private static var m_camera:Camera;	// Camera as located in the 
											// game world
		
		// Render queue
		private static var m_queue:Array = new Array();
		
		// Buffers
		private static var m_renderer:BitmapData;
		
		// Stage size
		private var m_stageWidth:int;		// pixels
		private var m_stageHeight:int;		// pixels
		
		
		// ****************************************************************
		// Function: 	Renderer()
		// Purpose:     Constructor.
		// Input:		stage_width:int - width of the stage
		//				stage_height:int - height of the stage
		// ****************************************************************
		public function Renderer(stage_width:int, stage_height:int)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Renderer::Renderer() called: stage_width = " + stage_width + ", stage_height = " + stage_height, 1);
			
			// Set up main bitmap (renderer) to be drawn to
			m_renderer = new BitmapData(stage_width, stage_height, false, 0x000000);
			m_bitmap = new Bitmap(m_renderer);
			
			// Record stage width and height
			this.m_stageWidth = stage_width;
			this.m_stageHeight = stage_height;
			
			Util.Debug("Renderer::Renderer() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Render()
		// Purpose:     Draws to the stage
		// ****************************************************************
		public function Render():void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Renderer::Render() called", 3);
			
			m_renderer.lock();
			
			// Clear screen
			m_renderer.fillRect(new Rectangle(0, 0, m_renderer.width, m_renderer.height), 0x000000);
			
			// Draw everything in the queue
			for each (var layer:Array in m_queue)
			{
				// Render the images on this layer, in FIFO order
				for each (var image:Image in layer)
				{
					image.Render();
				}
				
				// Remove the images from the queue
				layer.splice(0);
			}
			
			m_renderer.unlock();
			
			Util.Debug("Renderer::Render() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	SetCamera()
		// Purpose:     Sets the camera for this renderer
		// Inputs:		camera:Camera - the camera that will be used for
		//					framing the scene
		// ****************************************************************
		public static function SetCamera(new_camera:Camera):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Renderer::SetCamera() called, camera = " + m_camera, 1);
			
			m_camera = new_camera;
			
			Util.Debug("Renderer::SetCamera() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	AddToRenderQueue()
		// Purpose:     Adds the image to the queue for later rendering
		// Inputs:		image:Image - the image to be added to the queue
		//				layer:int - the layer the image should be added to
		// ****************************************************************
		public static function AddToRenderQueue(image:Image, layer:int):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Renderer::AddToRenderQueue() called, image = " +image+ ", layer = "+layer, 3);
				
			// Add to render queue at correct location
			if (!m_queue[layer]) m_queue[layer] = new Array();
			m_queue[layer].push(image);
			
			Util.Debug("Renderer::AddToRenderQueue() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	DrawToBackBuffer()
		// Purpose:     Draws the supplied sprite at the supplied matrix
		// Inputs:		image_sprite:Sprite - the image to be drawn
		//				matrix:Matrix - The matrix transform for the image
		// ****************************************************************
		public static function DrawToBackBuffer(image_sprite:Sprite, matrix:Matrix):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Renderer::DrawToBackBuffer() called, image_sprite = " +image_sprite+ ", matrix = "+matrix, 3);
				
			// Transform image based on camera
			// we start with the world origin in the upper left
			matrix.translate(-m_camera.GetX(), -m_camera.GetY()); 			// translate to correct point in scene
			matrix.rotate( -m_camera.GetAngle());							// rotate about 0,0
			matrix.translate(m_renderer.width/2, m_renderer.height/2); 		// translate so world origin would be in center
			matrix.scale(m_renderer.width / m_camera.GetWidth(), 			// scale based on camera view
				m_renderer.height / m_camera.GetHeight());
			
			// Draw the image to renderer
			m_renderer.draw(image_sprite, matrix);
			
			Util.Debug("Renderer::DrawToBackBuffer() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
	}

}