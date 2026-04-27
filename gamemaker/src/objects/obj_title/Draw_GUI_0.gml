// =============================================================
// obj_title — Draw GUI
// =============================================================

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// Background wash
draw_set_color(make_color_rgb(20, 14, 10));
draw_rectangle(0, 0, _gw, _gh, false);

// Title
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(255, 215, 80));
draw_text_transformed(_gw / 2, _gh / 2 - 80, "DISCIPLES", 4, 4, 0);

draw_set_color(c_white);
draw_text_transformed(_gw / 2, _gh / 2 - 30, "THE WAY", 2, 2, 0);

// Press Enter prompt
var _alpha = 0.5 + 0.5 * sin(pulse);
draw_set_alpha(_alpha);
draw_text(_gw / 2, _gh / 2 + 40, "Press ENTER to begin");
draw_set_alpha(1);

// Hint
draw_set_color(make_color_rgb(150, 130, 100));
draw_text(_gw / 2, _gh - 40, "Arrow keys + X / Z / V / C   |   Gamepad supported");

draw_set_color(c_white);
draw_set_halign(fa_left);
