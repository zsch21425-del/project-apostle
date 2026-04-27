// =============================================================
// obj_enemy_parent — Step
// AI states + hidden HP + prayer transition. Animation-cue flags
// (is_winded / is_staggering) are read by the Draw event so the
// player can read enemy condition without a meter.
// =============================================================

var _target = instance_nearest(x, y, obj_player_base);

// --- PATROL ------------------------------------------------------
if (state == ESTATE_PATROL) {
    hsp = patrol_dir * (move_speed * 0.5);
    facing = patrol_dir;

    patrol_timer--;
    if (patrol_timer <= 0) {
        patrol_dir *= -1;
        patrol_timer = 60 + irandom(60);
    }

    if (_target != noone && point_distance(x, y, _target.x, _target.y) < sight_range) {
        state = ESTATE_CHASE;
    }
}

// --- CHASE -------------------------------------------------------
if (state == ESTATE_CHASE && _target != noone) {
    if (_target.x < x) { hsp = -move_speed; facing = -1; }
    else                { hsp =  move_speed; facing =  1; }

    if (is_winded) hsp *= 0.7;

    if (point_distance(x, y, _target.x, _target.y) < attack_range && attack_cooldown <= 0) {
        state = ESTATE_ATTACK;
        attack_telegraph = 20;
        hsp = 0;
    }
}

// --- ATTACK ------------------------------------------------------
if (state == ESTATE_ATTACK) {
    hsp = 0;
    if (attack_telegraph > 0) {
        attack_telegraph--;
        if (attack_telegraph == 10) {
            spawn_enemy_hitbox(self, 36, -16, 36, 28, damage);
        }
        if (attack_telegraph == 0) {
            attack_cooldown = 60;
            state = ESTATE_CHASE;
        }
    }
}

// --- STAGGER -----------------------------------------------------
if (state == ESTATE_STAGGER) {
    hsp *= 0.85;
    stagger_timer--;
    if (stagger_timer <= 0) {
        if (hp <= 0) trigger_break_point();
        else state = ESTATE_CHASE;
    }
}

// --- FLEEING -----------------------------------------------------
if (state == ESTATE_FLEE) {
    if (_target != noone) {
        if (_target.x < x) { hsp =  move_speed * 1.5; facing =  1; }
        else                { hsp = -move_speed * 1.5; facing = -1; }
    }
    state_timer++;
    if (state_timer > 180 || x < -64 || x > room_width + 64) {
        instance_destroy();
    }
}

// --- PRAYING -----------------------------------------------------
if (state == ESTATE_PRAY) {
    hsp = 0;
    prayer_safe_timer++;
    if (prayer_safe_timer >= prayer_max_timer) {
        state = ESTATE_FLEE;
        state_timer = 0;
        hp = hp_max * 0.3;
    }
}

// --- THROWN ------------------------------------------------------
if (state == ESTATE_THROWN) {
    state_timer++;
    if (on_ground && state_timer > 12) {
        state = (hp > 0) ? ESTATE_CHASE : ESTATE_STAGGER;
        state_timer = 0;
    }
}

// --- Animation cue flags (the "hidden HP bar") -------------------
var _hp_pct = (hp_max > 0) ? (hp / hp_max) : 0;
is_winded     = (_hp_pct < threshold_winded && _hp_pct >= threshold_stagger);
is_staggering = (_hp_pct < threshold_stagger && _hp_pct > 0);

// --- Physics + floor clamp --------------------------------------
vsp += gravity_force;
if (vsp > 12) vsp = 12;
x += hsp;
y += vsp;
apply_floor_clamp(self);

// --- Decay -------------------------------------------------------
if (hit_flash > 0)        hit_flash -= 0.1;
if (attack_cooldown > 0)  attack_cooldown--;
