sprWidth = sprite_get_width(heartFull) * 0.75;  // Scale down the width
sprHeight = sprite_get_height(heartFull) * 0.75;  // Scale down the height

startX = 20;  // Position very close to the left edge of the room
startY = 15;  // Position very close to the top edge of the room

for (var hearts = 0; hearts < maxHearts; hearts++) 
{
    image = a_hearts[hearts, e_hearts.index];
    xx = startX + (sprWidth * 0.9 * hearts);  // Closer gap between hearts
	
	//shake effect	
	if(hp_temp != hp_current) && (hp_temp > 0) {
		shake = irandom_range(-5, 5);
		
	}else shake = 0;
	
    draw_sprite_ext(heartFull, image, xx, startY + shake, 0.75, 0.75, 0, c_white, 1);  // Scale the heart sprite down
}
