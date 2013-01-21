// ************************************************************************ 
// File Name:   Game.js 
// Author:      Sarah Herzog 
// Purpose:     Wrapper and main game loop. 
// ************************************************************************ 

// Global Variables
var CANVAS_WIDTH = 550,                 // width of the canvas
    CANVAS_HEIGHT = 400,                // height of the canvas
    gLoop,                              // Game loop timer
    c = document.getElementById('c'),   // The canvas itself
    ctx = c.getContext('2d'),           // 2d graphics context
    FPS = 50,                           // Frames per second
    DEBUGMODE = true;                   // Debug mode
    
// Set canvas size    
c.width = CANVAS_WIDTH;
c.height = CANVAS_HEIGHT;

// Movement keys
UP = 38;
DOWN = 40;
LEFT = 37;
RIGHT = 39;
    
// Game Class
function Game() {
    // ********************************************************************
    // Data Members 
    // ********************************************************************
    
    // Timers
    this.now = new Date();
    this.start_time = this.now.getTime();
    this.current_time = 0;
    
    // Levels
    this.levels = [];
    this.levels.push(new Level());
    this.current_level = this.levels[0];
    
    // ********************************************************************
    // Function:    onkeydown()
    // Purpose:     Listens for key presses and passes them to the level 
    //              object. 
    // ********************************************************************
    this.onkeydown = function(e) {
        if (e.keyCode == UP) {
            this.current_level.key_up = true;
        }
        if (e.keyCode == LEFT) {
            this.current_level.key_left = true;
        }
        if (e.keyCode == RIGHT) {
            this.current_level.key_right = true;
        }
    }

    // ********************************************************************
    // Function:    onkeyup()
    // Purpose:     Listens for key presses and passes them to the level 
    //              object. 
    // ********************************************************************
    this.onkeyup = function(e) {
        if (e.keyCode == UP) {
            this.current_level.key_up = false;
        }
        if (e.keyCode == LEFT) {
            this.current_level.key_left = false;
        }
        if (e.keyCode == RIGHT) {
            this.current_level.key_right = false;
        }
    }

    // ********************************************************************
    // Function:    gameLoop()
    // Purpose:     Continuous loop runs while the game is loaded. 
    // ********************************************************************
    this.gameLoop = function() {  
        this.current_level.logic();     // Run all logic functions
        this.current_level.draw();      // Draw all objects and text
    }  
}

// ********************************************************************
// Function:    initializeCanvas()
// Purpose:     Sets up the supplied canvas for the game 
// ********************************************************************
this.gameLoop = function() {  
	this.current_level.logic();     // Run all logic functions
	this.current_level.draw();      // Draw all objects and text
}  

// ********************************************************************
// Function:    startGame()
// Purpose:     Sets up game and starts loop. 
// ********************************************************************
// Create instance of the game
var this_game = new Game();     
function gameLoop() { this_game.gameLoop(); }
function gameOnkeydown(e) { this_game.onkeydown(e); }
function gameOnkeyup(e) { this_game.onkeyup(e); }
setInterval(gameLoop, 1000 / FPS);
document.onkeydown = gameOnkeydown;
document.onkeyup = gameOnkeyup;