// =============================================================
// obj_coin_projectile — Step
// =============================================================

x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);
spin += 16;

lifetime--;
if (lifetime <= 0) { instance_destroy(); exit; }
if (x < -32 || x > room_width + 32) { instance_destroy(); exit; }

var _list = ds_list_create();
collision_circle_list(x, y, 10, obj_enemy_parent, false, true, _list, false);
for (var i = 0; i < ds_list_size(_list); i++) {
    var _e = _list[| i];
    if (array_contains(hit_targets, _e)) continue;
    array_push(hit_targets, _e);
    var _dir = (lengthdir_x(1, direction) >= 0) ? 1 : -1;
    with (_e) enemy_take_damage(other.damage, _dir);
    instance_destroy();
    break;
}
ds_list_destroy(_list);
