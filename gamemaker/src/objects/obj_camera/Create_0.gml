// =============================================================
// obj_camera — Create
// Smooth scrolling, screen shake, no-backtrack lock.
// Place ONE instance in each gameplay room.
// =============================================================

view_w       = VIEW_W;
view_h       = VIEW_H;
shake_amount = 0;
shake_decay  = 0.5;
follow_smooth = 0.12;

// Position the camera based on the first player on screen
x = 0;
y = 0;

// Wave-lock: when locked, camera will not advance past locked_x.
// obj_controller flips this on/off as waves spawn / clear.
locked = false;
locked_x = 0;

// Initialise the room view to match
if (view_enabled && view_visible[0]) {
    camera_set_view_size(view_camera[0], view_w, view_h);
    camera_set_view_pos(view_camera[0], 0, 0);
}
