// =============================================================
// obj_enemy_bandit — Cowardly grunt
// Low HP, low pray chance (most bandits flee rather than repent).
// =============================================================

event_inherited();

char_name   = "Bandit";
body_color  = make_color_rgb(80, 60, 50);

hp_max       = 25;
hp           = hp_max;
damage       = 6;
move_speed   = 2;
attack_range = 50;
sight_range  = 250;
pray_chance  = 0.40;
