draw_self();

for(var i = 0; i < fireballs; i++) {
	var xExtra = lengthdir_x(i * 14, direction);
	var yExtra = lengthdir_y(i * 14, direction);
	draw_sprite_ext(fireball, 0, x + xExtra, y + yExtra, 1, 1, spin_angle, c_white, 1);
}
