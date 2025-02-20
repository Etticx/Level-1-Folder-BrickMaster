// Get the GUI layer size (matches the screen size)
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Get the width and height of the sprite
var spr_width = sprite_get_width(control);
var spr_height = sprite_get_height(control);

// Define fixed margins (in pixels) for exact positioning from the bottom-right
var margin_right = 10;  // Small margin from the right edge
var margin_bottom = 10; // Small margin from the bottom edge

// Calculate the final x and y positions for bottom-right alignment
var x_pos = gui_width - spr_width - margin_right;
var y_pos = gui_height - spr_height - margin_bottom;

// Draw the sprite at the calculated position
draw_sprite(control, 0, x_pos + 400, y_pos + 200);
