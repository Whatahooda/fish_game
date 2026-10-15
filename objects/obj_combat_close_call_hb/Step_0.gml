if (alpha_buffer > 0)
{
	alpha_buffer -= GetDeltaTimeSeconds() * .25;
}

image_alpha = clamp(alpha_buffer, 0, .25);