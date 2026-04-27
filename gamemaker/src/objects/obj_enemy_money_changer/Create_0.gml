// =============================================================
// obj_enemy_money_changer — Easy to convert (STUB)
// Drops blessing-coin pickup on conversion (later pass).
// =============================================================

event_inherited();

char_name  = "Money Changer";
body_color = make_color_rgb(180, 150, 40);

hp_max       = 30;
hp           = hp_max;
damage       = 6;
move_speed   = 2;
pray_chance  = 0.80;  // very high — most repent
