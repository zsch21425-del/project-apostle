// =============================================================
// obj_enemy_parent — Draw
// Placeholder rectangle + animation cues that replace the
// missing HP meter (sweat drops, kneel pose, hit flash).
// =============================================================

var _tint = c_white;
if (hit_flash > 0) _tint = c_white; // (real impl: shader-based white flash)

// Praying glow
if (state == ESTATE_PRAY) {
    var _pulse = (sin(current_time / 200) + 1) / 2;
    draw_set_color(make_color_rgb(180, 220, 255));
    draw_set_alpha(0.3 + _pulse * 0.2);
    draw_circle(x, y - 24, 32, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(x, y - 70, "?");
    draw_set_halign(fa_left);
}

// Sweat-drops cue when low HP (the "hidden HP bar")
if (is_staggering) {
    var _bob = sin(current_time / 150) * 2;
    draw_set_color(make_color_rgb(120, 180, 220));
    draw_circle(x - 8, y - 50 + _bob, 2, false);
    draw_circle(x + 6, y - 48 + _bob, 2, false);
    draw_set_color(c_white);
}

// Telegraph color shift (red flash) before swing
var _body = body_color;
if (state == ESTATE_ATTACK && attack_telegraph > 10) {
    _body = make_color_rgb(255, 80, 80);
}

// Kneel pose when praying = shorter
var _h = (state == ESTATE_PRAY) ? 24 : 44;

draw_set_color(_body);
draw_rectangle(x - 12, y - _h, x + 12, y, false);
draw_set_color(c_black);
draw_rectangle(x - 12, y - _h, x + 12, y, true);

// Facing wedge
draw_set_color(c_white);
draw_triangle(x + (facing * 4), y - _h + 8,
              x + (facing * 14), y - _h + 14,
              x + (facing * 4), y - _h + 20, false);

// Name tag
draw_set_halign(fa_center);
draw_text(x, y - _h - 14, char_name);
draw_set_halign(fa_left);
