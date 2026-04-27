// =============================================================
// obj_player_base — Draw
// MVP placeholder: halo behind, colored rectangle for the body,
// and a name tag. Replace with real sprites in the polish pass.
// =============================================================

draw_player_halo(self);

// Body color tints by character (children set body_color in Create)
var _body = variable_instance_exists(id, "body_color") ? body_color : c_white;

// Damage flash
if (invuln_timer > 0 && (invuln_timer mod 6) < 3) {
    _body = c_red;
}

// Kneeling = sprite scrunches down
var _h = (state == PSTATE_KNEEL) ? 24 : 48;

draw_set_color(_body);
draw_rectangle(x - 12, y - _h, x + 12, y, false);
draw_set_color(c_black);
draw_rectangle(x - 12, y - _h, x + 12, y, true);

// Facing indicator (a small wedge)
draw_set_color(c_white);
var _fx = x + (facing * 14);
draw_triangle(x + (facing * 4), y - _h + 8, _fx, y - _h + 14, x + (facing * 4), y - _h + 20, false);

// Name tag
var _name = variable_instance_exists(id, "char_name") ? char_name : "Disciple";
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(x, y - _h - 14, _name);
draw_set_halign(fa_left);
