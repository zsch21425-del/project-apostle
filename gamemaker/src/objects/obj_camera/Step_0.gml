// =============================================================
// obj_camera — Step
// Follows the active player. Classic beat-em-up rule: never
// scroll backward. Locks during waves.
// =============================================================

var _target = instance_nearest(x + view_w / 2, y + view_h / 2, obj_player_base);
if (_target == noone) exit;

var _target_x = _target.x - view_w / 2;
var _target_y = _target.y - view_h / 2 - 20;

// Never scroll backward
if (_target_x < x) _target_x = x;

// Clamp to room bounds
_target_x = clamp(_target_x, 0, max(0, room_width  - view_w));
_target_y = clamp(_target_y, 0, max(0, room_height - view_h));

// Wave lock
if (locked) _target_x = min(_target_x, locked_x);

// Smooth lerp
x += (_target_x - x) * follow_smooth;
y += (_target_y - y) * follow_smooth;

// Apply (with shake)
var _sx = 0, _sy = 0;
if (shake_amount > 0.1) {
    _sx = random_range(-shake_amount, shake_amount);
    _sy = random_range(-shake_amount, shake_amount);
    shake_amount -= shake_decay;
} else {
    shake_amount = 0;
}
camera_set_view_pos(view_camera[0], x + _sx, y + _sy);
