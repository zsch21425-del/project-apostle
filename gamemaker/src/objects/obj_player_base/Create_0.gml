// =============================================================
// obj_player_base — Create
// Parent of every disciple. Children call event_inherited() then
// override stats and movesets via the moveset_*() functions.
// =============================================================

// Per-instance player slot (0..3). Children may override.
player_index = 0;

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
move_active_frames = 0;        // counts up while a move is in its hit-active window
multi_hit_cd = 0;              // ticks down each frame for multi-hit pulses
projectile_cd = 0;             // for storm-style staggered fans

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

// Passive hooks (children may override all four)
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

// Visual placeholders (children override these in their Create)
char_name  = "Disciple";
body_color = c_white;
weapon_kind = "none";          // "net", "staff", "twin_staff", "ledger"
