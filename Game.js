// ************************************************************************ 
// File Name:   Game.js 
// Author:      Sarah Herzog 
// Purpose:     Wrapper and main game loop. 
// ************************************************************************ 

// Global Variables
var CANVAS_WIDTH = 500,                 // width of the canvas
    CANVAS_HEIGHT = 320,                // height of the canvas
    gLoop,                              // Game loop timer
    c = document.getElementById('c'),   // The canvas itself
    ctx = c.getContext('2d'),           // 2d graphics context
    FPS = 50;                           // Frames per second
    
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
    now = new Date();
    start_time = now.getTime();
    current_time = 0;
    
    // Levels
    levels = [];
    levels.push(new Level());
    current_level = levels[0];
    
    // ********************************************************************
    // Function:    onkeydown()
    // Purpose:     Listens for key presses and passes them to the level 
    //              object. 
    // ********************************************************************
    document.onkeydown = function(e) {
        if (e.keyCode == UP) {
            current_level.key_up = true;
        }
        if (e.keyCode == LEFT) {
            current_level.key_left = true;
        }
        if (e.keyCode == RIGHT) {
            current_level.key_right = true;
        }
    }

    // ********************************************************************
    // Function:    onkeyup()
    // Purpose:     Listens for key presses and passes them to the level 
    //              object. 
    // ********************************************************************
    document.onkeyup = function(e) {
        if (e.keyCode == UP) {
            current_level.key_up = false;
        }
        if (e.keyCode == LEFT) {
            current_level.key_left = false;
        }
        if (e.keyCode == RIGHT) {
            current_level.key_right = false;
        }
    }

    // ********************************************************************
    // Function:    gameLoop()
    // Purpose:     Continuous loop runs while the game is loaded. 
    // ********************************************************************
    this.gameLoop = function() {  
        current_level.logic();     // Run all logic functions
        current_level.draw();      // Draw all objects and text
    }  
}

var this_game = new Game();     // Create instance of the game
this_game.gameLoop();           // Run Game Loop
setInterval(this_game.gameLoop, 1000 / FPS);