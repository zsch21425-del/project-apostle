// =============================================================
// obj_hideout — Draw GUI
// Stone-walls hideout placeholder. Replace with real background
// art (see HANDOVER.md, Phase 9 — "rm_hideout" sprite specs).
// =============================================================

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// Wall fill — warm dark stone
draw_set_color(make_color_rgb(28, 22, 18));
draw_rectangle(0, 0, _gw, _gh, false);

// Stone-block hatch
draw_set_color(make_color_rgb(46, 36, 28));
for (var bx = 0; bx < _gw; bx += 64) {
    for (var by = 0; by < _gh; by += 32) {
        var _ox = ((by / 32) mod 2 == 0) ? 0 : 32;
        draw_rectangle(bx + _ox, by, bx + _ox + 60, by + 28, true);
    }
}

// Torch flicker on left and right walls
var _flick = 0.7 + sin(torch_phase) * 0.3;
draw_set_alpha(_flick);
draw_set_color(make_color_rgb(255, 180, 80));
draw_circle(60, 90, 60, false);
draw_circle(_gw - 60, 90, 60, false);
draw_set_alpha(1);

// Jesus seated, holding scroll (placeholder)
var _jx = _gw / 2;
var _jy = _gh / 2 + 40;
draw_set_color(make_color_rgb(120, 100, 80));   // stool
draw_rectangle(_jx - 20, _jy + 20, _jx + 20, _jy + 60, false);
draw_set_color(make_color_rgb(180, 140, 100));  // robe
draw_rectangle(_jx - 24, _jy - 10, _jx + 24, _jy + 22, false);
draw_set_color(make_color_rgb(220, 200, 180));  // head
draw_circle(_jx, _jy - 20, 10, false);
draw_set_color(make_color_rgb(255, 230, 180));  // halo
draw_set_alpha(0.4 + sin(torch_phase) * 0.1);
draw_circle(_jx, _jy - 20, 18, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(220, 200, 140));  // scroll in hands
draw_rectangle(_jx - 14, _jy + 4, _jx + 14, _jy + 12, false);

// Disciples flanking
var _dx = [_jx - 130, _jx - 70, _jx + 70, _jx + 130];
var _colors = [make_color_rgb(160,80,60), make_color_rgb(200,200,220),
               make_color_rgb(110,140,200), make_color_rgb(180,150,70)];
var _names  = ["Peter", "John", "James", "Matthew"];
for (var i = 0; i < 4; i++) {
    draw_set_color(_colors[i]);
    draw_rectangle(_dx[i] - 12, _jy - 4, _dx[i] + 12, _jy + 30, false);
    draw_set_color(make_color_rgb(220, 200, 180));
    draw_circle(_dx[i], _jy - 14, 8, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(_dx[i], _jy + 36, _names[i]);
    draw_set_halign(fa_left);
}

// Title bar
draw_set_color(make_color_rgb(255, 215, 80));
draw_set_halign(fa_center);
draw_text_transformed(_gw / 2, 50, "THE HIDEOUT", 2, 2, 0);
draw_set_halign(fa_left);

// Dialogue panel (re-using the same shape as obj_dialogue_box for cohesion)
if (dialogue_index < array_length(dialogue)) {
    var _line = dialogue[dialogue_index];
    var _box_x = 40;
    var _box_y = _gh - 140;
    var _box_w = _gw - 80;
    var _box_h = 100;

    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(15, 12, 8));
    draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(220, 180, 80));
    draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, true);

    draw_set_color(make_color_rgb(255, 215, 80));
    draw_rectangle(_box_x + 12, _box_y - 12, _box_x + 152, _box_y + 8, false);
    draw_set_color(c_black);
    draw_text(_box_x + 22, _box_y - 8, _line.speaker);

    draw_set_color(c_white);
    draw_text_ext(_box_x + 16, _box_y + 18, _line.text, 22, _box_w - 32);

    var _alpha = 0.5 + 0.5 * sin(prompt_pulse);
    draw_set_alpha(_alpha);
    draw_set_halign(fa_right);
    draw_text(_box_x + _box_w - 12, _box_y + _box_h - 22, "[Enter] continue");
    draw_set_halign(fa_left);
    draw_set_alpha(1);
}

draw_set_color(c_white);
