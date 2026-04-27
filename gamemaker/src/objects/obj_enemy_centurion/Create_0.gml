// =============================================================
// obj_enemy_centurion — Mini-boss
// Long telegraph charge attack: when the player is within
// charge_range and cooldown is up, telegraphs for 30 frames then
// dashes forward 60 frames at high speed dealing damage on contact.
// =============================================================

event_inherited();

char_name   = "Centurion";
body_color  = make_color_rgb(180, 30, 50);

hp_max        = 120;
hp            = hp_max;
damage        = 14;
move_speed    = 2.2;
attack_range  = 60;
sight_range   = 320;
pray_chance   = 0.60;

can_block     = true;

charge_state    = "none";   // "none" | "telegraph" | "charging" | "recover"
charge_timer    = 0;
charge_cooldown = 0;
charge_range    = 220;

ai_step_override = function() {
    var _t = instance_nearest(x, y, obj_player_base);
    if (_t == noone) return false;

    if (charge_state == "telegraph") {
        hsp = 0;
        charge_timer--;
        if (charge_timer <= 0) {
            charge_state = "charging";
            charge_timer = 60;
        }
        return true;
    }

    if (charge_state == "charging") {
        hsp = facing * 7;
        charge_timer--;
        // Spawn a sustained hit pulse during the charge
        if ((charge_timer mod 8) == 0) {
            spawn_enemy_hitbox(self, 24, -16, 36, 32, damage * 0.9);
        }
        if (charge_timer <= 0 || x < 32 || x > room_width - 32) {
            charge_state = "recover";
            charge_timer = 30;
        }
        return true;
    }

    if (charge_state == "recover") {
        hsp *= 0.7;
        charge_timer--;
        if (charge_timer <= 0) {
            charge_state = "none";
            charge_cooldown = 120;
        }
        return true;
    }

    if (charge_cooldown > 0) {
        charge_cooldown--;
    } else if (point_distance(x, y, _t.x, _t.y) < charge_range
            && abs(_t.y - y) < 40
            && state != ESTATE_PRAY
            && state != ESTATE_FLEE
            && state != ESTATE_STAGGER) {
        // Begin telegraph
        facing = (_t.x < x) ? -1 : 1;
        charge_state = "telegraph";
        charge_timer = 30;
        return true;
    }

    return false;
};
