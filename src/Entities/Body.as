// ************************************************************************ 
// File Name:   Body.as 
// Purpose:     Base game object class. Includes physics, collision, and
//				drawing for basic game object.
// Author:      Sarah Herzog 
// Copyright: 	2013 Bound-Dare Studios
// ************************************************************************ 

package Entities
{
    // ********************************************************************
    // Imports 
    // ********************************************************************
	import Collision.ColShape;
    import flash.display.BitmapData;
    import flash.display.Sprite;
	import flash.events.DRMAuthenticationCompleteEvent;
    import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
    // ********************************************************************
    // Class:	Body 
    // ********************************************************************
	public class Body 
	{
		// ****************************************************************
		// Protected Data Members 
		// ****************************************************************
		
		// Game unit dimmensions
		protected var m_width:int;				// game units
		protected var m_height:int;				// game units
		
		// Game world position and orientation
		protected var m_positionX:Number;		// game units		
		protected var m_positionY:Number;		// game units
		protected var m_angle:Number;			// radians, clockwise, 0 = right
		
		// Game world velocities
		protected var m_velocityX:Number;		// game units / second
		protected var m_velocityY:Number;		// game units / second
		protected var m_angularVelocity:Number;	// radians / second, clockwise
		
		// Display
		protected var m_visible:Boolean = true;
		protected var m_image:Image; // TODO: Change to array of images, for complex models. Most only use one.
		protected var m_layer:int;
		
		// Collision
		protected var m_collision:ColShape; // TODO: Change to array of collisions, for complex models. Most only use one.
	 
		// ****************************************************************
		// Function: 	Body()
		// Purpose:     Constructor.
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				width:Number - width of object
		//				height:Number - height of object
		//				angle:Number - rotation of object
		// ****************************************************************
		public function Body(x:Number, y:Number, width:Number, height:Number, angle:Number=0)
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::Body() called: x = " + x + ", y = " + y + ", width = " + width + ", height = " + height + ", angle = " + angle, 1);
			
			// Copy in supplied values
			this.m_width = width;
			this.m_height = height;
			this.m_positionX = x;
			this.m_positionY = y;
			this.m_angle = angle;
			
			// Velocities set to 0 at start
			m_velocityX = 0;
			m_velocityY = 0;
			m_angularVelocity = 0;
			
			Util.Debug("Body::Body() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	Update()
		// Purpose:     Updates logic
		// Input:		frameTime:Number - Ammount of time that passed
		//					between the last frame and this one, in
		//					seconds
		// ****************************************************************
		public function Update(frameTime:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::Update() called", 3);
			
			// Update position and orientation based on velocities
			m_positionX += m_velocityX * frameTime;
			m_positionY += m_velocityY * frameTime;
			m_angle += m_angularVelocity * frameTime;
			
			// Bounds check orientation
			if (m_angle > 2 * Math.PI)
				m_angle -= 2 * Math.PI;
			if (m_angle < 0)
				m_angle += 2 * Math.PI;
			
			// Image setup
			if (m_image)
			{
				m_image.SetPosition(m_positionX-m_width/2, m_positionY-m_height/2, m_angle);
				Renderer.AddToRenderQueue(m_image, m_layer);
			}
			if (m_collision)
			{
				m_collision.SetPosition(m_positionX, m_positionY, m_angle);
				Renderer.AddToRenderQueue(m_collision, Constants.LAYER_DEBUG);
			}
			
			Util.Debug("Body::Update() returned", 3);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	SetPosition()
		// Purpose:     Sets x, y position and angle for body
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				a:Number - rotation of object
		// ****************************************************************
		public function SetPosition(x:Number, y:Number, a:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::SetPosition() called: x = " + x + ", y = " + y + ", angle = " + a, 1);
			
			m_positionX = x;
			m_positionY = y;
			m_angle = a;
			
			// Image setup
			if (m_image)
			{
				m_image.SetPosition(m_positionX-m_width/2, m_positionY-m_height/2, m_angle);
			}
			
			Util.Debug("Body::SetPosition() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		
		// ****************************************************************
		// Function: 	IncrementPosition()
		// Purpose:     Increments x, y position and angle for body
		// Input:		x:Number - x coordinate for object
		//				y:Number - y coordinate for object
		//				a:Number - rotation of object
		// ****************************************************************
		public function IncrementPosition(x:Number, y:Number, a:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::SetPosition() called: x = " + x + ", y = " + y + ", angle = " + a, 1);
			
			SetPosition(m_positionX + x, m_positionY + y, m_angle + a);
			
			Util.Debug("Body::SetPosition() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	SetVelocity()
		// Purpose:     Sets x, y, and angle velocity for body
		// Input:		x:Number - x velocity for object
		//				y:Number - y velocity for object
		//				a:Number - rotation velocity of object
		// ****************************************************************
		public function SetVelocity(x:Number, y:Number, a:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::SetVelocity() called: x = " + x + ", y = " + y + ", angle = " + a, 1);
			
			m_velocityX = x;
			m_velocityY = y;
			m_angularVelocity = a;
			
			Util.Debug("Body::SetVelocity() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	SetDimmensions()
		// Purpose:     Sets width and height of body
		// Input:		w:Number - width of object
		//				h:Number - height of object
		// ****************************************************************
		public function SetDimmensions(w:Number, h:Number):void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::SetDimmensions() called: w = " + w + ", h = " + h, 1);
			
			m_width = w;
			m_height = h;
			
			// Image setup
			if (m_image)
			{
				m_image.SetDimmensions(w, h);
			}
			
			Util.Debug("Body::SetDimmensions() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		// ****************************************************************
		// Function: 	CollisionCheck()
		// Purpose:     Checks for collision with supplied Body, then
		//				calls collision handler if appropriate
		// Input:		other:Body - Body to check for collision
		// Output:      Boolean - true if there is a collision, false if 
		//					not
		// ****************************************************************
		public function CollisionCheck(other:Body):Boolean 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::CollisionCheck() called: other = " + other, 3);
			
			var result:Boolean = false;
			
			// Check for collision
			result = m_collision.DetectCollision(other.m_collision);
			
			// If collision occurred, call handler
			if(result) CollisionHandler(other);
			if(result) other.CollisionHandler(this);
			
			Util.Debug("Body::CollisionCheck() returned: result = "+result, 3);
			Util.ChangeDebugLevel( -1);
			
			// Return collision status
			return result;
		}
		
		
		// ****************************************************************
		// Function: 	CollisionHandler()
		// Purpose:     Perform actions on both bodies for the collision
		// Input:		other:Body - Body that collided with this one.
		// ****************************************************************
		protected function CollisionHandler(other:Body):void 
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::CollisionHandler() called: other = " + other, 3);
			
			// To be implemented by sub classes
			
			Util.Debug("Body::CollisionHandler() returned", 3);
			Util.ChangeDebugLevel( -1);
		}
		
		// ****************************************************************
		// Function: 	Kill()
		// Purpose:     Virtual function
		// ****************************************************************
		public function Kill():void
		{
			Util.ChangeDebugLevel(1);
			Util.Debug("Body::Kill() called", 1);
			
			// To be implemented by sub classes
			
			Util.Debug("Body::Kill() returned", 1);
			Util.ChangeDebugLevel(-1);
		}
		
		
	}

}