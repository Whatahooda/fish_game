if (visible)
{
	// Drawing bg
	draw_set_colour(bg_color);
	draw_rectangle(inventory_box_x1,
		inventory_box_y1,
		inventory_box_x2,
		inventory_box_y2,
		false
	);
	draw_set_colour(c_white);

	// Drawing tiles
	for (var _row = 0; _row < inventory_height; _row++) {
	    for (var _col = 0; _col < inventory_width; _col++) {
		    draw_sprite_ext(tile_sprite, 0,
				GetColumnPosition(_col),
				GetRowPosition(_row),
				tile_scale, tile_scale, 0, c_white, 1
			);
		}
	}

	if (highlight_tile)
	{
		draw_sprite_ext(tile_sprite, 1,
			x + inventory_edge_padding + highlighted_col * INVENTORY_TILE_SIZE,
			y + inventory_edge_padding + highlighted_row * INVENTORY_TILE_SIZE,
			tile_scale, tile_scale, 0, c_white, 1
		);
	}
	
	if (draw_reward_box)
	{
		draw_set_colour(bg_color);
		draw_rectangle(inventory_reward_x1, inventory_reward_y1, inventory_reward_x2, inventory_reward_y2, false);
		draw_set_colour(c_white);
	}
}
