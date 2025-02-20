// Define dead zone values (adjust these as needed)
var dead_zone_height = 100;  // Height of the dead zone (vertical tolerance)
var follow_speed = 0.1;       // Base speed of camera smoothing
var zoom_out_factor = 1.0;    // Keep this at 1.0 since no zoom out is needed for full room view

// Get camera view size
var wCam = camera_get_view_width(view_camera[0]);
var hCam = camera_get_view_height(view_camera[0]);

// Calculate the target horizontal camera position
var xCam = clamp(oPlayer.x - wCam / 2, 0, room_width - wCam);

// Get current vertical camera position
var curY = camera_get_view_y(view_camera[0]);

// Calculate the target vertical position
var targetY = curY;

if (oPlayer.y < curY + (hCam / 2) - dead_zone_height || oPlayer.y > curY + (hCam / 2) + dead_zone_height) {
    targetY = clamp(oPlayer.y - (hCam / 2) / zoom_out_factor, 0, room_height - hCam);
}

// Calculate the distance to the target for smoother transitions
var distanceY = targetY - curY;

// Smoothly interpolate towards the new vertical position using lerp
var newY = curY + (distanceY * follow_speed);

// Set the new camera position (smooth horizontal and vertical movement)
camera_set_view_pos(view_camera[0], xCam, newY);


