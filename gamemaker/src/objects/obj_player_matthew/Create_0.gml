// =============================================================
// obj_player_matthew — "The Tax Collector" (STUB)
// Real Quill Jab / Ledger Sweep / Coin Throw mixed-range combo
// + Render Unto Caesar special lands in a follow-up pass.
// =============================================================

event_inherited();

char_name  = "Matthew";
body_color = make_color_rgb(180, 150, 70);  // mustard tunic placeholder

var _ms = moveset_matthew();
hp_max         = _ms.hp_max;
hp             = hp_max;
move_speed     = _ms.move_speed;
jump_strength  = _ms.jump_strength;
grab_range     = _ms.grab_range;
combo_chain    = _ms.combo_chain;
air_attack     = _ms.air_attack;
special_move   = _ms.special_move;
passive_on_take_damage = _ms.passive_on_take_damage;
