// =============================================================
// obj_player_peter — "The Rock"
// Tank archetype. Slow, hard-hitting 3-hit combo culminating in
// "The Rock Drop" ground-pound. Walk-on-Water dash special.
// Passive: nearby teammates get brief i-frames when Peter is hit.
// =============================================================

event_inherited();

char_name  = "Peter";
body_color = make_color_rgb(160, 80, 60);  // earth-red tunic placeholder

var _ms = moveset_peter();
hp_max         = _ms.hp_max;
hp             = hp_max;
move_speed     = _ms.move_speed;
jump_strength  = _ms.jump_strength;
grab_range     = _ms.grab_range;
combo_chain    = _ms.combo_chain;
air_attack     = _ms.air_attack;
special_move   = _ms.special_move;
passive_on_take_damage = _ms.passive_on_take_damage;
