// ************************************************************************ 
// File Name:   Rectangle.js 
// Author:      Sarah Herzog 
// Purpose:     Governs movement, collision detection, and drawing for a 
//              Rectangle object. 
// ************************************************************************ 

// Inheritance
Rectangle.prototype = new Collision();
Rectangle.prototype.constructor = Rectangle;

// Rectangle class
function Rectangle() {

    // ********************************************************************
    // Data Members 
    // ********************************************************************
    this.collision_type = "rectangle";
    
    // Width and height of the rectangle (x and y upper left corner)
    this.w=0;
    this.h=0;
	
	// Angle of rotation for the rectangle
	this.angle = 0;
    
    // ********************************************************************
    // Function:    draw()
    // Purpose:     Draws the rectangle to the screen
    // ********************************************************************
    this.draw = function() {
		ctx.translate(this.x, this.y);	// Translate to correct location
		ctx.rotate(this.angle);			// Set rotation
        ctx.fillStyle = 'rgba('         // Sets active color 
            + this.red + ', ' 
            + this.green + ', ' 
            + this.blue + ', ' 
            + this.alpha + ')';
        ctx.fillRect(0, 0, this.w, this.h);   // Fills rectangle w/ active color
		ctx.rotate(-this.angle);			// Rotate back
		ctx.translate(-this.x, -this.y);	// Translate back
    }
    
    // ********************************************************************
    // Function:    checkCollision()
    // Purpose:     Checks if this object is colliding with the supplied 
    //              object
    // Input:       check - object to be checked for collision.
    // Output:      true if there is a collision, false if not
    // ********************************************************************
    this.checkCollision = function(check) {
        
        // If colliding with another rectangle...
        if (check.collision_type == "rectangle")
        {
            // Checks if the sides are intersecting.
            return (this.x <= (check.x+check.w)) && ((this.x+this.w) >= check.x) &&
                    (this.y <= (check.y+check.h)) && ((this.y+this.h) >= check.y);
        }
        
        // If colliding with a circle...
        if (check.collision_type == "circle")
        {
            return check.checkCollision(this); // Use the code in circle so as not to repeat code
        }
    }

}