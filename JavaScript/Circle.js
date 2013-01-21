// ************************************************************************ 
// File Name:   Circle.js 
// Author:      Sarah Herzog 
// Purpose:     Governs movement, collision detection, and drawing for a 
//              circle object. 
// ************************************************************************ 


// Inheritance
Circle.prototype = new Collision();
Circle.prototype.constructor = Circle;

// Circle class
function Circle() {

    // ********************************************************************
    // Data Members 
    // ********************************************************************
    this.collision_type = "circle";
    
    // Radius of the circle (centered on x and y)
    this.r=0;
    
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
            this.r, 0, Math.PI * 2, true);
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
            collision_distance = check.r + this.r; 
            // actual distance between objects
            actual_distance_sqr = Math.pow(check.x-this.x,2) 
									+ Math.pow(check.y-this.y,2);

            return actual_distance_sqr <= collision_distance * collision_distance;
        }
        
        // If colliding with a rectangle...
        if (check.collision_type == "rectangle")
        {
			// Determine circle position from rectangle frame of reference
			//		with regards to angle
			var rel_circle_x, rel_circle_y;
			if (check.angle == 0)
			{
				rel_circle_x = this.x;
				rel_circle_y = this.y;
			}
			else
			{
				// Translate so rectangle coord = origin
				temp_x = this.x - check.x;
				temp_y = this.y - check.y;
				
				// Rotate about new origin (rect coord)
				// TODO: Change cos and sin calcs to rectangle object, set when angle is changed
				cos_theta = Math.cos(-check.angle);
				sin_theta = Math.sin(-check.angle);
				rel_circle_x = temp_x*cos_theta - temp_y*sin_theta;
				rel_circle_y = temp_x*sin_theta + temp_y*cos_theta;
				
				// Translate back to rectangle coord
				rel_circle_x = rel_circle_x + check.x;
				rel_circle_y = rel_circle_y + check.y;
			}
		
            // clamp(value, min, max) - limits value to the range min..max
            clamp = function(value, min, max) {
                if (value < min) value = min;
                if (value > max) value = max;
                return value;
            }

            // Find the closest point to the circle within the rectangle
            closestX = clamp(rel_circle_x, check.x, check.x+check.w);
            closestY = clamp(rel_circle_y, check.y, check.y+check.h);

            // Calculate the distance between the circle's center and this closest point
            distanceX = rel_circle_x - closestX;
            distanceY = rel_circle_y - closestY;

            // If the distance is less than the circle's radius, an intersection occurs
            distance_sqr = (distanceX * distanceX) + (distanceY * distanceY);
            return distance_sqr < (this.r * this.r);
        }
    }

}