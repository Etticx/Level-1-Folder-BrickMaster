// Define the amplitude and speed of the floating effect
var amplitude = 3; // How high the coin will float (change for desired height)
var float_speed = 0.005; // Speed of the floating effect

// Center the floating effect around the original position
y = original_y + amplitude * sin(current_time * float_speed);
