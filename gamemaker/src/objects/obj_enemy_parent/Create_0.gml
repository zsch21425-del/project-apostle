// =============================================================
// obj_enemy_parent — Create
// Hidden HP. The player reads enemy state from animation cues
// (winded at 66%, staggering at 33%) instead of a meter.
// =============================================================

// Stats (children override)
hp_max = 30;
hp = hp_max;
damage = 8;
move_speed = 2;
attack_range = 50;
sight_range = 250;
pray_chance = 0.6;

// Animation cue thresholds
threshold_winded  = 0.66;
threshold_stagger = 0.33;

// State
state = ESTATE_PATROL;
facing = -1;
hsp = 0;
vsp = 0;
on_ground = false;
gravity_force = 0.4;

// Behavior timers
attack_cooldown   = 0;
attack_telegraph  = 0;
stagger_timer     = 0;
state_timer       = 0;
patrol_dir        = choose(-1, 1);
patrol_timer      = 60;

// Prayer state
prayer_safe_timer = 0;
prayer_max_timer  = 480;

// Visual cue flags
is_winded     = false;
is_staggering = false;
hit_flash     = 0;

// Body color (children override)
body_color = make_color_rgb(120, 90, 70);
char_name  = "Enemy";

// Buff modifiers (Pharisee aura raises nearby ally damage)
damage_buff = 1.0;

// Block — Roman Guard sets this; reduces incoming damage when facing
// the attacker. block_cooldown gates how often a block triggers.
can_block      = false;
block_cooldown = 0;

// Phase tracking for multi-phase bosses
phase = 1;

// =============================================================
// Hooks — children override as needed
// =============================================================

// Returns true if this override fully handled the AI tick
// (skips parent's default state machine for that frame).
ai_step_override = function() { return false; };

// Modifier on incoming damage. Default: pass through.
on_damage_received = function(_amount, _dir) { return _amount; };

// Called once when this enemy is about to be removed by conversion
// or summon Jesus. Used for blessing-coin drops, etc.
on_pre_destroy = function() { };

// Called every step regardless of state (Pharisee aura, etc.)
ambient_per_step = function() { };

// =============================================================
// Methods — defined in Create so they outlive Step
// =============================================================

trigger_break_point = function() {
    if (random(1) < pray_chance) {
        state = ESTATE_PRAY;
        prayer_safe_timer = 0;
        hsp = 0;
    } else {
        state = ESTATE_FLEE;
        state_timer = 0;
    }
};

enemy_take_damage = function(_amount, _knockback_dir) {
    // Praying = struck = penalty + flee
    if (state == ESTATE_PRAY) {
        with (obj_player_base) sanctification_take_damage(self, 25);
        state = ESTATE_FLEE;
        state_timer = 0;
        return;
    }

    // Block check (Roman)
    if (can_block && block_cooldown <= 0) {
        var _attacker_on_facing_side = (sign(_knockback_dir) == sign(-facing));
        if (_attacker_on_facing_side && random(1) < 0.45) {
            _amount *= 0.4;
            block_cooldown = 45;
        }
    }

    // Per-archetype damage modifier hook (e.g. armoured units)
    _amount = on_damage_received(_amount, _knockback_dir);

    hp -= _amount;
    hit_flash = 1;
    hsp = _knockback_dir * 4;

    if (_amount >= 15 || hp / hp_max < threshold_stagger) {
        state = ESTATE_STAGGER;
        stagger_timer = 20;
    }

    if (hp <= 0) {
        hp = 0;
        if (state != ESTATE_STAGGER) trigger_break_point();
    }
};
