// =============================================================
// obj_title — Step
// =============================================================

pulse += 0.05;

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)
 || gamepad_button_check_pressed(0, gp_face1)) {
    room_goto(rm_select);
}
