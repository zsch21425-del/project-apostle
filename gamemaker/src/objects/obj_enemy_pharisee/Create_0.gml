// =============================================================
// obj_enemy_pharisee — Buffs allies, prideful
// Each step, finds non-pharisee enemies within 120px and sets
// their damage_buff to 1.4 for one frame (refreshed every tick).
// Low pray chance — pharisees rarely repent.
// =============================================================

event_inherited();

char_name  = "Pharisee";
body_color = make_color_rgb(70, 70, 90);

hp_max       = 35;
hp           = hp_max;
damage       = 8;
move_speed   = 2;
pray_chance  = 0.15;

ambient_per_step = function() {
    with (obj_enemy_parent) {
        if (id != other.id
            && object_index != obj_enemy_pharisee
            && state != ESTATE_PRAY
            && state != ESTATE_FLEE
            && point_distance(x, y, other.x, other.y) < 120) {
            damage_buff = 1.4;
        }
    }
};
