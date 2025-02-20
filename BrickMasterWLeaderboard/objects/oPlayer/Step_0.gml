if (!isDead) {
    var xDirection = 0;
    var jump = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up);
    var onTheGround = place_meeting(x, y + 1, oWall);

    var aKey = keyboard_check(ord("A")) || keyboard_check(vk_left);
    var dKey = keyboard_check(ord("D")) || keyboard_check(vk_right);
	elapsed_time += 1 / room_speed; // Initialize elapsed time
    // Handle left/right movement
    if (aKey && dKey) {
        xDirection = 0; // No movement if both keys are pressed
    } else if (dKey) {
        xDirection = 1;
    } else if (aKey) {
        xDirection = -1;
    }
	
	if (!audio_is_playing(mainSong)) {
    audio_play_sound(mainSong, 1, true);  // 'true' makes the sound loop
	}


    if (xDirection != 0) image_xscale = xDirection;

    xSpeed = xDirection * spd;
    ySpeed++; // Gravity

    if (onTheGround) {
        // Handle walking, stopping, and jumping animations
        if (xDirection != 0 && stopCooldown == 0) {
            sprite_index = spr_mario_walk;
            isStopping = false;
            wasWalking = true;
        } else if (xDirection == 0 && wasWalking && !isStopping && stopCooldown == 0) {
            sprite_index = spr_mario_stop;
            isStopping = true;
            stopCooldown = 10;
        } else if (xDirection == 0 && !isStopping && stopCooldown == 0) {
            sprite_index = spr_mario_idle;
            wasWalking = false;
        }

        if (jump) {
            ySpeed = -14; // Set jump speed
            isStopping = false;
            stopCooldown = 0;
        }
    } else {
        sprite_index = spr_mario_jump;
        isStopping = false;
        stopCooldown = 0;
    }

    if (stopCooldown > 0) {
        stopCooldown--;
        if (sprite_index == spr_mario_stop && image_index >= image_number - 1) {
            isStopping = false;
            sprite_index = spr_mario_idle;
        }
    }

    // Check for stomp interaction with Goomba
    var stomped_goomba = instance_place(x, y + ySpeed, oGoomba);
    if (stomped_goomba != noone && ySpeed > 0 && invincibility_timer == 0) {
        ySpeed = -15; // Bounce up after stomping the Goomba

        // Change Goomba sprite to stomped and set destruction alarm
        with (stomped_goomba) {
            sprite_index = spr_goomba_stomp;
			audio_play_sound(aStomp, 1, false);
            alarm[0] = 30; // Destroy Goomba after a short delay
        }
    }
    // Check for collision with Goomba when not stomping
    else {
        var hit_goomba = instance_place(x, y, oGoomba);
        if (hit_goomba != noone && ySpeed <= 0 && invincibility_timer == 0) {
            // Reduce health only if not in invincibility mode
            var oHealth_instance = instance_find(oHealth, 0); // Get the first instance of oHealth

            if (oHealth_instance != noone) {
                oHealth_instance.hp_current -= 20; // Reduce health by 20
                invincibility_timer = 120; // Start invincibility timer

                // Check if player's health reaches zero
                if (oHealth_instance.hp_current <= 0) {
					audio_stop_sound(mainSong);
                    isDead = true; // Player dies
                    sprite_index = spr_mario_death; // Set death sprite
                    death_timer = 60; // Set delay before death
                } else {
                    audio_play_sound(aHit, 1, false); // Play hit sound
                }
            }
        }
    }

    // Handle collisions with walls on the X-axis
    if (place_meeting(x + xSpeed, y, oWall)) {
        while (!place_meeting(x + sign(xSpeed), y, oWall)) {
            x += sign(xSpeed);
        }
        xSpeed = 0; // Stop movement on collision
    }
    x += xSpeed; // Move the player on the X-axis

    // Handle collisions with walls on the Y-axis
    if (place_meeting(x, y + ySpeed, oWall)) {
        while (!place_meeting(x, y + sign(ySpeed), oWall)) {
            y += sign(ySpeed);
        }
        ySpeed = 0; // Stop movement on collision
    }
    y += ySpeed; // Move the player on the Y-axis

    if (place_meeting(x, y, oWall)) {
        for (var i = 0; i < 1000; ++i) {
            // Right
            if (!place_meeting(x + i, y, oWall)) {
                x += i;
                break;
            }
            // Left
            if (!place_meeting(x - i, y, oWall)) {
                x -= i;
                break;
            }
            // Up
            if (!place_meeting(x, y - i, oWall)) {
                y -= i;
                break;
            }
            // Down
            if (!place_meeting(x, y + i, oWall)) {
                y += i;
                break;
            }
            // Top Right
            if (!place_meeting(x + i, y - i, oWall)) {
                x += i;
                y -= i;
                break;
            }
            // Bottom Right
            if (!place_meeting(x + i, y + i, oWall)) {
                x += i;
                y += i;
                break;
            }
            // Top Left
            if (!place_meeting(x - i, y - i, oWall)) {
                x -= i;
                y -= i;
                break;
            }
            // Bottom Left
            if (!place_meeting(x - i, y + i, oWall)) {
                x -= i;
                y += i;
                break;
            }
        }
    }

    // *** Handle invincibility timer ***
