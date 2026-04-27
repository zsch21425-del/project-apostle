// =============================================================
// obj_character_select — Draw GUI
// 4 disciple cards. Per-player cursors stack on top of the same
// card if multiple players hover the same disciple.
// =============================================================

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_color(make_color_rgb(20, 14, 10));
draw_rectangle(0, 0, _gw, _gh, false);

draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text_transformed(_gw / 2, 50, "CHOOSE YOUR DISCIPLES", 2, 2, 0);

var _slot_w = 140;
var _spacing = 24;
var _total = array_length(slots) * _slot_w + (array_length(slots) - 1) * _spacing;
var _start_x = (_gw - _total) / 2;

// Per-player tag colors
var _ptag_colors = [c_white,
                    make_color_rgb(120, 220, 255),
                    make_color_rgb(255, 200, 120),
                    make_color_rgb(220, 120, 255)];

for (var i = 0; i < array_length(slots); i++) {
    var _s = slots[i];
    var _sx = _start_x + i * (_slot_w + _spacing);
    var _sy = 130;

    draw_set_color(_s.color);
    draw_rectangle(_sx, _sy, _sx + _slot_w, _sy + 180, false);
    draw_set_color(c_black);
    draw_rectangle(_sx, _sy, _sx + _slot_w, _sy + 180, true);

    draw_set_color(c_white);
    draw_text(_sx + _slot_w / 2, _sy + 196, _s.name);

    // Stack any cursors hovering this slot
    var _stack = 0;
    for (var pi = 0; pi < 4; pi++) {
        if (claimed[pi] && cursor[pi] == i) {
            var _tag_y = _sy - 14 - _stack * 14;
            draw_set_color(_ptag_colors[pi]);
            var _tag = "P" + string(pi + 1);
            if (ready[pi]) _tag += " ✓";
            draw_text(_sx + _slot_w / 2, _tag_y, _tag);
            _stack++;
        }
    }
}

// Per-player join prompt (P2..P4)
draw_set_color(make_color_rgb(180, 180, 180));
var _prompt_y = 360;
for (var pi = 1; pi < 4; pi++) {
    var _msg;
    if (!claimed[pi]) {
        _msg = "P" + string(pi + 1) + " — Press START on gamepad " + string(pi) + " to join";
    } else {
        _msg = "P" + string(pi + 1) + " joined" + (ready[pi] ? " (ready)" : "");
    }
    draw_text(_gw / 2, _prompt_y + (pi - 1) * 18, _msg);
}

// Bottom controls hint
draw_set_color(make_color_rgb(220, 220, 200));
draw_text_ext(_gw / 2, _gh - 80, slots[cursor[0]].blurb, 22, _gw - 80);
draw_set_color(make_color_rgb(150, 130, 100));
draw_text(_gw / 2, _gh - 40, "Left/Right cursor — X to ready up — ENTER to start");

draw_set_color(c_white);
draw_set_halign(fa_left);
