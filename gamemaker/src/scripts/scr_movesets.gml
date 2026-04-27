// =============================================================
// scr_movesets.gml
// Move definitions for all four playable disciples.
// =============================================================
//
// Move struct fields:
//   name, frames, recovery,
//   hitbox_x/y/w/h,
//   damage, knockback, hitstun, hitstop,
//   combo_window, allows_cancel,
//
// Optional fields (read by obj_player_base/Step):
//   multi_hit             bool      — re-hit each multi_hit_interval frames
//   multi_hit_interval    int
//   spawns_projectile     bool      — fires obj_coin_projectile fan/storm
//   projectile_count      int
//   projectile_damage     int
//   projectile_speed      number
//   projectile_spread     number    — degrees of arc
//   projectile_interval   int       — for storm-style stagger (special only)
//   dash_speed            number    — sets owner.hsp during active frames
//   screen_flash          bool      — full-screen white pulse
//   launches              bool      — sets vsp = -6 on hit enemy
// =============================================================

function moveset_peter() {
    return {
        hp_max: 130,
        move_speed: 2.5,
        jump_strength: 8,
        grab_range: 36,
        combo_chain: [
            { name: "Fisherman's Jab",
              frames: 18, recovery: 6,
              hitbox_x: 32, hitbox_y: -20, hitbox_w: 36, hitbox_h: 28,
              damage: 12, knockback: 3, hitstun: 16, hitstop: 3,
              combo_window: 22, allows_cancel: true },
            { name: "Fisherman's Cross",
              frames: 22, recovery: 8,
              hitbox_x: 36, hitbox_y: -20, hitbox_w: 42, hitbox_h: 30,
              damage: 16, knockback: 5, hitstun: 20, hitstop: 4,
              combo_window: 26, allows_cancel: true },
            { name: "The Rock Drop",
              frames: 36, recovery: 14,
              hitbox_x: 30, hitbox_y: -10, hitbox_w: 60, hitbox_h: 50,
              damage: 28, knockback: 10, hitstun: 35, hitstop: 8,
              combo_window: 0, allows_cancel: false }
        ],
        air_attack: { name: "Pillar Drop",
            frames: 28, recovery: 10,
            hitbox_x: 0, hitbox_y: 20, hitbox_w: 50, hitbox_h: 40,
            damage: 22, knockback: 6, hitstun: 25, hitstop: 6,
            combo_window: 0, allows_cancel: false },
        special_move: { name: "Walk on Water",
            frames: 50, recovery: 18,
            hitbox_x: 50, hitbox_y: -20, hitbox_w: 100, hitbox_h: 50,
            damage: 35, knockback: 12, hitstun: 40, hitstop: 10,
            combo_window: 0, allows_cancel: false,
            dash_speed: 8 },
        passive_on_take_damage: function(_self, _amount) {
            with (obj_player_base) {
                if (id != _self.id && point_distance(x, y, _self.x, _self.y) < 80) {
                    invuln_timer = max(invuln_timer, 30);
                }
            }
        },
        passive_on_combo_hit: function(_self, _hit) { },
        passive_on_convert: function(_self, _enemy) { },
        passive_per_step: function(_self) { }
    };
}

function moveset_john() {
    return {
        hp_max: 100,
        move_speed: 3,
        jump_strength: 9,
        grab_range: 30,
        combo_chain: [
            { name: "Staff Thrust",
              frames: 16, recovery: 5,
              hitbox_x: 38, hitbox_y: -22, hitbox_w: 40, hitbox_h: 24,
              damage: 9, knockback: 2, hitstun: 14, hitstop: 2,
              combo_window: 20, allows_cancel: true },
            { name: "Rising Strike",
              frames: 18, recovery: 6,
              hitbox_x: 32, hitbox_y: -28, hitbox_w: 36, hitbox_h: 36,
              damage: 11, knockback: 2, hitstun: 18, hitstop: 3,
              combo_window: 24, allows_cancel: true,
              launches: true },
            { name: "Beloved Sweep",
              frames: 28, recovery: 10,
              hitbox_x: 30, hitbox_y: -20, hitbox_w: 56, hitbox_h: 32,
              damage: 16, knockback: 6, hitstun: 24, hitstop: 5,
              combo_window: 0, allows_cancel: false }
        ],
        air_attack: { name: "Descending Light",
            frames: 22, recovery: 8,
            hitbox_x: 0, hitbox_y: 16, hitbox_w: 44, hitbox_h: 36,
            damage: 14, knockback: 4, hitstun: 18, hitstop: 4,
            combo_window: 0, allows_cancel: false },
        special_move: { name: "Light of the World",
            frames: 40, recovery: 14,
            hitbox_x: 0, hitbox_y: -20, hitbox_w: 9999, hitbox_h: 9999,
            damage: 18, knockback: 0, hitstun: 90, hitstop: 8,
            combo_window: 0, allows_cancel: false,
            screen_flash: true },
        passive_on_take_damage: function(_self, _amount) { },
        passive_on_combo_hit: function(_self, _hit) { },
        passive_on_convert: function(_self, _enemy) {
            sanctification_restore(_self, 4);
        },
        passive_per_step: function(_self) { }
    };
}