if (invincibility_timer > 0) {
    invincibility_timer--;  // Decrease the timer if player is invincible

    // Make Mario blink by changing opacity
    if (invincibility_timer mod 10 < 5) {
        image_alpha = 0.5;  // Lower opacity to 50%
    } else {
        image_alpha = 1.0;  // Restore full opacity
    }
} else {
    image_alpha = 1.0;  // Ensure opacity is normal when invincibility ends
}

    // Health Reduction on Firewall Collision ***
    if (place_meeting(x, y, oFirewall) && invincibility_timer == 0) {
        var oHealth_instance = instance_find(oHealth, 0); // Get the first instance of oHealth
        
        if (oHealth_instance != noone) {
            damage = 20;
            if (oHealth_instance.hp_current - damage >= 0) {
                oHealth_instance.hp_current -= damage;
            } else {
                oHealth_instance.hp_current = 0;
            }

            // Play the hit sound whenever the health decreases
            audio_play_sound(aHit, 1, false);

            if (oHealth_instance.hp_current <= 0) {
				audio_stop_sound(mainSong);
                isDead = true;
                sprite_index = spr_mario_death; // Change to death sprite
                death_timer = 60; // Set freeze timer before fall starts
                ySpeed = 0; // Freeze in the air initially
                audio_play_sound(aDeath, 1, false); // Play death sound
                
                // Freeze the camera at Mario's death position
                camera_x = camera_get_view_x(view_camera[0]);
                camera_y = camera_get_view_y(view_camera[0]);
                camera_frozen = true; // Freeze camera after death
            } else {
                invincibility_timer = 120; // Invincibility after taking damage
            }
        }
    }
	// Check if all coin instances are collected
if (instance_exists(oCoin) || instance_exists(oCoin_1) || instance_exists(oCoin_2) || instance_exists(oCoin_3) || instance_exists(oCoin_4)) {
    // Do nothing, as there are still coins left
} else {
    game_completed = true;
	global.timer_value = elapsed_time;
	audio_stop_sound(mainSong);
    room_goto(roomEnd);
}

    // Check for collision with fireballs spawned by the firewall
    var nearest_fireball = instance_nearest(x, y, oFireball); // Get the nearest fireball instance
    if (nearest_fireball != noone && place_meeting(x, y, nearest_fireball) && invincibility_timer == 0) {
        var oHealth_instance = instance_find(oHealth, 0); 

        if (oHealth_instance != noone) {
            // Reduce health by 20 HP
            damage = 20;
            if (oHealth_instance.hp_current - damage >= 0) {
                oHealth_instance.hp_current -= damage;
            } else {
                oHealth_instance.hp_current = 0;
            }

            // Play the hit sound whenever the health decreases
            audio_play_sound(aHit, 1, false);

            // Check if health is zero
            if (oHealth_instance.hp_current <= 0) {
				audio_stop_sound(mainSong);
                isDead = true; // Set dead state
                sprite_index = spr_mario_death; // Change to death sprite
                death_timer = 60; // Set countdown for death animation
                audio_play_sound(aDeath, 1, false); // Play death sound
                
                // Freeze the camera at Mario's death position
                camera_x = camera_get_view_x(view_camera[0]);
                camera_y = camera_get_view_y(view_camera[0]);
                camera_frozen = true; // Freeze camera after death
            } else {
                // Start invincibility cooldown
                invincibility_timer = 120;
            }
        }
    }

} else {
    // Handle death animation
    if (death_timer > 0) {
        death_timer--; // Freeze in the air for a moment
		audio_stop_sound(mainSong);
    } else {
        ySpeed += 0.5; // Start falling after the freeze
        y += ySpeed; // Apply gravity to make Mario fall

        // When Mario falls off the screen, restart the game
        if (y > room_height + sprite_height) {
            room_goto(rm_gameover);
        }
    }
	
	

    // Freeze the camera at the death position
    if (camera_frozen) {
        camera_set_view_pos(view_camera[0], camera_x, camera_y);
    }
}