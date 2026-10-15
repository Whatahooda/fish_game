if (lifetime > 0) lifetime -= GetDeltaTimeSeconds();
else if (image_alpha > 0) image_alpha -= fade_strength * GetDeltaTimeSeconds();
else instance_destroy(self);

image_xscale += scale_strength * GetDeltaTimeSeconds();
image_yscale += scale_strength * GetDeltaTimeSeconds();
image_angle += anngle_strength * GetDeltaTimeSeconds();

if (abs(vel_x) > 0.1)
{
	vel_x *= fric;
	x += vel_x;
}

if (abs(vel_y) > 0.1)
{
	vel_y *= fric;
	y += vel_y;
}
