// =============================================================
// obj_player_matthew — "The Tax Collector"
// Mixed melee + coin throw combo. Air fan + coin-storm special.
// Conversion drops a blessing-coin pickup for teammates.
// =============================================================

event_inherited();

char_name   = "Matthew";
body_color  = make_color_rgb(180, 150, 70);
weapon_kind = "ledger";

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
passive_on_combo_hit   = _ms.passive_on_combo_hit;
passive_on_convert     = _ms.passive_on_convert;
passive_per_step       = _ms.passive_per_step;
