// Gradually reduce hp_temp to match hp_current
if (hp_temp > hp_current){
    hp_temp -= 0.5;  // Slowly decrease over time
    
    for (var hearts = 0; hearts < maxHearts; hearts++){
        // Full heart
        if (hp_temp >= a_hearts[hearts, e_hearts.full_value]){
            a_hearts[hearts, e_hearts.index] = 2; // Full heart
        }
        // Half heart
        else if (hp_temp >= a_hearts[hearts, e_hearts.half_value]){
            a_hearts[hearts, e_hearts.index] = 1; // Half heart
        }
        // Empty heart
        else {
            a_hearts[hearts, e_hearts.index] = 0; // Empty heart
        }
    }
}
