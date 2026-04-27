// =============================================================
// obj_controller — Draw GUI
// HUD: sanctification halo meter, combo counter, summon icon.
// =============================================================

var _p = instance_nearest(0, 0, obj_player_base);
if (_p == noone) exit;

draw_sanctification_meter(20, 20, _p.hp, _p.hp_max);

// Character name + combo
draw_set_color(c_white);
draw_text(20, 80, _p.char_name);

if (_p.combo_high > 1) {
    draw_set_halign(fa_right);
    draw_set_color(c_yellow);
    draw_text_transformed(
        display_get_gui_width() - 20, 30,
        string(_p.combo_high) + "-HIT COMBO",
        2, 2, 0
    );
    draw_set_halign(fa_left);
    draw_set_color(c_white);
}

// Special meter (small bar under the halo)
var _sm_pct = _p.special_meter / _p.special_meter_max;
draw_set_color(make_color_rgb(40, 40, 40));
draw_rectangle(20, 90, 20 + 96, 102, false);
draw_set_color(make_color_rgb(255, 215, 80));
draw_rectangle(20, 90, 20 + 96 * _sm_pct, 102, false);
draw_set_color(c_white);
draw_text(120, 88, "SPECIAL");

// Summon Jesus icon
if (_p.summon_charges > 0) {
    draw_set_color(make_color_rgb(255, 240, 200));
    draw_circle(40, 130, 14, false);
    draw_set_color(c_black);
    draw_text(56, 124, "Press C — Summon Jesus");
    draw_set_color(c_white);
}
