// =============================================================
// obj_player_base — Create
// Parent of every disciple. Children call event_inherited() then
// override stats and movesets via apply_moveset() in scr_movesets.
// =============================================================

// Stats (children overwrite)
hp_max = 100;
hp = hp_max;
move_speed = 3;
jump_strength = 9;

// Physics
hsp = 0;
vsp = 0;
gravity_force = 0.4;
on_ground = false;
facing = 1;

// State machine
state = PSTATE_IDLE;
state_timer = 0;
invuln_timer = 0;
invuln_duration = 30;

// Combo system
combo_chain = [];
combo_index = 0;
combo_window = 0;
combo_input_buffer = false;
current_move = noone;
move_timer = 0;

// Air attack
air_attack = noone;
has_air_attacked = false;

// Grab
grab_range = 30;
grab_target = noone;
grab_timer = 0;
grab_state = "none";

// Special move
special_move = noone;
special_meter = 0;
special_meter_max = 100;

// Passive hooks (children may override)
passive_on_convert      = function(_self, _enemy) { };
passive_on_combo_hit    = function(_self, _hit_number) { };
passive_on_take_damage  = function(_self, _amount) { };
passive_per_step        = function(_self) { };

// Summon Jesus
summon_charges = 1;
summon_cooldown = 0;

// Stats tracking
converted_count = 0;
defeated_count = 0;
combo_high = 0;
