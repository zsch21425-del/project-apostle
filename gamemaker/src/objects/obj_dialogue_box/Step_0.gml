// =============================================================
// obj_dialogue_box — Step
// =============================================================

if (instance_exists(obj_pause_menu) && obj_pause_menu.paused) exit;

if (fade_in < 1) fade_in += 0.08;

lifetime--;

// Skip / dismiss
if (keyboard_check_pressed(vk_enter)
 || keyboard_check_pressed(vk_space)
 || keyboard_check_pressed(ord("X"))
 || gamepad_button_check_pressed(0, gp_face1)) {
    instance_destroy();
}

if (lifetime <= 0) instance_destroy();
