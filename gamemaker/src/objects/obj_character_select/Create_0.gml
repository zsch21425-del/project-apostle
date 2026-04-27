// =============================================================
// obj_character_select — Create
// 4 disciples in a row. Peter is enabled in MVP; the others are
// flagged enabled=false but still selectable for testing —
// they spawn with their stub moveset (single basic jab).
// =============================================================

slots = [
    { name: "PETER",   color: make_color_rgb(160,  80,  60), obj: obj_player_peter,   enabled: true,
      blurb: "The Rock — heavy, slow, hits like a hammer." },
    { name: "JOHN",    color: make_color_rgb(200, 200, 220), obj: obj_player_john,    enabled: false,
      blurb: "The Beloved — balanced staff fighter. (stub)" },
    { name: "JAMES",   color: make_color_rgb(110, 140, 200), obj: obj_player_james,   enabled: false,
      blurb: "Son of Thunder — five-hit lightning flurry. (stub)" },
    { name: "MATTHEW", color: make_color_rgb(180, 150,  70), obj: obj_player_matthew, enabled: false,
      blurb: "Tax Collector — mixed melee and coin throws. (stub)" }
];
cursor = 0;
