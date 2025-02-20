// If Goomba is stomped, disable movement, collision, and destruction alarm
if (sprite_index == spr_goomba_stomp) {
    // Stop Goomba's movement and gravity
    move_speed = 0;
    vspeed = 0;

    // Ensure Goomba doesn't interact with the player anymore
    collision_enabled = false;  // Disables any collision
    solid = false;  // Goomba is no longer solid

    // Goomba should be destroyed after the alarm goes off
    if (alarm[0] == 0) {
        instance_destroy();  // Destroy Goomba after alarm time ends
    }
} else {
    // Normal Goomba movement logic
    x += lengthdir_x(move_speed, direction);
    y += lengthdir_y(move_speed, direction);

    // Apply gravity
    vspeed += gravity;

    // Check for ground or platform
    var onGround = place_meeting(x, y + 1, oWall);
    var onEdgeLeft = place_meeting(x - 1, y + 1, oWall);
    var onEdgeRight = place_meeting(x + 1, y + 1, oWall);

    // Reverse direction if no ground or at edge
    if (!onGround && !onEdgeLeft && !onEdgeRight) {
        direction = direction + 180; // Reverse direction
    }

    // Reverse direction when hitting walls
    if (place_meeting(x + lengthdir_x(move_speed, direction), y, oWall) || place_meeting(x + lengthdir_x(move_speed, direction), y, oGoombaWall)) {
        direction = direction + 180; // Reverse direction
    }

    // Stomp logic for player bouncing off Goomba
    if (place_meeting(x, y - 4, oPlayer) && oPlayer.vspeed > 0 && !oPlayer.isDead) {
        // Player jumps down onto Goomba
        sprite_index = spr_goomba_stomp; // Change to stomped sprite
        alarm[0] = 30;  // Start destruction alarm after stomp
        oPlayer.vspeed = -10;  // Bounce player upward
        collision_enabled = false;  // Disable collision with Goomba
        solid = false;  // Make Goomba non-solid
    }
    // Damage player when Goomba collides with the side
    else if (place_meeting(x, y, oPlayer) && oPlayer.vspeed <= 0 && oPlayer.invincibility_timer == 0 && !oPlayer.isDead) {
        var oHealth_instance = instance_find(oHealth, 0);

        if (oHealth_instance != noone) {
            oHealth_instance.hp_current -= 20;
            audio_play_sound(aHit, 1, false);

            if (oHealth_instance.hp_current <= 0) {
                oPlayer.isDead = true;
                oPlayer.sprite_index = spr_mario_death;
                oPlayer.death_timer = 60;
                audio_play_sound(aDeath, 1, false);
            } else {
                oPlayer.invincibility_timer = 120;  // Temporary invincibility after hit
            }
        }
    }

    // Gravity and ground collision checks
    if (place_meeting(x, y + vspeed, oWall)) {
        while (!place_meeting(x, y + sign(vspeed), oWall)) {
            y += sign(vspeed);
        }
        vspeed = 0;  // Stop falling when on the ground
    } else {
        y += vspeed;  // Apply gravity
    }
}
