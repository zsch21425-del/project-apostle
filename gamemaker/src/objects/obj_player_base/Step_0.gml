// =============================================================
// obj_player_base — Step
// Reads input, ticks the state machine, spawns hitboxes via the
// data-driven move table, and applies physics with a floor clamp.
// =============================================================

// --- Input -------------------------------------------------------
var key_left    = keyboard_check(vk_left)             || gamepad_button_check(0, gp_padl);
var key_right   = keyboard_check(vk_right)            || gamepad_button_check(0, gp_padr);
var key_jump    = keyboard_check_pressed(vk_space)    || gamepad_button_check_pressed(0, gp_face1);
var key_attack  = keyboard_check_pressed(ord("X"))    || gamepad_button_check_pressed(0, gp_face3);
var key_grab    = keyboard_check_pressed(ord("Z"))    || gamepad_button_check_pressed(0, gp_face2);
var key_special = keyboard_check_pressed(ord("V"))    || gamepad_button_check_pressed(0, gp_face4);
var key_summon  = keyboard_check_pressed(ord("C"))    || gamepad_button_check_pressed(0, gp_shoulderr);

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

// Advance the combo chain when buffered input + window are open
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
            instance_destroy();
        }
    }
    sanctification_restore(self, 25);
    state = PSTATE_IDLE;
}

// --- Move timer (resolves attack frames) -------------------------
if (state == PSTATE_ATTACK || state == PSTATE_AIR_ATK || state == PSTATE_SPECIAL) {
    move_timer--;
    if (combo_window > 0) combo_window--;
    if (move_timer <= 0 && !combo_input_buffer) {
        state = on_ground ? PSTATE_IDLE : PSTATE_JUMP;
        combo_index = 0;
    }
}

// --- Decay timers ------------------------------------------------
if (invuln_timer > 0)   invuln_timer--;
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
    with (_prayer) instance_destroy();
}

// --- Defeat -----------------------------------------------------
if (hp <= 0 && state != PSTATE_KNEEL) {
    state = PSTATE_KNEEL;
    hsp = 0;
}

// --- Per-step passive hook --------------------------------------
passive_per_step(self);

// =============================================================
// Local helper — begin executing a move definition
// =============================================================
function _start_move(_move) {
    current_move = _move;
    move_timer = _move.frames;
    combo_window = _move.combo_window;
    spawn_player_hitbox(self, _move);
}
