// Get the GUI's dimensions to properly align the task bar in the camera's space
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Move the task bar further left and lower
var startX = gui_width - 400;  // Move further to the left (400px from the right)
var startY = 80;  // Lower down to give more top margin

// Set font and alignment for the text
draw_set_font(fnt_instruction);
draw_set_halign(fa_left);

// Function to draw outlined text with shadow
function draw_outlined_text(x, y, text, outline_color, text_color, shadow_color) {
    // Draw shadow slightly offset
    draw_set_color(shadow_color);
    draw_text(x + 2, y + 2, text);  // Shadow offset for a soft effect

    // Draw outline by drawing text in all directions
    draw_set_color(outline_color);
    draw_text(x - 1, y, text);   // Left
    draw_text(x + 1, y, text);   // Right
    draw_text(x, y - 1, text);   // Top
    draw_text(x, y + 1, text);   // Bottom

    // Draw the actual text on top
    draw_set_color(text_color);
    draw_text(x, y, text);
}

// Draw the heading "Tasks" with shadow and outline
draw_outlined_text(startX, startY, "Tasks", c_black, c_white, make_color_rgb(0, 0, 0));
draw_outlined_text(startX, startY + 15, "--------------------------------------------", c_black, c_white, make_color_rgb(0, 0, 0));

// Array of task descriptions
var taskList = [
    "1. Collect Go Dashboard Icon",
    "2. Collect PQMan Icon",
    "3. Collect MZP Icon",
    "4. Collect HI-SPEC Icon",
    "5. Collect OEMS Icon"
];

// Array of corresponding task completion statuses
var taskStatus = [
    global.task_1_complete,
    global.task_2_complete,
    global.task_3_complete,
    global.task_4_complete,
    global.task_5_complete
];

// Loop through each task and draw it with the appropriate color and outline
for (var i = 0; i < array_length(taskList); i++) {
    var color = taskStatus[i] ? c_yellow : c_white;  // Yellow if complete, white if not

    // Draw outlined task text with shadow
    draw_outlined_text(startX, startY + 40 + (i * 25), taskList[i], c_black, color, make_color_rgb(0, 0, 0));
}

// Reset the color back to white for future drawing
draw_set_color(c_white);
