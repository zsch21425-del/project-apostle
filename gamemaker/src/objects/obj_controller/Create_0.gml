// =============================================================
// obj_controller — Create
// Global game state: hit-stop tick, score, wave manager, HUD.
// Place ONE in each gameplay room (rm_galilee, rm_wilderness,
// rm_temple). Holds room-specific wave data.
// =============================================================

// Spawn the player chosen on the select screen.
// If we booted directly into the level (DEBUG_FAST_BOOT or restart),
// default to Peter so the room is always playable.
if (instance_number(obj_player_base) == 0) {
    var _obj = obj_player_peter;
    if (variable_global_exists("selected_player_obj")) {
        _obj = global.selected_player_obj;
    }
    instance_create_layer(120, FLOOR_Y, "Instances", _obj);
}

// Hit-stop tick (frozen when > 0)
hitstop = 0;

// Wave management
waves           = [];          // populated below by the room
current_wave    = 0;
wave_active     = false;
wave_clear_pause = 0;

// Stats
total_converted = 0;
total_defeated  = 0;
level_max_combo = 0;

// Choose this room's wave list. Update this when adding rooms.
switch (room_get_name(room)) {
    case "rm_galilee":     waves = level_galilee_waves();     break;
    case "rm_wilderness":  waves = level_wilderness_waves();  break;
    case "rm_temple":      waves = level_temple_waves();      break;
    default:               waves = [];                        break;
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
