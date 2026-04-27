// =============================================================
// obj_player_james — "Son of Thunder"
// 5-hit lightning flurry, multi-hit aerial spinner,
// AoE Thunder Roll special, combo-chain passive.
// =============================================================

event_inherited();

char_name   = "James";
body_color  = make_color_rgb(110, 140, 200);
weapon_kind = "twin_staff";

var _ms = moveset_james();
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
