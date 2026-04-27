// =============================================================
// obj_player_base — Step
// Reads input for this player_index, ticks the state machine,
// dispatches the data-driven move table (multi-hit, projectile,
// dash, screen-flash, launcher), applies physics + floor clamp.
// =============================================================

// Pause check
if (instance_exists(obj_pause_menu) && obj_pause_menu.paused) exit;

// Hit-stop freeze
if (instance_exists(obj_controller) && obj_controller.hitstop > 0) exit;

// --- Input -------------------------------------------------------
var key_left    = input_left(player_index);
var key_right   = input_right(player_index);
var key_jump    = input_jump(player_index);
var key_attack  = input_attack(player_index);
var key_grab    = input_grab(player_index);
var key_special = input_special(player_index);
var key_summon  = input_summon(player_index);

// Lock out input while kneeling
if (state == PSTATE_KNEEL) {
    hsp = 0;
    apply_floor_clamp(self);
    exit;
}

// --- Movement ----------------------------------------------------
if (state == PSTATE_IDLE || state == PSTATE_WALK || state == PSTATE_JUMP) {
    hsp = (key_right - key_left) * move_speed;
    if (key_right) facing = 1;
    if (key_left)  facing = -1;
}

// --- Jump --------------------------------------------------------
if (key_jump && on_ground && (state == PSTATE_IDLE || state == PSTATE_WALK)) {
    vsp = -jump_strength;
    on_ground = false;
    has_air_attacked = false;
}

// --- Combo attack ------------------------------------------------
if (key_attack) {
    if ((state == PSTATE_IDLE || state == PSTATE_WALK) && array_length(combo_chain) > 0) {
        combo_index = 0;
        _start_move(combo_chain[0]);
        state = PSTATE_ATTACK;
    } else if (state == PSTATE_ATTACK && combo_window > 0 && current_move.allows_cancel) {
        combo_input_buffer = true;
    } else if (state == PSTATE_JUMP && !has_air_attacked && air_attack != noone) {
        _start_move(air_attack);
        state = PSTATE_AIR_ATK;
        has_air_attacked = true;
    }
}

// Advance combo chain when current move ends and input was buffered
if (state == PSTATE_ATTACK && move_timer <= 0 && combo_input_buffer) {
    combo_index++;
    if (combo_index >= array_length(combo_chain)) combo_index = 0;
    _start_move(combo_chain[combo_index]);
    combo_input_buffer = false;
    if (combo_index + 1 > combo_high) combo_high = combo_index + 1;
    passive_on_combo_hit(self, combo_index + 1);
}

// --- Grab --------------------------------------------------------
if (key_grab && (state == PSTATE_IDLE || state == PSTATE_WALK)) {
    var _target = collision_rectangle(
        x + (facing * 5), y - 24,
        x + (facing * grab_range), y + 24,
        obj_enemy_parent, false, true
    );
    if (_target != noone && _target.state != ESTATE_PRAY) {
        grab_target = _target;
        grab_state = "holding";
        grab_timer = 60;
        state = PSTATE_GRAB;
    }
}

if (state == PSTATE_GRAB && grab_target != noone && instance_exists(grab_target)) {
    grab_target.x = x + (facing * 24);
    grab_target.y = y;
    grab_target.hsp = 0;
    grab_target.vsp = 0;
    grab_target.state = ESTATE_GRABBED;

    if (key_attack) {
        with (grab_target) {
            enemy_take_damage(15, other.facing);
            vsp = -6;
            hsp = other.facing * 8;
            state = ESTATE_THROWN;
        }
        grab_target = noone;
        grab_state = "none";
        state = PSTATE_IDLE;
    }

    grab_timer--;
    if (grab_timer <= 0) {
        grab_target = noone;
        grab_state = "none";
        state = PSTATE_IDLE;
    }
}

// --- Special move ------------------------------------------------
if (key_special && special_meter >= special_meter_max && special_move != noone) {
    _start_move(special_move);
    state = PSTATE_SPECIAL;
    special_meter = 0;

    // Screen-flash specials trigger a controller flash
    if (variable_struct_exists(special_move, "screen_flash") && special_move.screen_flash) {
        if (instance_exists(obj_controller)) {
            obj_controller.flash_alpha = 1.0;
            obj_controller.flash_color = c_white;
        }
    }
}