function moveset_james() {
    return {
        hp_max: 80,
        move_speed: 4,
        jump_strength: 10,
        grab_range: 28,
        combo_chain: [
            { name: "Lightning Jab L",
              frames: 10, recovery: 3,
              hitbox_x: 28, hitbox_y: -22, hitbox_w: 32, hitbox_h: 24,
              damage: 5, knockback: 1, hitstun: 10, hitstop: 1,
              combo_window: 14, allows_cancel: true },
            { name: "Lightning Jab R",
              frames: 10, recovery: 3,
              hitbox_x: 28, hitbox_y: -22, hitbox_w: 32, hitbox_h: 24,
              damage: 5, knockback: 1, hitstun: 10, hitstop: 1,
              combo_window: 14, allows_cancel: true },
            { name: "Twin Rising",
              frames: 12, recovery: 4,
              hitbox_x: 26, hitbox_y: -28, hitbox_w: 30, hitbox_h: 32,
              damage: 7, knockback: 2, hitstun: 12, hitstop: 2,
              combo_window: 16, allows_cancel: true },
            { name: "Crossing Strike",
              frames: 12, recovery: 4,
              hitbox_x: 32, hitbox_y: -22, hitbox_w: 38, hitbox_h: 28,
              damage: 8, knockback: 2, hitstun: 14, hitstop: 2,
              combo_window: 18, allows_cancel: true },
            { name: "Thunder Clap",
              frames: 22, recovery: 8,
              hitbox_x: 30, hitbox_y: -20, hitbox_w: 50, hitbox_h: 36,
              damage: 14, knockback: 8, hitstun: 28, hitstop: 6,
              combo_window: 0, allows_cancel: false }
        ],
        air_attack: { name: "Sky Spinner",
            frames: 24, recovery: 6,
            hitbox_x: 0, hitbox_y: 0, hitbox_w: 56, hitbox_h: 56,
            damage: 6, knockback: 2, hitstun: 12, hitstop: 2,
            combo_window: 0, allows_cancel: false,
            multi_hit: true, multi_hit_interval: 6 },
        special_move: { name: "Thunder Roll",
            frames: 60, recovery: 18,
            hitbox_x: 0, hitbox_y: -20, hitbox_w: 90, hitbox_h: 70,
            damage: 8, knockback: 4, hitstun: 16, hitstop: 3,
            combo_window: 0, allows_cancel: false,
            multi_hit: true, multi_hit_interval: 5 },
        passive_on_take_damage: function(_self, _amount) { },
        passive_on_combo_hit: function(_self, _hit) {
            if (_hit > 3) sanctification_restore(_self, 1);
            _self.special_meter = min(_self.special_meter_max, _self.special_meter + 4);
        },
        passive_on_convert: function(_self, _enemy) { },
        passive_per_step: function(_self) { }
    };
}

function moveset_matthew() {
    return {
        hp_max: 90,
        move_speed: 2.8,
        jump_strength: 9,
        grab_range: 30,
        combo_chain: [
            { name: "Quill Jab",
              frames: 16, recovery: 5,
              hitbox_x: 34, hitbox_y: -22, hitbox_w: 32, hitbox_h: 26,
              damage: 8, knockback: 2, hitstun: 14, hitstop: 2,
              combo_window: 22, allows_cancel: true },
            { name: "Ledger Sweep",
              frames: 18, recovery: 6,
              hitbox_x: 32, hitbox_y: -20, hitbox_w: 38, hitbox_h: 28,
              damage: 10, knockback: 4, hitstun: 18, hitstop: 3,
              combo_window: 24, allows_cancel: true },
            { name: "Coin Throw",
              frames: 24, recovery: 10,
              hitbox_x: 0, hitbox_y: 0, hitbox_w: 0, hitbox_h: 0,
              damage: 0, knockback: 0, hitstun: 0, hitstop: 4,
              combo_window: 0, allows_cancel: false,
              spawns_projectile: true,
              projectile_count: 1, projectile_damage: 14,
              projectile_speed: 8, projectile_spread: 0 }
        ],
        air_attack: { name: "Scattered Coins",
            frames: 20, recovery: 6,
            hitbox_x: 0, hitbox_y: 0, hitbox_w: 0, hitbox_h: 0,
            damage: 0, knockback: 0, hitstun: 0, hitstop: 3,
            combo_window: 0, allows_cancel: false,
            spawns_projectile: true,
            projectile_count: 3, projectile_damage: 8,
            projectile_speed: 6, projectile_spread: 30 },
        special_move: { name: "Render Unto Caesar",
            frames: 70, recovery: 20,
            hitbox_x: 0, hitbox_y: 0, hitbox_w: 0, hitbox_h: 0,
            damage: 0, knockback: 0, hitstun: 0, hitstop: 6,
            combo_window: 0, allows_cancel: false,
            spawns_projectile: true,
            projectile_count: 12, projectile_damage: 12,
            projectile_speed: 7, projectile_spread: 90,
            projectile_interval: 4 },
        passive_on_take_damage: function(_self, _amount) { },
        passive_on_combo_hit: function(_self, _hit) { },
        passive_on_convert: function(_self, _enemy) {
            sanctification_restore(_self, 10);
            instance_create_layer(_enemy.x, _enemy.y - 16, "Instances", obj_blessing_coin);
        },
        passive_per_step: function(_self) { }
    };
}
