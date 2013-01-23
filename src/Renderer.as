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
		public var bitmap:Bitmap;
		
		// ****************************************************************
		// Private Data Members 
		// ****************************************************************
		private static var camera:Camera;	// Camera as located in the 
											// game world
		
		// Stage size
		private var stage_width:int;		// pixels
		private var stage_height:int;		// pixels
		
		// Render queue
		private static var queue:Array = new Array();
		
		// Buffers
		private static var renderer:BitmapData;
		
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
			renderer = new BitmapData(stage_width, stage_height, false, 0x000000);
			bitmap = new Bitmap(renderer);
			
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
			
			renderer.lock();
			
			// Clear screen
			renderer.fillRect(new Rectangle(0, 0, renderer.width, renderer.height), 0x000000);
			
			// Draw everything in the queue
			for each (var layer:Array in queue)
			{
				// Render the images on this layer, in FIFO order
				for each (var image:Image in layer)
				{
					image.Render();
				}
				
				// Remove the images from the queue
				layer.splice(0);
			}
			
			renderer.unlock();
			
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
			Util.Debug("Renderer::SetCamera() called, camera = " + camera, 1);
			
			camera = new_camera;
			
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
			if (!queue[layer]) queue[layer] = new Array();
			queue[layer].push(image);
			
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
			matrix.translate(-renderer.width/2, -renderer.height/2);	// translate so center of scene is in upper left (0,0)
			matrix.translate(-camera.GetX(), -camera.GetY()); 			// translate to correct point in scene
			matrix.rotate( -camera.GetAngle());							// rotate about 0,0
			matrix.translate(renderer.width/2, renderer.height/2); 		// undo original translate
			matrix.scale(renderer.width / camera.GetWidth(), 			// scale based on camera view
				renderer.height / camera.GetHeight());
			
			// Draw the image to renderer
			renderer.draw(image_sprite, matrix);
			
			Util.Debug("Renderer::DrawToBackBuffer() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
	}

}