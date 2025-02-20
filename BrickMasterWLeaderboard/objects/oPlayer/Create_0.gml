// Create Event for oPlayer
spd = 4;
xSpeed = 0;
ySpeed = 0;
wasWalking = false;
isStopping = false;
stopCooldown = 0;

// Death-related variables
death_timer = 0;
isDead = false; // Flag to track if the player is dead
elapsed_time = 0; // Initialize elapsed time

// Add invincibility cooldown after taking damage
invincibility_timer = 0;  // Initialize the invincibility timer

// In oPlayer Create Event
camera_x = 0; // Store the X position of the camera when Mario dies
camera_y = 0; // Store the Y position of the camera when Mario dies
camera_frozen = false; // Flag to freeze camera

// Create Event of oPlayer
isInteractingWithNPC = false; // Track if the player is interacting with an NPC


// Ascension after coin collection
isAscending = false;  // To check if Mario is ascending
ascend_speed = 0;      // Speed of ascension
ascend_timer = 0;      // Timer for the pause before ascension
