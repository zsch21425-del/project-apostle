// =============================================================
// obj_enemy_money_changer — Easy to convert. Drops a blessing
// coin pickup whenever they're converted (or summoned away).
// =============================================================

event_inherited();

char_name  = "Money Changer";
body_color = make_color_rgb(180, 150, 40);

hp_max       = 30;
hp           = hp_max;
damage       = 6;
move_speed   = 2;
pray_chance  = 0.80;

on_pre_destroy = function() {
    instance_create_layer(x, y - 8, "Instances", obj_blessing_coin);
};
