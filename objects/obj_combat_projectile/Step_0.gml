if (active)
{
	projectile_current_time += GetDeltaTimeSeconds() * time_scale;
	ProjectileMoveStep(projectile_current_time);
	if (x < 0 || x > room_width || y < 0 || y > room_height) ProjectileFinish();
	
	if (face_movement_direction && image_angle != target_direction) image_angle = target_direction;
	
	if (fade)
	{
		image_alpha -= fade_strength * GetDeltaTimeSeconds();
		if (image_alpha <= 0) instance_destroy(self);
	}
}
