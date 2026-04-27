// =============================================================
// obj_player_john — "The Beloved" (STUB)
// Stat values are placeholder. Real moveset (Staff Thrust /
// Rising Strike / Beloved Sweep + Light of the World special)
// lands in a follow-up pass.
// =============================================================

event_inherited();

char_name  = "John";
body_color = make_color_rgb(200, 200, 220);  // pale tunic placeholder

var _ms = moveset_john();
hp_max         = _ms.hp_max;
hp             = hp_max;
move_speed     = _ms.move_speed;
jump_strength  = _ms.jump_strength;
grab_range     = _ms.grab_range;
combo_chain    = _ms.combo_chain;
air_attack     = _ms.air_attack;
special_move   = _ms.special_move;
passive_on_take_damage = _ms.passive_on_take_damage;
