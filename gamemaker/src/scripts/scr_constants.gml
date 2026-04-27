// =============================================================
// scr_constants.gml
// Global enums and tunables shared across the project
// =============================================================

#macro VIEW_W 640
#macro VIEW_H 360
#macro FLOOR_Y 320
#macro DEBUG_FAST_BOOT false

// Player states (string literals, kept readable for debug)
#macro PSTATE_IDLE      "idle"
#macro PSTATE_WALK      "walk"
#macro PSTATE_JUMP      "jump"
#macro PSTATE_ATTACK    "attacking"
#macro PSTATE_AIR_ATK   "air_attacking"
#macro PSTATE_GRAB      "grabbing"
#macro PSTATE_SPECIAL   "special"
#macro PSTATE_SUMMON    "summoning"
#macro PSTATE_KNEEL     "kneel"

// Enemy states
#macro ESTATE_PATROL  "patrol"
#macro ESTATE_CHASE   "chase"
#macro ESTATE_ATTACK  "attack"
#macro ESTATE_STAGGER "stagger"
#macro ESTATE_FLEE    "fleeing"
#macro ESTATE_PRAY    "praying"
#macro ESTATE_GRABBED "grabbed"
#macro ESTATE_THROWN  "thrown"

// Hitbox teams
#macro TEAM_PLAYER 0
#macro TEAM_ENEMY  1

// Sanctification thresholds
#macro SANCT_BLESSED_PCT 0.7
#macro SANCT_DANGER_PCT  0.3

// Halo colors
function halo_color_for_pct(_pct) {
    if (_pct >= SANCT_BLESSED_PCT) return make_color_rgb(255, 215, 80);
    if (_pct >= SANCT_DANGER_PCT)  return c_white;
    return make_color_rgb(220, 40, 40);
}
