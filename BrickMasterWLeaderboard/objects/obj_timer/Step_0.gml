// Decrease the timer based on room_speed
timer -= 1 / room_speed;  // Assuming room_speed = 60 (1 second per frame)
global.elapsed_time += 1 / room_speed; // Increment elapsed time

// Ensure the timer doesn't go below zero
if (timer <= 0) {
    timer = 0;
    room_goto(rm_gameover);  // Go to Game Over room if time runs out
}

// Calculate the current frame based on remaining time
var frame_count = sprite_get_number(sprite_index);  // Get total frames (9)
var frame = floor((1 - (timer / max_timer)) * (frame_count - 1));

// Update the sprite frame to match the remaining time
image_index = frame;

// Check if the game is completed
if (game_completed) {  
    // Assign the total time taken to the global variable
    global.timer_value = global.elapsed_time; // Store elapsed time in a global variable
    room_goto(roomEnd);  // Go to the end room
}
