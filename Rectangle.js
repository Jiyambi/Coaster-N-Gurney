// ************************************************************************ 
// File Name:   Rectangle.js 
// Author:      Sarah Herzog 
// Purpose:     Governs movement, collision detection, and drawing for a 
//              Rectangle object. 
// ************************************************************************ 

Rectangle.prototype = new Object();
Rectangle.prototype.constructor = Rectangle;

// Rectangle class
function Rectangle() {

    // ********************************************************************
    // Inheritance 
    // ********************************************************************
    this.inheritFrom = Object;
    this.inheritFrom();

    // ********************************************************************
    // Data Members 
    // ********************************************************************
    this.collision_type = "rectangle";
    
    // Width and height of the rectangle (x and y upper left corner)
    this.w;
    this.h;
    
    // ********************************************************************
    // Function:    draw()
    // Purpose:     Draws the rectangle to the screen
    // ********************************************************************
    this.draw = function() {
        ctx.fillStyle = 'rgba('         // Sets active color 
            + this.red + ', ' 
            + this.green + ', ' 
            + this.blue + ', ' 
            + this.alpha + ')';
        ctx.beginPath();                // Start drawing
        ctx.rect(this.x,this.y,         // Draws rectangle
            this.w, this.h);        
        ctx.closePath();                // Ends drawing
        ctx.fill();                     // Fills rectangle w/ active color
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