// --- Summon Jesus ------------------------------------------------
if (key_summon && summon_charges > 0 && summon_cooldown <= 0) {
    state = PSTATE_SUMMON;
    summon_charges--;
    summon_cooldown = 60;

    with (obj_enemy_parent) {
        if (state == ESTATE_PRAY) {
            other.converted_count++;
            sanctification_restore(other, 20);
            on_pre_destroy();
            instance_destroy();
        }
    }
    sanctification_restore(self, 25);
    instance_create_layer(x, y - 60, "Instances", obj_jesus_mentor);
    state = PSTATE_IDLE;
}

// --- Move dispatch (per-frame work for the active move) ---------
if (state == PSTATE_ATTACK || state == PSTATE_AIR_ATK || state == PSTATE_SPECIAL) {
    move_timer--;
    move_active_frames++;
    if (combo_window > 0) combo_window--;

    var _is_active = (move_timer > current_move.recovery);

    // Dash specials drag the player forward during active frames
    if (_is_active && variable_struct_exists(current_move, "dash_speed")) {
        hsp = facing * current_move.dash_speed;
    }

    // Multi-hit moves spawn extra hit pulses on the interval
    if (_is_active && variable_struct_exists(current_move, "multi_hit") && current_move.multi_hit) {
        if (multi_hit_cd <= 0) {
            spawn_player_hit_pulse(self, current_move);
            multi_hit_cd = current_move.multi_hit_interval;
        } else {
            multi_hit_cd--;
        }
    }

    // Projectile-storm specials spawn coins on a stagger interval
    if (_is_active
        && variable_struct_exists(current_move, "spawns_projectile")
        && current_move.spawns_projectile
        && variable_struct_exists(current_move, "projectile_interval")) {
        if (projectile_cd <= 0) {
            spawn_coin_fan(self, current_move, 1);
            projectile_cd = current_move.projectile_interval;
        } else {
            projectile_cd--;
        }
    }

    if (move_timer <= 0 && !combo_input_buffer) {
        state = on_ground ? PSTATE_IDLE : PSTATE_JUMP;
        combo_index = 0;
    }
}

// --- Decay timers ------------------------------------------------
if (invuln_timer > 0)    invuln_timer--;
if (summon_cooldown > 0) summon_cooldown--;

// --- Physics + floor clamp --------------------------------------
vsp += gravity_force;
if (vsp > 12) vsp = 12;
x += hsp;
y += vsp;
apply_floor_clamp(self);

// --- Idle/walk/jump animation state -----------------------------
if (state == PSTATE_IDLE || state == PSTATE_WALK || state == PSTATE_JUMP) {
    if (!on_ground)        state = PSTATE_JUMP;
    else if (hsp != 0)     state = PSTATE_WALK;
    else                   state = PSTATE_IDLE;
}

// --- Praying-enemy walkover (CONVERT) ---------------------------
var _prayer = instance_place(x, y, obj_enemy_parent);
if (_prayer != noone && _prayer.state == ESTATE_PRAY) {
    converted_count++;
    sanctification_restore(self, 15);
    passive_on_convert(self, _prayer);
    with (_prayer) {
        on_pre_destroy();
        instance_destroy();
    }
}

// --- Defeat -----------------------------------------------------
if (hp <= 0 && state != PSTATE_KNEEL) {
    state = PSTATE_KNEEL;
    hsp = 0;
}

passive_per_step(self);

// =============================================================
// Local helper — begin executing a move definition.
// Spawns the appropriate hitbox / projectile fan based on flags.
// =============================================================
function _start_move(_move) {
    current_move = _move;
    move_timer = _move.frames;
    combo_window = _move.combo_window;
    move_active_frames = 0;
    multi_hit_cd = 0;
    projectile_cd = 0;

    // Projectile burst (no continuous storm) — fire fan immediately
    if (variable_struct_exists(_move, "spawns_projectile") && _move.spawns_projectile
        && !variable_struct_exists(_move, "projectile_interval")) {
        var _count = variable_struct_exists(_move, "projectile_count") ? _move.projectile_count : 1;
        spawn_coin_fan(self, _move, _count);
    }
    // Multi-hit moves spawn their first pulse immediately
    else if (variable_struct_exists(_move, "multi_hit") && _move.multi_hit) {
        spawn_player_hit_pulse(self, _move);
    }
    // Standard melee move
    else if (_move.hitbox_w > 0 && _move.hitbox_h > 0) {
        spawn_player_hitbox(self, _move);
    }
}
