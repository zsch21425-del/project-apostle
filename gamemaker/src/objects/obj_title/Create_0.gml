// =============================================================
// obj_title — Create
// MVP title screen. Press Enter to advance to character select.
// DEBUG_FAST_BOOT skips this entirely.
// =============================================================

// Spawn the persistent save manager on first boot
if (!instance_exists(obj_save_manager)) {
    instance_create_layer(0, 0, "Instances", obj_save_manager);
}

if (DEBUG_FAST_BOOT) {
    room_goto(rm_galilee);
}

pulse = 0;
