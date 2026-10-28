if (active)
{
	projectile_current_time += GetDeltaTimeSeconds() * time_scale;
	// Feather disable once GM1019
	if (do_move_step) ProjectileMoveStep(projectile_current_time);
	if (x < 0 ||
		x > room_width ||
		y < 0 ||
		y > room_height ||
		(follow_path && path_position == 1)
	)
	{
		ProjectileFinish();
	}
	
	if (face_movement_direction && image_angle != target_direction) image_angle = target_direction;
	
	if (fade)
	{
		image_alpha -= fade_strength * GetDeltaTimeSeconds();
		if (image_alpha <= 0) instance_destroy(self);
	}
}
