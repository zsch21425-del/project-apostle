// =============================================================
// obj_win_screen — Draw GUI
// =============================================================

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_color(make_color_rgb(15, 25, 40));
draw_rectangle(0, 0, _gw, _gh, false);

draw_set_halign(fa_center);
draw_set_color(make_color_rgb(255, 215, 80));
draw_text_transformed(_gw / 2, _gh / 2 - 60, "WAVE CLEARED", 3, 3, 0);

draw_set_color(c_white);
draw_text(_gw / 2, _gh / 2, "\"You showed mercy where you could have shown wrath.\"");
draw_text(_gw / 2, _gh / 2 + 24, "— Jesus");

var _alpha = 0.5 + 0.5 * sin(pulse);
draw_set_alpha(_alpha);
draw_text(_gw / 2, _gh / 2 + 100, "Press ENTER to return to title");
draw_set_alpha(1);

draw_set_halign(fa_left);
