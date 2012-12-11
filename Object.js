// ************************************************************************ 
// File Name:   Object.js 
// Author:      Sarah Herzog 
// Purpose:     Abstract base class for all game objects. Do NOT inherit
//              from this, instead inherit from Circle or Rectangle.
// ************************************************************************

// Object class
function Object() {

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
    
    // Color of the object (used for primitives and collision outlines)
    this.green;
    this.red;
    this.blue;
    this.alpha;
    
    // ********************************************************************
    // Function:    draw()
    // Purpose:     ABSTRACT - Draws the object to the screen
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