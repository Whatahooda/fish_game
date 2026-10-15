draw_ocean = false;
paused = false;
ocean_sprite = spr_ocean;
ocean_sprite_width = sprite_get_width(ocean_sprite);
sprites_to_draw = room_width / ocean_sprite_width + 1;
ocean_speed = room_width / 5;

ocean_position_x = 0;
ocean_position_y = room_height / 2;
