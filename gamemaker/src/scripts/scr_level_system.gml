// =============================================================
// scr_level_system.gml
// Wave data + story beats for all three levels.
// =============================================================
//
// Wave struct:
//   trigger_x  number  fraction of room width camera must reach (0..1)
//   spawns     array   list of { type, x, y }
//
// Story beat struct:
//   trigger_x  number  fraction of room width
//   speaker    string  name shown in the dialogue header
//   text       string  body text
// =============================================================

// =============================================================
// LEVEL 1 — THE GALILEE SHORE
// =============================================================

function level_galilee_waves() {
    return [
        // Wave 1 — the docks: tutorial bandits
        {
            trigger_x: 0.0,
            spawns: [
                { type: obj_enemy_bandit, x: 480, y: FLOOR_Y },
                { type: obj_enemy_bandit, x: 560, y: FLOOR_Y },
                { type: obj_enemy_bandit, x: 620, y: FLOOR_Y }
            ]
        },
        // Wave 2 — marketplace: bandits + first Roman
        {
            trigger_x: 0.30,
            spawns: [
                { type: obj_enemy_bandit, x: 1100, y: FLOOR_Y },
                { type: obj_enemy_bandit, x: 1160, y: FLOOR_Y },
                { type: obj_enemy_roman,  x: 1240, y: FLOOR_Y },
                { type: obj_enemy_bandit, x: 1320, y: FLOOR_Y }
            ]
        },
        // Wave 3 — Roman patrol
        {
            trigger_x: 0.55,
            spawns: [
                { type: obj_enemy_roman,  x: 1700, y: FLOOR_Y },
                { type: obj_enemy_roman,  x: 1780, y: FLOOR_Y },
                { type: obj_enemy_bandit, x: 1860, y: FLOOR_Y }
            ]
        },
        // Wave 4 — Barabbas mini-boss
        {
            trigger_x: 0.85,
            spawns: [
                { type: obj_enemy_barabbas, x: 2200, y: FLOOR_Y }
            ]
        }
    ];
}

function level_galilee_beats() {
    return [
        { trigger_x: 0.05, speaker: "Jesus",
          text: "Follow me, and I will make you fishers of men. The shore is troubled today." },
        { trigger_x: 0.27, speaker: "Peter",
          text: "These bandits have been terrorizing the village for weeks. We end this today." },
        { trigger_x: 0.50, speaker: "Matthew",
          text: "Romans. They watch. They take notes. Be careful what we do here, brothers." },
        { trigger_x: 0.95, speaker: "Jesus",
          text: "Well done. You showed mercy where you could have shown wrath. This is the way." }
    ];
}

// =============================================================
// LEVEL 2 — THE WILDERNESS ROAD
// =============================================================

function level_wilderness_waves() {
    return [
        // Wave 1 — dust devils: roman scouts and pharisees
        {
            trigger_x: 0.0,
            spawns: [
                { type: obj_enemy_roman,    x: 480, y: FLOOR_Y },
                { type: obj_enemy_pharisee, x: 580, y: FLOOR_Y },
                { type: obj_enemy_roman,    x: 660, y: FLOOR_Y }
            ]
        },
        // Wave 2 — pharisee squad with debate aura
        {
            trigger_x: 0.30,
            spawns: [
                { type: obj_enemy_pharisee, x: 1100, y: FLOOR_Y },
                { type: obj_enemy_pharisee, x: 1180, y: FLOOR_Y },
                { type: obj_enemy_bandit,   x: 1260, y: FLOOR_Y },
                { type: obj_enemy_bandit,   x: 1340, y: FLOOR_Y }
            ]
        },
        // Wave 3 — temptation in the wilderness
        {
            trigger_x: 0.55,
            spawns: [
                { type: obj_enemy_pharisee,  x: 1700, y: FLOOR_Y },
                { type: obj_enemy_roman,     x: 1780, y: FLOOR_Y },
                { type: obj_enemy_centurion, x: 1900, y: FLOOR_Y }
            ]
        },
        // Wave 4 — False Prophet boss
        {
            trigger_x: 0.85,
            spawns: [
                { type: obj_enemy_false_prophet, x: 2200, y: FLOOR_Y }
            ]
        }
    ];
}

