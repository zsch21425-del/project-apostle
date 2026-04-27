// =============================================================
// obj_character_select — Draw GUI
// =============================================================

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_color(make_color_rgb(20, 14, 10));
draw_rectangle(0, 0, _gw, _gh, false);

draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text_transformed(_gw / 2, 60, "CHOOSE YOUR DISCIPLE", 2, 2, 0);

var _slot_w = 140;
var _spacing = 24;
var _total = array_length(slots) * _slot_w + (array_length(slots) - 1) * _spacing;
var _start_x = (_gw - _total) / 2;

for (var i = 0; i < array_length(slots); i++) {
    var _s = slots[i];
    var _sx = _start_x + i * (_slot_w + _spacing);
    var _sy = 140;

    // Card backing
    draw_set_color(_s.enabled ? _s.color : make_color_rgb(60, 60, 60));
    draw_rectangle(_sx, _sy, _sx + _slot_w, _sy + 180, false);
    draw_set_color(c_black);
    draw_rectangle(_sx, _sy, _sx + _slot_w, _sy + 180, true);

    // Name
    draw_set_color(c_white);
    draw_text(_sx + _slot_w / 2, _sy + 200, _s.name);

    // Highlight cursor
    if (i == cursor) {
        var _pulse = 0.5 + 0.5 * sin(current_time / 200);
        draw_set_alpha(_pulse);
        draw_set_color(c_yellow);
        draw_rectangle(_sx - 4, _sy - 4, _sx + _slot_w + 4, _sy + 184, true);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }

    // (stub) tag
    if (!_s.enabled) {
        draw_set_color(make_color_rgb(200, 200, 80));
        draw_text(_sx + _slot_w / 2, _sy + 80, "STUB");
        draw_set_color(c_white);
    }
}

// Blurb at bottom
draw_set_color(make_color_rgb(220, 220, 200));
draw_text_ext(_gw / 2, _gh - 80, slots[cursor].blurb, 22, _gw - 80);

draw_set_color(c_white);
draw_set_halign(fa_left);
