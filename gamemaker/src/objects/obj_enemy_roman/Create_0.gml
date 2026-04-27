// =============================================================
// obj_enemy_roman — Roman Guard
// Disciplined patroller. Can BLOCK incoming damage when facing
// the attacker (45% chance, 0.75s cooldown). Hits harder than
// a bandit but slower.
// =============================================================

event_inherited();

char_name   = "Roman Guard";
body_color  = make_color_rgb(140, 30, 30);

hp_max       = 50;
hp           = hp_max;
damage       = 10;
move_speed   = 2;
attack_range = 50;
sight_range  = 250;
pray_chance  = 0.50;

can_block = true;
