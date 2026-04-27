// =============================================================
// obj_character_select — Step
// =============================================================

if (keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(0, gp_padl)) {
    cursor = (cursor + array_length(slots) - 1) mod array_length(slots);
}
if (keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0, gp_padr)) {
    cursor = (cursor + 1) mod array_length(slots);
}

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)
 || keyboard_check_pressed(ord("X")) || gamepad_button_check_pressed(0, gp_face1)) {
    global.selected_player_obj = slots[cursor].obj;
    room_goto(rm_galilee);
}
