// =============================================================
// obj_hitbox — Step
// Detect collisions with the opposite team, deliver damage,
// expire after `lifetime` frames.
// =============================================================

lifetime--;

if (team == TEAM_PLAYER) {
    var _list = ds_list_create();
    collision_rectangle_list(
        x - box_w / 2, y - box_h / 2,
        x + box_w / 2, y + box_h / 2,
        obj_enemy_parent, false, true, _list, false
    );
    for (var i = 0; i < ds_list_size(_list); i++) {
        var _enemy = _list[| i];
        if (array_contains(hit_targets, _enemy)) continue;
        array_push(hit_targets, _enemy);

        with (_enemy) enemy_take_damage(other.damage, other.facing);

        if (instance_exists(obj_controller)) {
            obj_controller.hitstop = max(obj_controller.hitstop, hitstop);
        }
        if (instance_exists(owner)) {
            owner.special_meter = min(
                owner.special_meter_max,
                owner.special_meter + 8
            );
        }
    }
    ds_list_destroy(_list);
} else {
    // Enemy hitbox — damages players
    var _list = ds_list_create();
    collision_rectangle_list(
        x - box_w / 2, y - box_h / 2,
        x + box_w / 2, y + box_h / 2,
        obj_player_base, false, true, _list, false
    );
    for (var i = 0; i < ds_list_size(_list); i++) {
        var _p = _list[| i];
        if (array_contains(hit_targets, _p)) continue;
        array_push(hit_targets, _p);
        sanctification_take_damage(_p, damage);
    }
    ds_list_destroy(_list);
}

if (lifetime <= 0) instance_destroy();
