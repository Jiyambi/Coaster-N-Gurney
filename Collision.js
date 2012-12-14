// ************************************************************************ 
// File Name:   Collision.js 
// Author:      Sarah Herzog 
// Purpose:     Abstract base class for all collision objects. Do NOT 
//              inherit this, instead inherit from Circle or Rectangle.
// ************************************************************************

// Collision class
function Collision() {

    // ********************************************************************
    // Data Members 
    // ********************************************************************
    // Collision type
    this.collision_type = "none";
    
    // Coordinates in the game world
    this.x;
    this.y;
    
    // TODO: What are these? may not need em
    //this.newx = function () {return this.x};
    //this.newy = function () {return this.y};
    
    // Velocity in the game world
    this.xvel;
    this.yvel;
    
    // Color of the object (used for collision outlines)
    this.green = 0;
    this.red = 255;
    this.blue = 0;
    this.alpha = 100;
    
    // ********************************************************************
    // Function:    draw()
    // Purpose:     ABSTRACT - Draws the collision area to the screen
    // ********************************************************************
    this.draw = function() {}
    
    // ********************************************************************
    // Function:    updatePosition()
    // Purpose:     Updates the position of the objcet based on it's 
    //              velocity.
    // ********************************************************************
    this.updatePosition = function() {
        // Move the object based on it's velocity
        this.x += this.xvel;
        this.y += this.yvel;
    }
    
    // ********************************************************************
    // Function:    checkCollision()
    // Purpose:     ABSTRACT - Checks if this object is colliding with the  
    //              supplied object
    // Input:       check - object to be checked for collision.
    // Output:      true if there is a collision, false if not
    // ********************************************************************
    this.checkCollision = function(check) {return false;}

}