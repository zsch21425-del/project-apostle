// =============================================================
// obj_hitbox — Create
// Generic damage payload spawned by player or enemy attacks.
// `team` decides who it can hurt.
// =============================================================

team       = TEAM_PLAYER;   // overwritten by spawner
owner      = noone;
facing     = 1;
damage     = 0;
knockback  = 0;
hitstun    = 0;
hitstop    = 0;
lifetime   = 8;
box_w      = 36;
box_h      = 28;
hit_targets = [];