function level_wilderness_beats() {
    return [
        { trigger_x: 0.05, speaker: "John",
          text: "The road to Jerusalem is long. They say the wilderness tests every prophet." },
        { trigger_x: 0.27, speaker: "Pharisee",
          text: "By what authority do you do these things? Show us a sign!" },
        { trigger_x: 0.55, speaker: "James",
          text: "Lord, shall we call down fire from heaven? Like Elijah did?" },
        { trigger_x: 0.60, speaker: "Jesus",
          text: "You know not what spirit you are of. The Son of Man came not to destroy lives, but to save them." },
        { trigger_x: 0.95, speaker: "Jesus",
          text: "Well done. The wilderness has tested you, and you have not turned aside." }
    ];
}

// =============================================================
// LEVEL 3 — THE TEMPLE COURTS
// =============================================================

function level_temple_waves() {
    return [
        // Wave 1 — outer courts: money changers
        {
            trigger_x: 0.0,
            spawns: [
                { type: obj_enemy_money_changer, x: 480, y: FLOOR_Y },
                { type: obj_enemy_money_changer, x: 560, y: FLOOR_Y },
                { type: obj_enemy_money_changer, x: 640, y: FLOOR_Y },
                { type: obj_enemy_money_changer, x: 720, y: FLOOR_Y }
            ]
        },
        // Wave 2 — temple guards arrive
        {
            trigger_x: 0.25,
            spawns: [
                { type: obj_enemy_temple_guard, x: 1100, y: FLOOR_Y },
                { type: obj_enemy_temple_guard, x: 1200, y: FLOOR_Y },
                { type: obj_enemy_money_changer, x: 1300, y: FLOOR_Y }
            ]
        },
        // Wave 3 — Pharisee/Roman alliance
        {
            trigger_x: 0.50,
            spawns: [
                { type: obj_enemy_pharisee,     x: 1700, y: FLOOR_Y },
                { type: obj_enemy_roman,        x: 1780, y: FLOOR_Y },
                { type: obj_enemy_temple_guard, x: 1860, y: FLOOR_Y },
                { type: obj_enemy_pharisee,     x: 1940, y: FLOOR_Y }
            ]
        },
        // Wave 4 — Caiaphas's lieutenants (two centurions)
        {
            trigger_x: 0.80,
            spawns: [
                { type: obj_enemy_centurion, x: 2200, y: FLOOR_Y },
                { type: obj_enemy_centurion, x: 2360, y: FLOOR_Y }
            ]
        }
    ];
}

function level_temple_beats() {
    return [
        { trigger_x: 0.05, speaker: "Jesus",
          text: "It is written, 'My house shall be called a house of prayer'. But you have made it a den of thieves." },
        { trigger_x: 0.27, speaker: "Money Changer",
          text: "Mercy! We did not know! Take the coin, but spare us!" },
        { trigger_x: 0.55, speaker: "Caiaphas (off-stage)",
          text: "The whole world has gone after Him! Send the lieutenants!" },
        { trigger_x: 0.95, speaker: "Jesus",
          text: "It is finished. Go in peace — and tell what you have seen." }
    ];
}

// =============================================================
// HELPERS
// =============================================================

function level_spawn_wave(_wave) {
    for (var i = 0; i < array_length(_wave.spawns); i++) {
        var _s = _wave.spawns[i];
        instance_create_layer(_s.x, _s.y, "Instances", _s.type);
    }
}

function wave_is_cleared() {
    var _alive = 0;
    with (obj_enemy_parent) {
        if (state != ESTATE_FLEE && state != ESTATE_PRAY) _alive++;
    }
    return _alive == 0;
}

// Returns the room to transition to once the current level's
// last wave is cleared. Returns rm_win for level 3.
function level_next_room() {
    switch (room_get_name(room)) {
        case "rm_galilee":     return rm_wilderness;
        case "rm_wilderness":  return rm_temple;
        case "rm_temple":      return rm_win;
        default:               return rm_win;
    }
}
