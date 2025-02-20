maxHearts = 3;
hp_current = 60;  // Total HP for 3 hearts (each heart = 20 HP, half heart = 10 HP)
hp_max = hp_current;
hp_temp = hp_current; // Gradually reduces over time until equals to hp_current
shake = 0;

enum e_hearts{
    index,
    full_value,
    half_value,
}

// Initialize hearts and their values
for (var hearts = 0; hearts < maxHearts; hearts++)
{
    a_hearts[hearts, e_hearts.index] = 2; // 2 means full heart
    a_hearts[hearts, e_hearts.full_value] = hp_max - (hearts * (hp_max / maxHearts)); // Full heart value
    a_hearts[hearts, e_hearts.half_value] = a_hearts[hearts, e_hearts.full_value] - (hp_max / (maxHearts * 2)); // Half heart value (10 HP)
}
