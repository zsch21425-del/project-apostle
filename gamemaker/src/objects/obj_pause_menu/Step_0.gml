// =============================================================
// obj_pause_menu — Step
// Toggle on Esc / Start. Cursor moves with up/down. Confirm with
// Enter / X / face1.
// =============================================================

if (input_pause(0)) paused = !paused;

if (!paused) exit;

if (keyboard_check_pressed(vk_up)   || gamepad_button_check_pressed(0, gp_padu)) {
    cursor = (cursor + array_length(options) - 1) mod array_length(options);
}
if (keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0, gp_padd)) {
    cursor = (cursor + 1) mod array_length(options);
}

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)
 || keyboard_check_pressed(ord("X")) || gamepad_button_check_pressed(0, gp_face1)) {
    switch (cursor) {
        case 0: paused = false; break;
        case 1: paused = false; room_restart(); break;
        case 2: paused = false; room_goto(rm_title); break;
    }
}
