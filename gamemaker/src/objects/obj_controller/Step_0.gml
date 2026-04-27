// =============================================================
// obj_controller — Step
// Hit-stop, screen-flash decay, wave management, story-beat
// triggers, level transition.
// =============================================================

if (instance_exists(obj_pause_menu) && obj_pause_menu.paused) exit;

if (hitstop > 0) hitstop--;
if (flash_alpha > 0) flash_alpha = max(0, flash_alpha - 0.05);

// Story beats fire based on the leftmost player's progress
var _p = instance_nearest(0, 0, obj_player_base);
if (_p != noone && room_width > 0) {
    var _progress = clamp(_p.x / room_width, 0, 1);
    for (var i = 0; i < array_length(story_beats); i++) {
        var _beat = story_beats[i];
        if (_progress >= _beat.trigger_x && !array_contains(beats_fired, i)) {
            array_push(beats_fired, i);
            // Spawn a dialogue box (one at a time — older auto-closes)
            with (obj_dialogue_box) instance_destroy();
            var _d = instance_create_layer(0, 0, "Instances", obj_dialogue_box);
            _d.speaker = _beat.speaker;
            _d.text    = _beat.text;
        }
    }
}

// Wave clear detection
if (wave_active && wave_is_cleared()) {
    wave_active = false;
    wave_clear_pause = 60;
}

// Advance to next wave or next room
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
            // Last wave cleared — record progress, transition
            global.last_completed_room = room_get_name(room);
            if (instance_exists(obj_camera)) obj_camera.locked = false;
            room_goto(level_next_room());
        }
    }
}

// Defeat — if all players are kneeling, restart the room
var _alive = 0;
with (obj_player_base) if (state != PSTATE_KNEEL) _alive++;
if (_alive == 0 && instance_number(obj_player_base) > 0) {
    room_restart();
}
