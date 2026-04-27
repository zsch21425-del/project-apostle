// =============================================================
// obj_jesus_mentor — Step
// Slow upward drift, fade out, self-destruct.
// =============================================================

y += y_drift;
lifetime--;
if (lifetime < 60) fade -= 0.02;
if (lifetime <= 0) instance_destroy();
