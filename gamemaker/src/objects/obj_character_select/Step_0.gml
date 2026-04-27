// =============================================================
// obj_character_select — Step
// Per-player cursor + claim. P2..P4 join by pressing Start on
// their gamepad. P1 begins the game by pressing Start when
// everyone claimed is ready.
// =============================================================

for (var pi = 0; pi < 4; pi++) {
    // Allow P2..P4 to join by pressing Start on their pad
    if (!claimed[pi] && pi > 0) {
        if (gamepad_is_connected(pi) && gamepad_button_check_pressed(pi, gp_start)) {
            claimed[pi] = true;
        }
        continue;
    }
    if (!claimed[pi]) continue;

    // Drop out (for P2..P4 only)
    if (pi > 0 && gamepad_is_connected(pi) && gamepad_button_check_pressed(pi, gp_select)) {
        claimed[pi] = false;
        ready[pi] = false;
        continue;
    }

    // Cursor movement (left/right between slots)
    if (input_left(pi)) {
        cursor[pi] = (cursor[pi] + array_length(slots) - 1) mod array_length(slots);
    }
    if (input_right(pi)) {
        cursor[pi] = (cursor[pi] + 1) mod array_length(slots);
    }

    // Confirm — toggle ready
    if (input_attack(pi)) {
        ready[pi] = !ready[pi];
    }
}

// Persist P1's pick to the save file
global.selected_player_obj      = slots[cursor[0]].obj;
global.selected_player_obj_name = object_get_name(slots[cursor[0]].obj);
if (instance_exists(obj_save_manager)) obj_save_manager.save_save();

// Start game when at least P1 is ready and every claimed player is ready
var _all_ready = true;
var _any_claimed = false;
for (var pi = 0; pi < 4; pi++) {
    if (claimed[pi]) {
        _any_claimed = true;
        if (!ready[pi]) { _all_ready = false; break; }
    }
}

if (_any_claimed && _all_ready
    && (keyboard_check_pressed(vk_enter)
        || keyboard_check_pressed(vk_space)
        || gamepad_button_check_pressed(0, gp_start))) {
    // Build roster: array of { player_index, obj }
    global.roster = [];
    for (var pi = 0; pi < 4; pi++) {
        if (claimed[pi]) {
            array_push(global.roster, { player_index: pi, obj: slots[cursor[pi]].obj });
        }
    }
    // Resume from saved progress if any, else go to Galilee
    var _next = rm_galilee;
    if (variable_global_exists("last_completed_room")) {
        switch (global.last_completed_room) {
            case "rm_galilee":     _next = rm_wilderness; break;
            case "rm_wilderness":  _next = rm_temple;     break;
            case "rm_temple":      _next = rm_galilee;    break; // cleared — replay
        }
    }
    room_goto(_next);
}
