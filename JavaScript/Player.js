// ************************************************************************ 
// File Name:   Player.js 
// Author:      Sarah Herzog 
// Purpose:     Player-controlled object 
// ************************************************************************

// Player class
function Player() {

    // ********************************************************************
    // Data Members 
    // ********************************************************************
    this.hitbox = new Rectangle();
    this.x = 100;
    this.y = 100;
    this.xvel = 2;
    this.yvel = 0;
    this.hitbox.w = 20;
    this.hitbox.h = 10;
    this.hitbox.xvel = 0;
    this.hitbox.yvel = 0;
	this.hitbox.angle = Math.PI / 4;
    
    // ********************************************************************
    // Function:    draw()
    // Purpose:     Draws the rectangle to the screen
    // ********************************************************************
    this.draw = function() {
        if (DEBUGMODE) this.hitbox.draw();
    }
    
    // ********************************************************************
    // Function:    checkCollision()
    // Purpose:     Checks if this object is colliding with the supplied 
    //              object
    // Input:       check - object to be checked for collision.
    // Output:      true if there is a collision, false if not
    // ********************************************************************
    this.checkCollision = function(check) {
        return this.hitbox.checkCollision(check);
    }
    
    // ********************************************************************
    // Function:    updatePosition()
    // Purpose:     Updates the position of the objcet based on it's 
    //              velocity.
    // ********************************************************************
    this.updatePosition = function() {
        // Move the object based on it's velocity
        this.x += this.xvel;
        this.y += this.yvel;
        this.hitbox.x = this.x;
        this.hitbox.y = this.y;
    }

}