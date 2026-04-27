// =============================================================
// obj_controller — Draw GUI
// Per-player HUD slots + screen flash overlay.
// =============================================================

// Draw a HUD card per active player (P1 top-left, P2 next, etc.)
var _slot = 0;
with (obj_player_base) {
    var _ox = 20 + _slot * 200;
    var _oy = 20;
    draw_sanctification_meter(_ox, _oy, hp, hp_max);

    draw_set_color(c_white);
    draw_text(_ox, _oy + 64, "P" + string(player_index + 1) + " — " + char_name);

    // Special meter
    var _sm_pct = special_meter / special_meter_max;
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_rectangle(_ox, _oy + 78, _ox + 96, _oy + 88, false);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_rectangle(_ox, _oy + 78, _ox + 96 * _sm_pct, _oy + 88, false);

    draw_set_color(c_white);
    if (summon_charges > 0) {
        draw_text(_ox, _oy + 92, "C — Summon Jesus");
    }

    // Combo counter (only the top combo so HUD stays uncluttered)
    if (combo_high > 1) {
        draw_set_color(c_yellow);
        draw_text(_ox, _oy + 108, string(combo_high) + "-HIT");
        draw_set_color(c_white);
    }

    _slot++;
}

// Screen flash overlay
if (flash_alpha > 0) {
    draw_set_color(flash_color);
    draw_set_alpha(flash_alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
