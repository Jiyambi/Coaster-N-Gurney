// ************************************************************************ 
// File Name:	Circle.js 
// Author:		Sarah Herzog 
// Purpose:		Governs movement, collision detection, and drawing for a 
//				circle object. 
// ************************************************************************ 

// Circle class
function Circle() {

	// ********************************************************************
	// Data Members 
	// ********************************************************************
	this.x;
	this.y;
	this.radius;
	this.green;
	this.red;
	this.blue;
	this.alpha;
	this.xvel;
	this.yvel;
	this.newx = function () {return this.x};
	this.newy = function () {return this.y};
	
	// ********************************************************************
	// Function:	draw()
	// Purpose:		Draws the circle to the screen
	// ********************************************************************
	this.draw = function() {
		ctx.fillStyle = 'rgba(' 
			+ this.red + ', ' 
			+ this.green + ', ' 
			+ this.blue + ', ' 
			+ this.alpha + ')';
		ctx.beginPath();
		ctx.arc(this.x, this.y, 
			this.radius, 0, Math.PI * 2, true);
		ctx.closePath();
		ctx.fill();
	}
	
	// ********************************************************************
	// Function:	updatePosition()
	// Purpose:		Updates the position of the circle based on it's 
	//				velocity.
	// ********************************************************************
	this.updatePosition = function() {
		// Move the circle based on it's velocity
		this.x += this.xvel;
		this.y += this.yvel;
	}
	
	// ********************************************************************
	// Function:	checkCollision()
	// Purpose:		Checks if this object is colliding with the supplied 
	//				object
	// Input:		check - object to be checked for collision.
	// Output:		true if there is a collision, false if not
	// ********************************************************************
	this.checkCollision = function(check) {
		// goal radius
		collision_distance = check.radius + this.radius; 
		// actual distance between objects
		actual_distance = Math.sqrt(
			Math.pow(check.x-this.x,2) + Math.pow(check.y-this.y,2) 
		); 

		if (actual_distance <= collision_distance)
			return true;
		else 
			return false;
	}

}