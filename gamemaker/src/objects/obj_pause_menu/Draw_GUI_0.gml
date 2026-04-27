// =============================================================
// obj_pause_menu — Draw GUI
// Dimmed background + centered option list.
// =============================================================

if (!paused) exit;

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// Dim
draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(0, 0, _gw, _gh, false);
draw_set_alpha(1);

// Title
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(255, 215, 80));
draw_text_transformed(_gw / 2, _gh / 2 - 100, "PAUSED", 3, 3, 0);

// Options
draw_set_color(c_white);
for (var i = 0; i < array_length(options); i++) {
    var _y = _gh / 2 - 20 + i * 40;
    if (i == cursor) {
        draw_set_color(c_yellow);
        draw_text(_gw / 2 - 110, _y, ">");
        draw_text(_gw / 2 + 110, _y, "<");
    }
    draw_set_color(c_white);
    draw_text(_gw / 2, _y, options[i]);
}

draw_set_halign(fa_left);
