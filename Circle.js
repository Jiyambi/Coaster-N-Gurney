// ************************************************************************ 
// File Name:   Circle.js 
// Author:      Sarah Herzog 
// Purpose:     Governs movement, collision detection, and drawing for a 
//              circle object. 
// ************************************************************************ 

Circle.prototype = new Object();
Circle.prototype.constructor = Circle;

// Circle class
function Circle() {

    // ********************************************************************
    // Inheritance 
    // ********************************************************************
    this.inheritFrom = Object;
    this.inheritFrom();

    // ********************************************************************
    // Data Members 
    // ********************************************************************
    this.collision_type = "circle";
    
    // Radius of the circle (centered on x and y)
    this.radius;
    
    // ********************************************************************
    // Function:    draw()
    // Purpose:     Draws the circle to the screen
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
    // Function:    checkCollision()
    // Purpose:     Checks if this object is colliding with the supplied 
    //              object
    // Input:       check - object to be checked for collision.
    // Output:      true if there is a collision, false if not
    // ********************************************************************
    this.checkCollision = function(check) {
        
        // If colliding with another circle...
        if (check.collision_type == "circle")
        {
            // goal radius
            collision_distance = check.radius + this.radius; 
            // actual distance between objects
            actual_distance = Math.sqrt(
                Math.pow(check.x-this.x,2) + Math.pow(check.y-this.y,2) 
            ); 

            return actual_distance <= collision_distance;
        }
        
        // If colliding with a rectangle...
        if (check.collision_type == "rectangle")
        {
            // clamp(value, min, max) - limits value to the range min..max
            clamp = function(value, min, max) {
                if (value < min) value = min;
                if (value > max) value = max;
                return value;
            }

            // Find the closest point to the circle within the rectangle
            closestX = clamp(this.x, check.x, check.x+check.w);
            closestY = clamp(this.y, check.y, check.y+check.h);

            // Calculate the distance between the circle's center and this closest point
            distanceX = this.x - closestX;
            distanceY = this.y - closestY;

            // If the distance is less than the circle's radius, an intersection occurs
            distanceSquared = (distanceX * distanceX) + (distanceY * distanceY);
            return distanceSquared < (this.radius * this.radius);
        }
    }

}