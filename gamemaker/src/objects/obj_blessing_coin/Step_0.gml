// =============================================================
// obj_blessing_coin — Step
// Falls, settles on the floor, bobs gently. Picked up on touch.
// =============================================================

vsp += gravity_force;
y += vsp;
apply_floor_clamp(self);
bob_phase += 4;

lifetime--;
if (lifetime <= 0) { instance_destroy(); exit; }

var _p = collision_circle(x, y, 16, obj_player_base, false, true);
if (_p != noone) {
    sanctification_restore(_p, value);
    instance_destroy();
}
