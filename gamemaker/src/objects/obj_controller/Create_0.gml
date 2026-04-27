// =============================================================
// obj_controller — Create
// Global game state: hit-stop, screen flash, score, wave manager,
// story beats, HUD. Place ONE in each gameplay room.
// =============================================================

// Spawn the roster picked on the select screen. If no roster was
// set (e.g. DEBUG_FAST_BOOT or first launch), fall back to single
// Peter so the room is always playable.
if (instance_number(obj_player_base) == 0) {
    if (variable_global_exists("roster") && array_length(global.roster) > 0) {
        for (var i = 0; i < array_length(global.roster); i++) {
            var _entry = global.roster[i];
            var _p = instance_create_layer(120 + i * 32, FLOOR_Y, "Instances", _entry.obj);
            _p.player_index = _entry.player_index;
        }
    } else {
        var _obj = obj_player_peter;
        if (variable_global_exists("selected_player_obj")) {
            _obj = global.selected_player_obj;
        }
        var _p = instance_create_layer(120, FLOOR_Y, "Instances", _obj);
        _p.player_index = 0;
    }
}

// Hit-stop tick (gameplay frozen when > 0)
hitstop = 0;

// Screen flash (drawn in Draw GUI)
flash_alpha = 0;
flash_color = c_white;

// Wave management
waves            = [];
current_wave     = 0;
wave_active      = false;
wave_clear_pause = 0;

// Story beats
story_beats  = [];
beats_fired  = [];

// Stats
total_converted = 0;
total_defeated  = 0;
level_max_combo = 0;
level_start_time = current_time;

switch (room_get_name(room)) {
    case "rm_galilee":
        waves = level_galilee_waves();
        story_beats = level_galilee_beats();
        break;
    case "rm_wilderness":
        waves = level_wilderness_waves();
        story_beats = level_wilderness_beats();
        break;
    case "rm_temple":
        waves = level_temple_waves();
        story_beats = level_temple_beats();
        break;
    default:
        waves = [];
        story_beats = [];
        break;
}

// Spawn the first wave immediately
if (array_length(waves) > 0) {
    level_spawn_wave(waves[0]);
    current_wave = 0;
    wave_active = true;
    if (instance_exists(obj_camera)) {
        obj_camera.locked = true;
        obj_camera.locked_x = obj_camera.x;
    }
}
