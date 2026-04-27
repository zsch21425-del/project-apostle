// =============================================================
// obj_jesus_mentor — Draw
// Placeholder: a soft white pillar of light with a halo.
// Replace with a real sprite (The Chosen-style portrait) later.
// =============================================================

draw_set_alpha(fade * 0.6);
draw_set_color(make_color_rgb(255, 250, 220));
draw_circle(x, y - 20, 36, false);

draw_set_alpha(fade);
draw_set_color(make_color_rgb(255, 240, 200));
draw_rectangle(x - 16, y - 60, x + 16, y, false);

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(x, y - 80, "JESUS");
draw_set_halign(fa_left);
draw_set_alpha(1);
