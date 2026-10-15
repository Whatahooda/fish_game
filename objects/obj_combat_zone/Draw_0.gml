if (draw_combat_zone)
{
	draw_set_alpha(.7);
	draw_set_colour(c_black);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_alpha(1);
	draw_set_colour(c_white);
	
	draw_sprite_ext(sprite_index, image_index, x, y, combat_zone_xscale, combat_zone_yscale, image_angle, image_blend, image_alpha);
}