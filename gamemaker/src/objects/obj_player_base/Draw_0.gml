// =============================================================
// obj_player_base — Draw
// Placeholder body + weapon prop. Replace with sprite_index draw
// once Aseprite sheets are imported (see HANDOVER.md, Phase 9).
// =============================================================

draw_player_halo(self);

// Body color tints by character; flash red when invulnerable
var _body = body_color;
if (invuln_timer > 0 && (invuln_timer mod 6) < 3) {
    _body = c_red;
}

// Kneeling = squashed
var _h = (state == PSTATE_KNEEL) ? 24 : 48;

// Body
draw_set_color(_body);
draw_rectangle(x - 12, y - _h, x + 12, y, false);
draw_set_color(c_black);
draw_rectangle(x - 12, y - _h, x + 12, y, true);

// Head (slightly lighter)
draw_set_color(merge_color(_body, c_white, 0.4));
draw_circle(x, y - _h - 6, 8, false);

// Weapon prop — draws to the facing side at hand-height
if (state != PSTATE_KNEEL) _draw_weapon(self);

// Facing wedge at the chest
draw_set_color(c_white);
draw_triangle(x + (facing * 4), y - _h + 8,
              x + (facing * 14), y - _h + 14,
              x + (facing * 4), y - _h + 20, false);

// Player slot tag (P1 / P2 / etc.) when 2+ players
if (instance_number(obj_player_base) > 1) {
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text(x, y - _h - 30, "P" + string(player_index + 1));
    draw_set_halign(fa_left);
}

// Name tag
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(x, y - _h - 18, char_name);
draw_set_halign(fa_left);

// =============================================================
// _draw_weapon — placeholder for prop-aware sprite work later
// =============================================================
function _draw_weapon(_p) {
    var _hand_x = _p.x + (_p.facing * 16);
    var _hand_y = _p.y - 30;

    // Mid-attack: weapon swings forward
    if (_p.state == PSTATE_ATTACK || _p.state == PSTATE_AIR_ATK || _p.state == PSTATE_SPECIAL) {
        _hand_x += _p.facing * 6;
    }

    switch (_p.weapon_kind) {
        case "net":
            draw_set_color(make_color_rgb(220, 200, 160));
            draw_circle(_hand_x + (_p.facing * 8), _hand_y, 10, true);
            draw_line(_hand_x, _hand_y, _hand_x + (_p.facing * 8), _hand_y);
            break;
        case "staff":
            draw_set_color(make_color_rgb(120, 80, 40));
            draw_line_width(_hand_x, _hand_y - 18, _hand_x + (_p.facing * 4), _hand_y + 18, 3);
            break;
        case "twin_staff":
            draw_set_color(make_color_rgb(120, 80, 40));
            draw_line_width(_hand_x - 4, _hand_y - 14, _hand_x - 4, _hand_y + 8, 2);
            draw_line_width(_hand_x + 4, _hand_y - 14, _hand_x + 4, _hand_y + 8, 2);
            break;
        case "ledger":
            draw_set_color(make_color_rgb(220, 200, 140));
            draw_rectangle(_hand_x - 6, _hand_y - 8, _hand_x + 6, _hand_y + 8, false);
            draw_set_color(make_color_rgb(120, 80, 40));
            draw_rectangle(_hand_x - 6, _hand_y - 8, _hand_x + 6, _hand_y + 8, true);
            // small coin floating near the hand
            draw_set_color(make_color_rgb(255, 215, 80));
            draw_circle(_hand_x + (_p.facing * 12), _hand_y, 3, false);
            break;
    }
    draw_set_color(c_white);
}
