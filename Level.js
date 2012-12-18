// ************************************************************************ 
// File Name:    Level.js 
// Author:       Sarah Herzog 
// Purpose:      Controls scenery, interactable objects, and player. 
// ************************************************************************ 

// Level Class
function Level() {

    // ********************************************************************
    // Data Members 
    // ********************************************************************

    // Background Colors
    this.bg_red = 150;
    this.bg_green = 150;
    this.bg_blue = 150;
    this.bg_alpha = 255;
    
    // Score
    // TODO: Move to player
    this.score = 0;
    
    // Controls
    this.key_up = false;
    this.key_left = false;
    this.key_right = false;
    
    // TODO: Unit testing
    this.rect = new Rectangle();
    this.rect.x = -50;
    this.rect.y = 10;
    this.rect.w = 30;
    this.rect.h = 10;
    this.rect.xvel = 1;
    this.rect.angle =  Math.PI *7 / 4;
	this.rect.green = 255;
	this.rect.red = 0;
    this.rect2 = new Rectangle();
    this.rect2.x = -50;
    this.rect2.y = 10;
    this.rect2.w = 30;
    this.rect2.h = 10;
    this.rect2.xvel = 1;
	this.rect2.blue = 255;
	this.rect2.red = 0;
    this.circ = new Circle();
    this.circ.x = 50;
    this.circ.y = 15;
    this.circ.r = 5;
    this.player = new Player();
    
    // TODO: Example only, to remove
    // Pollen
    // var numPollens = 5,
        // pollens = [];
    // for (var i = 0; i < numPollens; i++) {
        // pollens.push(new Pollen())    // Push an object into the array
    // }
    // Clouds
    // var numClouds = 20,
        // clouds = [];
    // for (var i = 0; i < numClouds; i++) {
        // clouds.push(new Cloud())    // Push an object into the array
    // }
    
    // TODO: Change to CandG
    // Bee
    //var player = new Bee();
    
    // ********************************************************************
    // Function:    clear()
    // Purpose:     Sets up the canvas for each frame. 
    // ********************************************************************
    this.clear = function() {
        ctx.fillStyle = 'rgba('         // Sets active color
            + this.bg_red + ', ' 
            + this.bg_green + ', ' 
            + this.bg_blue + ', ' 
            + this.bg_alpha + ')';
        ctx.beginPath();                // Start drawing
        ctx.rect(0,0,                   // Draws rectangle
            CANVAS_WIDTH,
            CANVAS_HEIGHT);        
        ctx.closePath();                // Ends drawing
        ctx.fill();                     // Fills rectangle w/ active color
    }
    
    // ********************************************************************
    // Function:    logic()
    // Purpose:     Updates positions, checks for collisions
    // ********************************************************************
    this.logic = function() {
        
        // TODO: Remove (unit testing)
        this.rect.updatePosition();
        this.rect2.updatePosition();
        this.circ.updatePosition();
        this.player.updatePosition();
        if(this.rect.checkCollision(this.circ)) this.rect.x=-50;
        if(this.rect2.checkCollision(this.circ)) this.rect2.x=-50;
    }  
    
    // ********************************************************************
    // Function:    draw()
    // Purpose:     Draws all objects to the screen
    // ********************************************************************
    this.draw = function() {
    
        // Clear the canvas to the level's bg color
        this.clear();
        
        // TODO: Remove (unit testing)
        this.rect.draw();
        this.rect2.draw();
        this.circ.draw();
        this.player.draw();
    }
}