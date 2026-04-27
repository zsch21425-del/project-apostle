// =============================================================
// obj_dialogue_box — Draw GUI
// Bottom-of-screen speech panel.
// =============================================================

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _box_x  = 40;
var _box_y  = _gh - 120;
var _box_w  = _gw - 80;
var _box_h  = 90;

draw_set_alpha(fade_in * 0.85);
draw_set_color(make_color_rgb(15, 12, 8));
draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, false);

draw_set_alpha(fade_in);
draw_set_color(make_color_rgb(220, 180, 80));
draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, true);
draw_rectangle(_box_x + 2, _box_y + 2, _box_x + _box_w - 2, _box_y + _box_h - 2, true);

// Speaker name plate
draw_set_color(make_color_rgb(255, 215, 80));
draw_rectangle(_box_x + 12, _box_y - 12, _box_x + 12 + 140, _box_y + 8, false);
draw_set_color(c_black);
draw_text(_box_x + 22, _box_y - 8, speaker);

// Body text
draw_set_color(c_white);
draw_text_ext(_box_x + 16, _box_y + 18, text, 22, _box_w - 32);

// Skip prompt
draw_set_alpha(fade_in * 0.6);
draw_set_halign(fa_right);
draw_text(_box_x + _box_w - 12, _box_y + _box_h - 18, "[Enter]");
draw_set_halign(fa_left);

draw_set_alpha(1);
draw_set_color(c_white);
