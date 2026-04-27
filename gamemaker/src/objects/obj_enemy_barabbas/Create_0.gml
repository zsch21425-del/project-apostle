// =============================================================
// obj_enemy_barabbas — "Barabbas the Younger"
// Galilee mini-boss. Phase 1 (>50% HP): standard hard-hitting
// chase + telegraphed swings. Phase 2 (<50% HP): faster move,
// shorter attack telegraph, stagger-resistant.
// =============================================================

event_inherited();

char_name  = "Barabbas";
body_color = make_color_rgb(200, 40, 60);

hp_max       = 140;
hp           = hp_max;
damage       = 14;
move_speed   = 2.5;
attack_range = 56;
sight_range  = 320;
pray_chance  = 0.50;

phase = 1;

ai_step_override = function() {
    if (phase == 1 && hp / hp_max <= 0.5) {
        phase = 2;
        move_speed = 3.4;
        damage = 18;
        threshold_stagger = 0.10;     // resist stagger
        body_color = make_color_rgb(255, 60, 40);
    }
    return false; // let parent state machine drive movement
};

on_damage_received = function(_amount, _dir) {
    // Slight damage reduction in phase 2
    return (phase == 2) ? _amount * 0.85 : _amount;
};
