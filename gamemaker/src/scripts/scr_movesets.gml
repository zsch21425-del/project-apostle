// =============================================================
// scr_movesets.gml
// Move definitions for each playable disciple.
// MVP fills Peter only. John / James / Matthew tables are stubs
// that return an empty combo so the parent state machine still
// runs without crashing if you accidentally pick them.
// =============================================================
//
// Move struct fields (every move needs all of these):
//   name           string  debug label
//   frames         int     total frames the move lasts
//   recovery       int     last N frames are recovery (no hitbox)
//   hitbox_x/y     int     offset from player center (x is mirrored by facing)
//   hitbox_w/h     int     hitbox size
//   damage         int
//   knockback      int     horizontal force on the hit enemy
//   hitstun        int     frames the enemy is stunned
//   hitstop        int     freeze frames on hit (game feel)
//   combo_window   int     frames to chain next hit (0 = ends combo)
//   allows_cancel  bool    can next attack input cancel this move
// =============================================================

function moveset_peter() {
    return {
        hp_max: 130,
        move_speed: 2.5,
        jump_strength: 8,
        grab_range: 36,
        combo_chain: [
            {
                name: "Fisherman's Jab",
                frames: 18, recovery: 6,
                hitbox_x: 32, hitbox_y: -20,
                hitbox_w: 36, hitbox_h: 28,
                damage: 12, knockback: 3, hitstun: 16, hitstop: 3,
                combo_window: 22, allows_cancel: true
            },
            {
                name: "Fisherman's Cross",
                frames: 22, recovery: 8,
                hitbox_x: 36, hitbox_y: -20,
                hitbox_w: 42, hitbox_h: 30,
                damage: 16, knockback: 5, hitstun: 20, hitstop: 4,
                combo_window: 26, allows_cancel: true
            },
            {
                name: "The Rock Drop",
                frames: 36, recovery: 14,
                hitbox_x: 30, hitbox_y: -10,
                hitbox_w: 60, hitbox_h: 50,
                damage: 28, knockback: 10, hitstun: 35, hitstop: 8,
                combo_window: 0, allows_cancel: false
            }
        ],
        air_attack: {
            name: "Pillar Drop",
            frames: 28, recovery: 10,
            hitbox_x: 0, hitbox_y: 20,
            hitbox_w: 50, hitbox_h: 40,
            damage: 22, knockback: 6, hitstun: 25, hitstop: 6,
            combo_window: 0, allows_cancel: false
        },
        special_move: {
            name: "Walk on Water",
            frames: 50, recovery: 18,
            hitbox_x: 50, hitbox_y: -20,
            hitbox_w: 100, hitbox_h: 50,
            damage: 35, knockback: 12, hitstun: 40, hitstop: 10,
            combo_window: 0, allows_cancel: false
        },
        passive_on_take_damage: function(_self, _amount) {
            with (obj_player_base) {
                if (id != _self.id && point_distance(x, y, _self.x, _self.y) < 80) {
                    invuln_timer = max(invuln_timer, 30);
                }
            }
        }
    };
}

// Stub generators — these return a structurally valid moveset so
// selecting John/James/Matthew on the select screen doesn't crash.
// Each will be filled in a follow-up pass.
function moveset_john()    { return _stub_moveset("John");    }
function moveset_james()   { return _stub_moveset("James");   }
function moveset_matthew() { return _stub_moveset("Matthew"); }

function _stub_moveset(_name) {
    var _basic = {
        name: _name + " Jab (stub)",
        frames: 18, recovery: 6,
        hitbox_x: 32, hitbox_y: -20,
        hitbox_w: 36, hitbox_h: 28,
        damage: 8, knockback: 2, hitstun: 14, hitstop: 2,
        combo_window: 0, allows_cancel: false
    };
    return {
        hp_max: 100,
        move_speed: 3,
        jump_strength: 9,
        grab_range: 30,
        combo_chain: [ _basic ],
        air_attack: _basic,
        special_move: _basic,
        passive_on_take_damage: function(_self, _amount) { /* no-op */ }
    };
}
