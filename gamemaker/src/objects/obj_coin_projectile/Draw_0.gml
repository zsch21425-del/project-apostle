// Spinning gold coin placeholder
draw_set_color(make_color_rgb(255, 215, 80));
var _w = 8 + abs(cos(degtorad(spin))) * 4;
draw_ellipse(x - _w, y - 8, x + _w, y + 8, false);
draw_set_color(make_color_rgb(180, 140, 30));
draw_ellipse(x - _w, y - 8, x + _w, y + 8, true);
draw_set_color(c_white);
