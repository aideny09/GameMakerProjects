// --- movement ---
x_speed = 0;
y_speed += 0.5;

if (keyboard_check(vk_right)) {
    x_speed = walk_speed;
    image_xscale = -1;
} else if (keyboard_check(vk_left)) {
    x_speed = -walk_speed;
    image_xscale = 1;
}

// --- jump (small jump) ---
if (place_meeting(x, y + 1, oSolid)) {
    if (keyboard_check_pressed(vk_up)) {
        y_speed = -7;
    } else if (y_speed > 0) {
        y_speed = 0;
    }
}

// --- apply movement ---
move_and_collide(x_speed, y_speed, oSolid);

// helper: send player back to start + count loop
function loop_back() {
    x = spawn_x;
    y = spawn_y;
    x_speed = 0;
    y_speed = 0;
    count += 1;
}

// --- hazards / out of bounds ---
if (place_meeting(x, y, oSpikes)) {
    loop_back();
}

if (y > room_height || y < 0 || x > room_width || x < 0) {
    loop_back();
}

// --- win condition (show once, then loop back) ---
if (!won && place_meeting(x, y, oFlag)) {
    won = true;
    show_message("YOU ESCAPED! (…or did you?)\nDeath: " + string(count-1));
    loop_back();
    won = false; // allows winning again after looping (remove if you want only once)
}