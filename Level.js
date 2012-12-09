// ************************************************************************ 
// File Name:	Level.js 
// Author:		Sarah Herzog 
// Purpose:		Controls scenery, interactable objects, and player. 
// ************************************************************************ 

// Level Class
function Level() {

	// ********************************************************************
	// Data Members 
	// ********************************************************************
	
	// Background Colors
	bg_red = 150;
	bg_green = 150;
	bg_blue = 150;
	bg_alpha = 255;
	
	// Score
    // TODO: Move to player
	score = 0;
	
	// Controls
	this.key_up = false;
	this.key_left = false;
	this.key_right = false;
	
    // TODO: Example only, to remove
	// Pollen
	// var numPollens = 5,
		// pollens = [];
	// for (var i = 0; i < numPollens; i++) {
		// pollens.push(new Pollen())	// Push an object into the array
	// }
	// Clouds
	// var numClouds = 20,
		// clouds = [];
	// for (var i = 0; i < numClouds; i++) {
		// clouds.push(new Cloud())	// Push an object into the array
	// }
	
    // TODO: Change to CandG
	// Bee
	//var player = new Bee();
	
	// ********************************************************************
	// Function:	clear()
	// Purpose:		Sets up the canvas for each frame. 
	// ********************************************************************
	function clear() {
		ctx.fillStyle = 'rgba(' 		// Sets active color
			+ bg_red + ', ' 
			+ bg_green + ', ' 
			+ bg_blue + ', ' 
			+ bg_alpha + ')';
		ctx.beginPath();				// Start drawing
		ctx.rect(0,0,                   // Draws rectangle
            CANVAS_WIDTH,
            CANVAS_HEIGHT);		
		ctx.closePath();				// Ends drawing
		ctx.fill();						// Fills rectangle w/ active color
	}
	
	// ********************************************************************
	// Function:	logic()
	// Purpose:		Updates positions, checks for collisions
	// ********************************************************************
	this.logic = function() {
	}  
	
	// ********************************************************************
	// Function:	draw()
	// Purpose:		Draws all objects to the screen
	// ********************************************************************
	this.draw = function() {
		// Clear the canvas to the level's bg color
		clear();
	}
}