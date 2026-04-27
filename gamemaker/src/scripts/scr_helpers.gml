// =============================================================
// scr_helpers.gml
// Sanctification (player HP), halo UI, hitbox spawning,
// and small utilities shared by player + enemy code.
// =============================================================

// -------------------------------------------------------------
// Sanctification: the player's faith meter, doubles as HP.
// 70-100% = gold halo (blessed)
// 30-70%  = white halo (steady)
// 0-30%   = pulsing red (warning)
// -------------------------------------------------------------

function sanctification_take_damage(_player, _amount) {
    if (_player.invuln_timer > 0) return;

    _player.hp = max(0, _player.hp - _amount);
    _player.invuln_timer = _player.invuln_duration;

    if (instance_exists(obj_camera)) {
        obj_camera.shake_amount = min(_amount * 0.4, 8);
    }
    if (instance_exists(obj_controller)) {
        obj_controller.hitstop = 4;
    }

    _player.passive_on_take_damage(_player, _amount);
}

function sanctification_restore(_player, _amount) {
    _player.hp = min(_player.hp_max, _player.hp + _amount);
}

// -------------------------------------------------------------
// Hitbox spawn — used by player attack moves
// -------------------------------------------------------------

function spawn_player_hitbox(_owner, _move) {
    var _hb = instance_create_layer(
        _owner.x + (_move.hitbox_x * _owner.facing),
        _owner.y + _move.hitbox_y,
        "Instances",
        obj_hitbox
    );
    _hb.team        = TEAM_PLAYER;
    _hb.owner       = _owner.id;
    _hb.facing      = _owner.facing;
    _hb.damage      = _move.damage;
    _hb.knockback   = _move.knockback;
    _hb.hitstun     = _move.hitstun;
    _hb.hitstop     = _move.hitstop;
    _hb.lifetime    = max(1, _move.frames - _move.recovery);
    _hb.box_w       = _move.hitbox_w;
    _hb.box_h       = _move.hitbox_h;
    return _hb;
}

function spawn_enemy_hitbox(_owner, _x_off, _y_off, _w, _h, _dmg) {
    var _hb = instance_create_layer(
        _owner.x + (_x_off * _owner.facing),
        _owner.y + _y_off,
        "Instances",
        obj_hitbox
    );
    _hb.team      = TEAM_ENEMY;
    _hb.owner     = _owner.id;
    _hb.facing    = _owner.facing;
    _hb.damage    = _dmg;
    _hb.knockback = 4;
    _hb.hitstun   = 16;
    _hb.hitstop   = 3;
    _hb.lifetime  = 6;
    _hb.box_w     = _w;
    _hb.box_h     = _h;
    return _hb;
}

// -------------------------------------------------------------
// HUD: halo-shaped sanctification meter
// Drawn in obj_controller's Draw GUI event
// -------------------------------------------------------------

function draw_sanctification_meter(_x, _y, _hp, _hp_max) {
    var _pct = (_hp_max > 0) ? (_hp / _hp_max) : 0;
    var _radius = 28;
    var _meter_color = halo_color_for_pct(_pct);

    // Dark backing
    draw_set_color(make_color_rgb(40, 30, 20));
    draw_circle(_x + _radius, _y + _radius, _radius, false);

    // Arc fill (segmented to look like a halo)
    draw_set_color(_meter_color);
    var _segments = 32;
    var _fill = floor(_segments * _pct);
    for (var i = 0; i < _fill; i++) {
        var _angle = (i / _segments) * 360 - 90;
        var _px = _x + _radius + lengthdir_x(_radius - 4, _angle);
        var _py = _y + _radius + lengthdir_y(_radius - 4, _angle);
        draw_circle(_px, _py, 3, false);
    }

    // Pulse warning text when low
    if (_pct < SANCT_DANGER_PCT) {
        var _pulse = (sin(current_time / 150) + 1) / 2;
        draw_set_color(make_color_rgb(255, 80, 80));
        draw_set_alpha(0.5 + _pulse * 0.5);
        draw_text(_x + _radius * 2 + 12, _y + _radius - 4, "PRAY!");
        draw_set_alpha(1);
    }

    draw_set_color(c_white);
}

// -------------------------------------------------------------
// Halo glow drawn behind the player sprite
// -------------------------------------------------------------

function draw_player_halo(_player) {
    var _pct = (_player.hp_max > 0) ? (_player.hp / _player.hp_max) : 0;
    var _color = halo_color_for_pct(_pct);
    var _alpha = 0.35;
    if (_pct < SANCT_DANGER_PCT) {
        _alpha = 0.35 * (0.5 + 0.5 * sin(current_time / 100));
    }
    draw_set_color(_color);
    draw_set_alpha(_alpha);
    draw_circle(_player.x, _player.y - 28, 22, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// -------------------------------------------------------------
// Floor clamp — MVP stand-in for solid-collision
// (Real ground/walls come in a later pass.)
// -------------------------------------------------------------

function apply_floor_clamp(_inst) {
    if (_inst.y > FLOOR_Y) {
        _inst.y = FLOOR_Y;
        _inst.vsp = 0;
        _inst.on_ground = true;
    } else if (_inst.y < FLOOR_Y) {
        _inst.on_ground = false;
    }
}
