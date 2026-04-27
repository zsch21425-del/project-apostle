// =============================================================
// scr_level_system.gml
// Wave data tables + spawning helpers used by obj_controller.
// MVP: Galilee level 1 wave 1 only (3 bandits). Everything else
// is a stub that returns an empty wave list.
// =============================================================
//
// Wave struct:
//   trigger_x  number  fraction of room width that the camera must
//                      reach before this wave activates (0..1)
//   spawns     array   list of { type, x, y } — each spawned when the wave triggers
// =============================================================

function level_galilee_waves() {
    return [
        {
            trigger_x: 0.0,
            spawns: [
                { type: obj_enemy_bandit, x: 480, y: FLOOR_Y },
                { type: obj_enemy_bandit, x: 560, y: FLOOR_Y },
                { type: obj_enemy_bandit, x: 620, y: FLOOR_Y }
            ]
        }
    ];
}

function level_wilderness_waves() {
    return []; // STUB — fill in follow-up pass
}

function level_temple_waves() {
    return []; // STUB — fill in follow-up pass
}

// Spawn every enemy in a wave struct
function level_spawn_wave(_wave) {
    for (var i = 0; i < array_length(_wave.spawns); i++) {
        var _s = _wave.spawns[i];
        instance_create_layer(_s.x, _s.y, "Instances", _s.type);
    }
}

// True when there are no living, fighting enemies left on screen.
// Praying / fleeing enemies don't block wave clear.
function wave_is_cleared() {
    var _alive = 0;
    with (obj_enemy_parent) {
        if (state != ESTATE_FLEE && state != ESTATE_PRAY) _alive++;
    }
    return _alive == 0;
}
