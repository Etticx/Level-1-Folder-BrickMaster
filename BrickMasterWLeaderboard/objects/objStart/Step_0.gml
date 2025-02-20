// In the create event of the object or room (e.g., objEnding)

// Check if the camera for view 0 exists
if (view_camera[0] == -1) {
    // Create a camera with the same dimensions as the background (1366 x 768)
    var camera = camera_create_view(0, 0, 1366, 768, 0, -1, -1, -1, 0, 0);
    view_camera[0] = camera;
    view_set_visible(0, true);
    view_set_wport(0, 1366); // Set the width of the port
    view_set_hport(0, 768);  // Set the height of the port
    view_set_wview(0, 1366); // Set the view width to match the background
    view_set_hview(0, 768);  // Set the view height to match the background
}

// Play the intro song if it’s not already playing
if (!audio_is_playing(intromusic)) {
    audio_play_sound(intromusic, 1, true);  // 'true' makes the sound loop
}

// Check for Enter key press
if (keyboard_check_pressed(vk_enter)) {
    enter_pressed = true;
}

// If Enter is pressed, stop the sound and change the room
if (enter_pressed) {
    audio_stop_sound(intromusic);  // Stop the intro song before changing rooms
    room_goto(Room4);  // Make sure Room4 is a valid room name
}
