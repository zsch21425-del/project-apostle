// =============================================================
// obj_hideout — Step
// Cycles through the dialogue lines, then advances to next level.
// =============================================================

torch_phase += 0.05;
prompt_pulse += 0.06;

if (keyboard_check_pressed(vk_enter)
 || keyboard_check_pressed(vk_space)
 || keyboard_check_pressed(ord("X"))
 || gamepad_button_check_pressed(0, gp_face1)) {
    dialogue_index++;
    if (dialogue_index >= array_length(dialogue)) {
        room_goto(next_room);
    }
}
