// =============================================================
// obj_player_john — "The Beloved"
// Balanced staff fighter. 3-hit combo with launcher, screen-stun
// special, conversion-bonus passive.
// =============================================================

event_inherited();

char_name   = "John";
body_color  = make_color_rgb(200, 200, 220);
weapon_kind = "staff";

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
passive_on_combo_hit   = _ms.passive_on_combo_hit;
passive_on_convert     = _ms.passive_on_convert;
passive_per_step       = _ms.passive_per_step;
