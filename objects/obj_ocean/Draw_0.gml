if (draw_ocean)
{
	for (var i = 0; i < sprites_to_draw; i++) {
	    draw_sprite(ocean_sprite, 0, ocean_position_x + i * ocean_sprite_width, ocean_position_y);
	}
}