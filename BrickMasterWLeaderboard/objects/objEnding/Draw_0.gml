// Format the time into minutes and seconds
var minutes = floor(completion_time / 60);
var seconds = floor(completion_time mod 60);

// Convert the time to a readable text format
var time_text = "";
if (minutes > 0) {
    time_text += string(minutes) + " Minute" + (minutes > 1 ? "s" : "");
    if (seconds > 0) {
        time_text += " and " + string(seconds) + " Second" + (seconds > 1 ? "s" : "");
    }
} else {
    time_text = string(seconds) + " Second" + (seconds > 1 ? "s" : "");
}

// Create the base result text
var result_label = "Time Taken: ";

// Set the font and alignment
draw_set_font(fnt_intro);  // Replace with your font
draw_set_halign(fa_left);  // Left-align to properly manage spacing

// Calculate the middle-bottom position
var x_pos = (room_width - string_width(result_label + time_text)) / 2;
var y_pos = room_height - 50;  // Adjust based on aesthetics

// Draw the "Time Taken:" part in white
draw_set_color(c_white);
draw_text(x_pos, y_pos - 90, result_label);

// Calculate the new position for the time text right after the label
var time_x_pos = x_pos + string_width(result_label);

// Draw the time value with shadow and outline
// Shadow (black)
draw_set_color(c_black);
draw_text(time_x_pos + 2, y_pos - 88, time_text);

// Outline (black)
draw_text(time_x_pos - 2, y_pos - 90, time_text);  // Left
draw_text(time_x_pos + 2, y_pos - 90, time_text);  // Right
draw_text(time_x_pos, y_pos - 92, time_text);      // Up
draw_text(time_x_pos, y_pos - 88, time_text);      // Down

// Draw the actual time value in yellow on top
draw_set_color(c_yellow);
draw_text(time_x_pos, y_pos - 90, time_text);
