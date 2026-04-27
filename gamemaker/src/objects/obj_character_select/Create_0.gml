// =============================================================
// obj_character_select — Create
// Up to 4 players claim a disciple. P1 is keyboard-or-pad-0,
// P2..P4 are pad slots 1..3. A claimed slot shows the player tag.
// Pressing Start (P1) begins the game with all claimed players.
// =============================================================

slots = [
    { name: "PETER",   color: make_color_rgb(160,  80,  60), obj: obj_player_peter,   blurb: "The Rock — heavy combo, dash special, teammate-protect." },
    { name: "JOHN",    color: make_color_rgb(200, 200, 220), obj: obj_player_john,    blurb: "The Beloved — staff combo, screen-stun, conversion bonus." },
    { name: "JAMES",   color: make_color_rgb(110, 140, 200), obj: obj_player_james,   blurb: "Son of Thunder — 5-hit flurry, AoE spinner." },
    { name: "MATTHEW", color: make_color_rgb(180, 150,  70), obj: obj_player_matthew, blurb: "Tax Collector — coin throws, blessing-coin drops." }
];

// Per-player cursor and claim
cursor    = [0, 0, 0, 0];
claimed   = [false, false, false, false];
ready     = [false, false, false, false];

// P1 is always claimed by default (keyboard)
claimed[0] = true;

// Keep selected_player_obj in global for the spawn fallback
global.selected_player_obj = slots[cursor[0]].obj;
