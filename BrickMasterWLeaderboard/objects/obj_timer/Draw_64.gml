// Set font and alignment for the timer text
draw_set_font(fnt_intro);  // Ensure font is assigned
draw_set_halign(fa_left);  // Align text to the left

// Calculate minutes and seconds
var minutes = floor(timer / 60);  // Get the minutes
var seconds = floor(timer mod 60);  // Get the seconds

// Format the timer text as "MM:SS"
var timer_text = string(minutes) + ":" + (seconds < 10 ? "0" : "") + string(seconds);

// Set the position for the timer text
var textX = 650;
var textY = 10;

// Draw the text with an outline
draw_set_color(c_black);  // Outline color (black)
draw_text(textX - 1, textY, timer_text);  // Left outline
draw_text(textX + 1, textY, timer_text);  // Right outline
draw_text(textX, textY - 1, timer_text);  // Top outline
draw_text(textX, textY + 1, timer_text);  // Bottom outline

// Draw the main text in white
draw_set_color(c_white);
draw_text(textX, textY, timer_text);

// Calculate the width of the timer text to align the sprite properly
var text_width = string_width(timer_text);  // Get the width of the timer text

// Draw the timer sprite right next to the text
var spriteX = textX + text_width + 35;  // Position the sprite to the right of the text
var spriteY = textY + 30;  // Align vertically with the text

draw_sprite(sprite_index, image_index, spriteX, spriteY);  // Draw the sprite
