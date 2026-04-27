// =============================================================
// obj_enemy_temple_guard — Long spear, hardened
// Wider attack hitbox + longer range than a Roman Guard.
// Slightly armoured (15% damage reduction).
// =============================================================

event_inherited();

char_name   = "Temple Guard";
body_color  = make_color_rgb(80, 80, 100);

hp_max         = 80;
hp             = hp_max;
damage         = 12;
move_speed     = 2;
attack_range   = 80;     // longer than default
sight_range    = 280;
pray_chance    = 0.35;

ai_step_override = function() {
    // Custom telegraph spawns a wider hitbox at longer range
    if (state == ESTATE_ATTACK) {
        hsp = 0;
        if (attack_telegraph > 0) {
            attack_telegraph--;
            if (attack_telegraph == 12) {
                spawn_enemy_hitbox(self, 50, -16, 60, 28, damage * damage_buff);
            }
            if (attack_telegraph == 0) {
                attack_cooldown = 70;
                state = ESTATE_CHASE;
            }
        }
        return true;
    }
    return false;
};

on_damage_received = function(_amount, _dir) {
    return _amount * 0.85;
};
