// =============================================================
// scr_helpers.gml
// Sanctification (player HP), halo UI, hitbox spawning,
// projectile + screen-flash helpers, floor clamp.
// =============================================================

// -------------------------------------------------------------
// Sanctification: player HP / faith meter
//   70-100% = gold halo (blessed)
//   30-70%  = white halo (steady)
//   0-30%   = pulsing red (warning)
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
    _hb.launches    = variable_struct_exists(_move, "launches") && _move.launches;
    return _hb;
}

// Short pulse hitbox for multi-hit moves — each pulse re-hits any
// enemies in range, so multi-hit attacks land repeatedly.
function spawn_player_hit_pulse(_owner, _move) {
    var _hb = spawn_player_hitbox(_owner, _move);
    _hb.lifetime = 2;
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
// Coin fan — Matthew's projectile spawner (combo finisher,
// air attack, and the "Render Unto Caesar" storm).
// -------------------------------------------------------------

function spawn_coin_fan(_owner, _move, _count) {
    var _spread = variable_struct_exists(_move, "projectile_spread") ? _move.projectile_spread : 0;
    var _speed  = variable_struct_exists(_move, "projectile_speed")  ? _move.projectile_speed  : 8;
    var _dmg    = variable_struct_exists(_move, "projectile_damage") ? _move.projectile_damage : 10;
    var _base_dir = (_owner.facing > 0) ? 0 : 180;

    for (var i = 0; i < _count; i++) {
        var _offset = (_count > 1) ? (i / (_count - 1) - 0.5) * _spread : 0;
        var _proj = instance_create_layer(
            _owner.x + (_owner.facing * 16),
            _owner.y - 18,
            "Instances",
            obj_coin_projectile
        );
        _proj.direction = _base_dir + _offset;
        _proj.speed     = _speed;
        _proj.damage    = _dmg;
        _proj.owner     = _owner.id;
    }
}

// -------------------------------------------------------------
// HUD: halo-shaped sanctification meter (drawn in obj_controller)
// -------------------------------------------------------------

function draw_sanctification_meter(_x, _y, _hp, _hp_max) {
    var _pct = (_hp_max > 0) ? (_hp / _hp_max) : 0;
    var _radius = 28;
    var _meter_color = halo_color_for_pct(_pct);

    draw_set_color(make_color_rgb(40, 30, 20));
    draw_circle(_x + _radius, _y + _radius, _radius, false);

    draw_set_color(_meter_color);
    var _segments = 32;
    var _fill = floor(_segments * _pct);
    for (var i = 0; i < _fill; i++) {
        var _angle = (i / _segments) * 360 - 90;
        var _px = _x + _radius + lengthdir_x(_radius - 4, _angle);
        var _py = _y + _radius + lengthdir_y(_radius - 4, _angle);
        draw_circle(_px, _py, 3, false);
    }

    if (_pct < SANCT_DANGER_PCT) {
        var _pulse = (sin(current_time / 150) + 1) / 2;
        draw_set_color(make_color_rgb(255, 80, 80));
        draw_set_alpha(0.5 + _pulse * 0.5);
        draw_text(_x + _radius * 2 + 12, _y + _radius - 4, "PRAY!");
        draw_set_alpha(1);
    }

    draw_set_color(c_white);
}

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

// -------------------------------------------------------------
// Per-player input — supports up to 4 local players.
// player_index 0 is keyboard + gamepad slot 0; 1-3 are gamepads only.
// -------------------------------------------------------------

function input_left(_pi)    {
    if (_pi == 0 && keyboard_check(vk_left)) return true;
    return gamepad_button_check(_pi, gp_padl);
}
function input_right(_pi)   {
    if (_pi == 0 && keyboard_check(vk_right)) return true;
    return gamepad_button_check(_pi, gp_padr);
}
function input_jump(_pi)    {
    if (_pi == 0 && keyboard_check_pressed(vk_space)) return true;
    return gamepad_button_check_pressed(_pi, gp_face1);
}
function input_attack(_pi)  {
    if (_pi == 0 && keyboard_check_pressed(ord("X"))) return true;
    return gamepad_button_check_pressed(_pi, gp_face3);
}
function input_grab(_pi)    {
    if (_pi == 0 && keyboard_check_pressed(ord("Z"))) return true;
    return gamepad_button_check_pressed(_pi, gp_face2);
}
function input_special(_pi) {
    if (_pi == 0 && keyboard_check_pressed(ord("V"))) return true;
    return gamepad_button_check_pressed(_pi, gp_face4);
}
function input_summon(_pi)  {
    if (_pi == 0 && keyboard_check_pressed(ord("C"))) return true;
    return gamepad_button_check_pressed(_pi, gp_shoulderr);
}
function input_pause(_pi)   {
    if (_pi == 0 && keyboard_check_pressed(vk_escape)) return true;
    return gamepad_button_check_pressed(_pi, gp_start);
}
