// =============================================================
// obj_controller — Step
// Hit-stop freeze, wave-clear detection, level transition.
// =============================================================

if (hitstop > 0) hitstop--;

if (wave_active && wave_is_cleared()) {
    wave_active = false;
    wave_clear_pause = 60;
}

if (!wave_active && wave_clear_pause > 0) {
    wave_clear_pause--;
    if (wave_clear_pause <= 0) {
        if (current_wave + 1 < array_length(waves)) {
            current_wave++;
            level_spawn_wave(waves[current_wave]);
            wave_active = true;
            if (instance_exists(obj_camera)) {
                obj_camera.locked = true;
                obj_camera.locked_x = obj_camera.x + 120;
            }
        } else {
            // Last wave cleared — go to win screen.
            // Levels 2 and 3 will instead room_goto() the next room.
            if (instance_exists(obj_camera)) obj_camera.locked = false;
            room_goto(rm_win);
        }
    }
}

// Defeat — if all players are kneeling, restart the room.
var _alive = 0;
with (obj_player_base) if (state != PSTATE_KNEEL) _alive++;
if (_alive == 0 && instance_number(obj_player_base) > 0) {
    room_restart();
}
