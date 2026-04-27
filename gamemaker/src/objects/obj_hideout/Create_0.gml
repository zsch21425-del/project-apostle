// =============================================================
// obj_hideout — Create
// Splinter / mentor hub. The candlelit cellar where Jesus and the
// disciples meet between levels. Place this as the only instance
// in rm_hideout. Press Enter to advance to the next level.
// =============================================================

torch_phase = 0;
prompt_pulse = 0;

dialogue = [
    { speaker: "Jesus",
      text: "Rest, brothers. The road ahead is hard, but you are not walking it alone." },
    { speaker: "Peter",
      text: "Lord — I will follow you, even unto death." },
    { speaker: "John",
      text: "Where else would we go? You have the words of eternal life." }
];
dialogue_index = 0;

// Pick the next level to travel to based on save state
next_room = rm_galilee;
if (variable_global_exists("last_completed_room")) {
    switch (global.last_completed_room) {
        case "rm_galilee":     next_room = rm_wilderness; break;
        case "rm_wilderness":  next_room = rm_temple;     break;
        case "rm_temple":      next_room = rm_win;        break;
        default:               next_room = rm_galilee;    break;
    }
}
