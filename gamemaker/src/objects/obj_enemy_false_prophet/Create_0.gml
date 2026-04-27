// =============================================================
// obj_enemy_false_prophet — Wilderness mid-boss, two-phase
// Phase 1: stays at range, throws "temptation" projectiles
//          (reuses obj_coin_projectile recolored as a curse).
// Phase 2: switches to melee chase + faster swings.
// =============================================================

event_inherited();

char_name   = "False Prophet";
body_color  = make_color_rgb(100, 60, 110);

hp_max         = 140;
hp             = hp_max;
damage         = 12;
move_speed     = 2.2;
attack_range   = 64;
sight_range    = 360;
pray_chance    = 0.30;

phase            = 1;
projectile_cd    = 90;

ai_step_override = function() {
    if (phase == 1 && hp / hp_max <= 0.55) {
        phase = 2;
        move_speed = 3.2;
        damage = 16;
        body_color = make_color_rgb(60, 30, 80);
    }

    if (phase == 1) {
        var _t = instance_nearest(x, y, obj_player_base);
        if (_t == noone) return false;

        // Hover at range
        var _dist = point_distance(x, y, _t.x, _t.y);
        var _ideal = 220;
        if (_dist < _ideal - 30) {
            hsp = (x < _t.x) ? -move_speed : move_speed;
            facing = (x < _t.x) ? -1 : 1;
        } else if (_dist > _ideal + 30) {
            hsp = (x < _t.x) ? move_speed : -move_speed;
            facing = (x < _t.x) ? 1 : -1;
        } else {
            hsp = 0;
            facing = (x < _t.x) ? 1 : -1;
        }

        // Throw a projectile every 90 frames
        if (projectile_cd > 0) {
            projectile_cd--;
        } else {
            var _proj = instance_create_layer(
                x + (facing * 16), y - 24,
                "Instances", obj_coin_projectile
            );
            _proj.direction = (facing > 0) ? 0 : 180;
            _proj.speed     = 5;
            _proj.damage    = 0;  // hit-the-player path: we use a custom hitbox instead
            _proj.owner     = id;
            // The coin object hits enemies, not players — replace with an
            // enemy-team hitbox spawn for the "temptation" projectile.
            // For now spawn a transient enemy-team hitbox along the path.
            spawn_enemy_hitbox(self, 28, -22, 60, 28, damage);
            projectile_cd = 90;
        }
        return true; // skip the parent's CHASE/ATTACK while in phase 1
    }

    return false; // phase 2 uses default chase + attack
};
