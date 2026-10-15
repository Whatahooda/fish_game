if (obj_mouse_controller.mouse_mode == MOUSE_MODE.HOLDING_FISH)
{
	if (point_in_rectangle(mouse_x, mouse_y, food_box_x1, food_box_y1, food_box_x2, food_box_y2))
	{
		draw_chomp = true;
		if (mouse_check_button_released(mb_left))
		{
			draw_chomp = false;
			food_current = clamp(food_current + obj_mouse_controller.held_instance.food_value, 0, food_max);
			instance_destroy(obj_mouse_controller.held_instance);
			obj_mouse_controller.held_instance = noone;
			obj_mouse_controller.mouse_mode = MOUSE_MODE.DEFAULT;
		}
	}
	else draw_chomp = false;
}

if (draw_chomp) cursor_sprite = spr_mouse_chomp;
else cursor_sprite = cr_none;
