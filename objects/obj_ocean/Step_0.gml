if (!paused)
{
	ocean_position_x -= ocean_speed * GetDeltaTimeSeconds();
	if (ocean_position_x < -ocean_sprite_width) ocean_position_x += ocean_sprite_width;
}
