//draw_sprite(spr_debug_cross, 0, xprevious, yprevious);
if (face_movement_direction && image_angle != target_direction)
{
	if (follow_path)
	{
		image_angle = point_direction(xprevious, yprevious, x, y);
	}
	else image_angle = target_direction;
}

draw_self();