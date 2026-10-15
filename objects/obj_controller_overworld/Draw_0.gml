// Food Box
draw_set_alpha(.5);
draw_set_colour(c_black);
draw_rectangle(food_box_x1,
	food_box_y1,
	food_box_x2,
	food_box_y2,
	false
);
draw_set_alpha(1);
draw_set_colour(c_white);

// Pips
for (var i = 0; i < food_max; i++) {
    draw_sprite(food_pip_sprite, (i + 1 <= food_current) ? 1 : 0, food_x - food_pip_width / 2 + food_pip_spacing * i, food_y);
}
